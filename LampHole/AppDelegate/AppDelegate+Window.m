//
//  AppDelegate+Window.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/3.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "AppDelegate+Window.h"
#import "DDBaseNavigationController.h"
#import "SSLLoginViewController.h"
#import "HomeTabbarViewController.h"

@implementation AppDelegate (Window)

/**
 单例
 */
+ (instancetype)sharedAppDelegate{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

-(void)startRootViewController:(UIWindow *)window
{
    LHUserModel *user = [[DDUserDBManager shareInstance] getLoginUser];
    if (user.isLogin) {
        [self startHomeViewController:window];
    }
    else {
        [self startLoginViewController:window];
    }
}

/**
 首页
 */
-(void)startHomeViewController:(UIWindow *)window{
    HomeTabbarViewController *ctrl = [[HomeTabbarViewController alloc] init];
    [window setRootViewController:ctrl];
}

/**
 登录页
 */
-(void)startLoginViewController:(UIWindow *)window{
    SSLLoginViewController *ctrl = [[SSLLoginViewController alloc] init];
    DDBaseNavigationController *navi = [[DDBaseNavigationController alloc] initWithRootViewController:ctrl];
    [window setRootViewController:navi];
}

-(void)logoutUser{
//    [DDCommonUtils logout];
    //跳转到登录也
    [self startLoginViewController:self.window];

}

/**
 顶部视图
 */
- (UIViewController *)topViewController{
    return [self topViewControllerWithRootViewController:self.window.rootViewController];
}

/**
 获取当前活动的navigationViewController
 */
- (UINavigationController *)navigationViewController{
    if ([self.window.rootViewController isKindOfClass:[UINavigationController class]]){
        return (UINavigationController *)self.window.rootViewController;
    }else if ([self.window.rootViewController isKindOfClass:[UITabBarController class]]){
        UIViewController *selectVc = [((UITabBarController *)self.window.rootViewController) selectedViewController];
        if ([selectVc isKindOfClass:[UINavigationController class]]){
            return (UINavigationController *)selectVc;
        }
    }
    return nil;
}

/// 获取当前显示的页面Vc
/// @param rootViewController window rootVc
- (UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootViewController{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {

        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if (rootViewController.presentedViewController) {

        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {

        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else {

        return rootViewController;
    }
}

/**
 跳入相应的页面
 @param viewController 视图
 @param animated 是否动画
 */
-(void)dd_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController *topVc = self.topViewController;
    if (topVc && [topVc isKindOfClass:DDBaseViewController.class]) {
        DDBaseViewController *fromVC = (DDBaseViewController *)topVc;
        [fromVC dd_pushViewController:viewController animated:YES];
    }else{
        [topVc presentViewController:viewController animated:YES completion:nil];
    }
}

@end
