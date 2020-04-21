//
//  DDBaseViewController.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/8/25.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "DDBaseViewController.h"
#import "DDBaseNavigationController.h"

@interface DDBaseViewController ()
@property (nonatomic,strong)UIImageView *bgImageView;
@end

@implementation DDBaseViewController

- (instancetype)init{
    if (DDisiPad) {
        NSString *nibName = [NSString stringWithFormat:@"%@_iPad",self.className];
        NSString *nibPath = [[NSBundle mainBundle] pathForResource:nibName ofType:@"nib"];
        if (nibPath && nibPath.length>0) {
            self = [super initWithNibName:nibName bundle:nil];
        }else{
            self = [super init];
        }
    }else{
        self = [super init];
    }
    //默认为竖屏
    self.dd_isPortrait = YES;
    //解决iOS13不全屏问题
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    return self;
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    NSLog(@"收到内存警告：didReceiveMemoryWarning->%@",self.className);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加tabbar双击监听
    [self addTabbarDCNotification];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //为了方便定位问题，后期可以降低日志等级
    NSLog(@"页面事件viewWillAppear->%@",self.className);
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //为了方便定位问题，后期可以降低日志等级
    NSLog(@"页面事件viewWillDisappear->%@",self.className);
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - ......::::::: loading (菊花设置) 后期可考虑注册方式 :::::::......
/**
 显示默认的加载框
 */
- (DDProgressHUD *)showLoading{
    return [self showLoading:kLoadingResourceName];
}

/**
 显示loading 自定义文字. 在哪个 View 弹出
 
 @param str 文字
 @param view 父视图
 */
- (DDProgressHUD *)showLoading:(NSString *)str inView:(UIView *)view{
    if (!str){
        str = [self findStringBy:kLoadingResourceName];
    }
    NSString *tips = [self findStringBy:str];
    return [DDProgressHUD showLoading:tips inView:view];
}

/**
 显示loading 自定义文字
 
 @param str 自定义文字
 */
- (DDProgressHUD *)showLoading:(NSString *)str{
    return  [self showLoading:str inView:self.view];
}


/**
 取消loading
 */
- (void)dismissLoading{
    [self dismissLoadingInView:self.view];
}

/**
 取消loading
 */
- (void)dismissLoadingInView:(UIView *)view{
    if (view) {
        [DDProgressHUD dismissLoading:view];
    }
}

//加载中...
static NSString *const kLoadingResourceName = @"loading_resource_name";

#pragma mark - ......::::::: Localizable.string 文本查找 :::::::......
/**
 文本查找
 
 @param resKey 文本资源key
 @return 资源文本
 */
- (NSString *)findStringBy:(NSString *)resKey{
    NSString *value = NSLocalizedString(resKey, @"");
    return value;
}


#pragma mark - ......::::::: 导航栏视图 :::::::......
/**
 整屏幕导航
 @return DDNavigationBarView
 */
-(DDNavigationBarView *)addCustomNavigationBar{
    return [self addCustomNavigationBar:self.title];
}

/**
 整屏幕导航
 @param title 标题
 @return DDNavigationBarView
 */
-(DDNavigationBarView *)addCustomNavigationBar:(NSString *)title{
    self.title = title;
    DDNavigationBarView *naviView = [DDNavigationBarView navigationBarView:title];
    [self.view addSubview:naviView];
    //[self.view setBackgroundColor:[UIColor clearColor]];
    @weakify(self);
    [naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(@(kCustonNavigationBarHeight));
    }];
    [naviView addBackSender:^{
        @strongify(self);
//        [self dd_popViewControllerAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.customNavigationBar = naviView;
    return self.customNavigationBar;
}

/**
 整屏幕导航
 @param title 标题
 @param color 颜色
 @param backImage 返回按钮图片
 @return DDNavigationBarView
 */
-(DDNavigationBarView *)addCustomNavigationBar:(NSString *)title titleColor:(UIColor *)color backImage:(UIImage * _Nullable)backImage {
    self.title = title;
    DDNavigationBarView *naviView = [DDNavigationBarView navigationBarView:title titleColor:color backImage:backImage];
    [self.view addSubview:naviView];
    //[self.view setBackgroundColor:[UIColor clearColor]];
    @weakify(self);
    [naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(@(kCustonNavigationBarHeight));
    }];
    [naviView addBackSender:^{
        @strongify(self);
//        [self dd_popViewControllerAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.customNavigationBar = naviView;
    return self.customNavigationBar;
}

/**
 只显示单个返回按钮
 @param backImageName 返回按钮图片
 @return DDNavigationBarView
 */
-(DDNavigationBarView *)addCustomOnlyBackNavigationBar:(NSString *)backImageName{
    DDNavigationBarView *naviBar = [self addCustomNavigationBar];
    @weakify(self);
    [naviBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.width.mas_equalTo(100);
        make.left.top.mas_equalTo(self.view);
        make.height.mas_equalTo(@(kCustonNavigationBarHeight));
    }];
    [naviBar setBackImageName:backImageName];
    return naviBar;
}

-(void)setTitle:(NSString *)title{
    [super setTitle:title];
    if (self.customNavigationBar) {
        [self.customNavigationBar updateTitle:title];
    }
}

#pragma mark - ......::::::: 背景 :::::::......
/** 初始化背景 imageView */
-(void)initBackGroundImageView{
//    self.bgImageView = [[DDThemeImageView alloc] init];
//    [self.view addSubview:self.bgImageView];
//    [self.view sendSubviewToBack:self.bgImageView];
//    @weakify(self);
//    [self.bgImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
//        make.edges.equalTo(self.view);
//    }];
}

/** 隐藏背景 imageView */
-(void)hiddenBackGroundImageView{
    if (self.bgImageView) {
        [self.bgImageView setHidden:YES];
    }
}

/** 获取背景 imageView */
-(UIImageView *)backGroundImageView{
    return self.bgImageView;
}


#pragma mark - ......::::::: 屏幕旋转 :::::::......
-(BOOL)shouldAutorotate{
    return NO;
}

-(UIStatusBarAnimation)preferredStatusBarUpdateAnimation{
    return UIStatusBarAnimationSlide;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

-(BOOL)prefersStatusBarHidden{
    return !self.dd_isPortrait;
}

#pragma mark - ......::::::: tabbar双击事件 :::::::......
/// 监听tabbar双击监听
-(void)addTabbarDCNotification{
    //注册tabbar双击事件
//    [DDNotificationManager addObserver:self
//                              selector:@selector(refreshTabbarNotification:)
//                                  name:kDDNotificationTabItemDoubleClick
//                                object:nil];
}

/// 刷新最新数据
-(void)refreshTabbarNotification:(NSNotification *)notification{
    UINavigationController *navi = notification.object;
    if (self.navigationController == navi) {
        [self onTabbarDoubleClickImpl];
    }
}

/// 当前类执行了Tabbar双击刷新
-(void)onTabbarDoubleClickImpl{
    NSLog(@"执行了tabbar双击...");
}

@end

