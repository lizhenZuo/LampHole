//
//  DDBaseNavigationController.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/8/25.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "DDBaseNavigationController.h"

@interface DDBaseNavigationController ()<UINavigationControllerDelegate>

@end

@implementation DDBaseNavigationController

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        
        //解决iOS13不全屏问题
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)initNavigationBar{
    self.delegate = self;
    self.interactivePopGestureRecognizer.enabled = NO;
    [self.navigationBar setBackgroundColor:[UIColor whiteColor]];
}

#pragma mark - ......::::::: 返回按钮 :::::::......
- (UIBarButtonItem *)backBarButtonItem{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置图片
    UIImage *imageNormal = [UIImage imageNamed:@"navi_back_n"];
    UIImage *imageHigh = [UIImage imageNamed:@"navi_back_h"];
    [backBtn setImage:imageNormal forState:UIControlStateNormal];
    [backBtn setImage:imageHigh forState:UIControlStateHighlighted];
    CGFloat width = 50;
    [backBtn setFrame:CGRectMake(0, 0, width, 44)];
    CGFloat left = width - imageNormal.size.width;
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -left, 0, 0)];
    [backBtn addTarget:self action:@selector(handleBackSender) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

-(void)handleBackSender{
    if(self.viewControllers.count>1){
        [self popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - ......::::::: 屏幕旋转 :::::::......
-(BOOL)prefersStatusBarHidden{
     return NO;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(self.viewControllers.count > 0){
        //隐藏tabbar导航
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //返回按钮样式
    viewController.navigationItem.leftBarButtonItem = [self backBarButtonItem];
    [super pushViewController:viewController animated:animated];
}

#pragma mark - ......::::::: UINavigationControllerDelegate  :::::::......
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController.dd_isHiddenNaviBar) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    } else {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
}


@end
