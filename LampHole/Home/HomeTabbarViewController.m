//
//  HomeTabbarViewController.m
//  LampHole
//
//  Created by dingdong on 2019/12/18.
//  Copyright © 2019 dingdong. All rights reserved.
//

#import "HomeTabbarViewController.h"
#import "DDBaseNavigationController.h"
//#import "LHFirstHomeViewController.h"
#import "LHCategoryHomeViewController.h"
#import "LHSecondHomeViewController.h"
#import "LHSceneHomeViewController.h"

@interface HomeTabbarViewController () <UITabBarControllerDelegate>

@end

@implementation HomeTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    self.tabBar.layer.borderWidth = 0.50;
    self.tabBar.layer.borderColor = OurUIColor(0xc3c3c3, 1).CGColor;
    self.tabBar.barStyle = UIBarStyleDefault;
    
//    [self configureTabBar];
}

-(void)configureTabBar
{
//    CGFloat offset = 0.0f;
    NSMutableArray *arrayVC = [[NSMutableArray alloc] init];
    
    LHCategoryHomeViewController *vc1 = [[LHCategoryHomeViewController alloc] init];
//    vc1.tabBarItem.image =[[UIImage imageNamed:@"home_tab_home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc1.tabBarItem.selectedImage = [[UIImage imageNamed:(@"home_tab_home_select")] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc1.tabBarItem.imageInsets = UIEdgeInsetsMake(offset, 0, -offset, 0);
//    vc1.navigationController.navigationBar.hidden = YES;
    vc1.tabBarItem.title = @"首页";
//    [vc1.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:OurUIColor(0xf36e4b, 1),NSForegroundColorAttributeName, nil]  forState:UIControlStateSelected];
//    [vc1.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:OurUIColor(0x7c7c7c, 1),NSForegroundColorAttributeName, nil]  forState:UIControlStateNormal];
    [arrayVC addObject:vc1];
    
    LHSecondHomeViewController *vc2 = [[LHSecondHomeViewController alloc] init];
//    vc2.tabBarItem.image =[[UIImage imageNamed:@"home_tab_mall_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc2.tabBarItem.selectedImage = [[UIImage imageNamed:(@"home_tab_mall_select")] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc2.tabBarItem.imageInsets = UIEdgeInsetsMake(offset, 0, -offset, 0);
//    vc2.navigationController.navigationBar.hidden = YES;
    vc2.tabBarItem.title = @"礼物兑换";
//    [vc2.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:OurUIColor(0xf36e4b, 1),NSForegroundColorAttributeName, nil]  forState:UIControlStateSelected];
//    [vc2.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:OurUIColor(0x7c7c7c, 1),NSForegroundColorAttributeName, nil]  forState:UIControlStateNormal];
    [arrayVC addObject:vc2];
    
    LHSceneHomeViewController *vc3 = [[LHSceneHomeViewController alloc] init];
//    vc3.tabBarItem.image =[[UIImage imageNamed:@"home_tab_purchase_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc3.tabBarItem.selectedImage = [[UIImage imageNamed:(@"home_tab_purchase_select")] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc3.tabBarItem.imageInsets = UIEdgeInsetsMake(offset, 0, -offset, 0);
//    vc3.navigationController.navigationBar.hidden = YES;
    vc3.tabBarItem.title = @"课时购买";
//    [vc3.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:OurUIColor(0xf36e4b, 1),NSForegroundColorAttributeName, nil]  forState:UIControlStateSelected];
//    [vc3.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:OurUIColor(0x7c7c7c, 1),NSForegroundColorAttributeName, nil]  forState:UIControlStateNormal];
    [arrayVC addObject:vc3];
    
    self.viewControllers = arrayVC;
}

#pragma mark - ......::::::: UI :::::::......
-(void)initUI{
    self.delegate = self;
    self.tabBar.opaque = YES;
    self.tabBar.shadowImage = [UIImage new];
//    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabar_bg"];
    self.tabBar.translucent = NO;
    
    //第一个
    DDBaseNavigationController *firstNav = [self addChildVc:[[LHCategoryHomeViewController alloc] init]
                                                     title:@"单灯"
                                                     image:@"main_tabbar_home_n@2x.png"
                                                    sImage:@"main_tabbar_home_s@2x.png"];
    //第二个
    DDBaseNavigationController *secondNav = [self addChildVc:[[LHSecondHomeViewController alloc] init]
                                                       title:@"组灯"
                                                       image:@"main_tabbar_lesson_n@2x.png"
                                                      sImage:@"main_tabbar_lesson_s@2x.png"];
    //第三个
    DDBaseNavigationController *thirdNav = [self addChildVc:[[LHSceneHomeViewController alloc] init]
                                                     title:@"模式"
                                                     image:@"main_tabbar_find_n@2x.png"
                                                    sImage:@"main_tabbar_find_s@2x.png"];
    
    self.viewControllers = @[firstNav,secondNav,thirdNav];
}

/**
  添加子控制器
 @param childVc 自控制器
 @param title 标题
 @param imageName 图片
 @param sImageName 选中图片
 @return DDBaseNavigationController
 */
-(DDBaseNavigationController *)addChildVc:(UIViewController *)childVc
                                    title:(NSString *)title
                                    image:(NSString *)imageName
                                   sImage:(NSString *)sImageName{
    //设置属性
    UIColor *ncolor = DDColorHex(kDDColor_666666);
    UIColor *scolor = DDColorHex(kDDColor_333333);
    UIImage *nimage = [UIImage imageNamed:imageName];
    UIImage *simage = [UIImage imageNamed:sImageName];
    UIImage *rNimage = [self resizeTabbarItemImage:nimage];
    UIImage *rSimage = [self resizeTabbarItemImage:simage];
    [self setupChildVc:childVc title:title color:ncolor scolor:scolor image:rNimage sImage:rSimage];
    //添加ViewController
    DDBaseNavigationController *nav = [[DDBaseNavigationController alloc] initWithRootViewController:childVc];
    return nav;
}

/// 设置子VC属性
/// @param childVc UIViewController
/// @param title 标题
/// @param color 标题颜色
/// @param scolor 标题选中颜色
/// @param image 图片
/// @param selectedImage 选中图片颜色
-(void)setupChildVc:(UIViewController *)childVc
              title:(NSString *)title
              color:(UIColor *)color
             scolor:(UIColor *)scolor
              image:(UIImage *)image
             sImage:(UIImage *)selectedImage
{
    childVc.title = title;
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    //文字颜色
    textAttrs[NSForegroundColorAttributeName] = color;
    if(DDisiPad){
        if (@available(iOS 11.0, *)) {
            textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:18];
        }else{
            textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
        }
    }else{
        textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    }
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    // 选中时的文字样式
    NSMutableDictionary *sTextAttrs = [NSMutableDictionary dictionary];
    sTextAttrs[NSForegroundColorAttributeName] = scolor;
    [childVc.tabBarItem setTitleTextAttributes:sTextAttrs forState:UIControlStateSelected];
    //设置间距
    [childVc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0,2)];
    if (@available(iOS 13.0, *)) {
        //解决iOS13 返回的时候变为蓝色的bug
        self.tabBar.tintColor = color;
        self.tabBar.unselectedItemTintColor = scolor;
    }
}

-(UIImage *)resizeTabbarItemImage:(UIImage *)image{
    CGFloat height = 33;
    CGFloat width = image.size.width*height/image.size.height;
    return [self imageResizeImage:image size:CGSizeMake(width, height)];
}

-(UIImage *)imageResizeImage:(UIImage *)image size:(CGSize)size{
    CGFloat width = size.width;
    CGFloat height = size.height;
    if (height <= 0) return nil;
    if (image && image.size.height>height) {
        UIImage *rSizeImage = [image sd_resizedImageWithSize:CGSizeMake(width, height) scaleMode:SDImageScaleModeAspectFill];
        return rSizeImage;
    }
    return image;
}

@end
