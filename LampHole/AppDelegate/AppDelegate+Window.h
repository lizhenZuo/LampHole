//
//  AppDelegate+Window.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/3.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (Window)

/**
 单例
 */
+ (instancetype)sharedAppDelegate;

/**
 跳转到主页面 登录用户判断
 */
-(void)startRootViewController:(UIWindow *)window;

/**
 首页
 */
-(void)startHomeViewController:(UIWindow *)window;

/**
 登录页
 */
-(void)startLoginViewController:(UIWindow *)window;


/**
 退出登录
 */
-(void)logoutUser;

/**
 顶部视图
 */
- (UIViewController *)topViewController;

/**
 获取当前活动的navigationViewController
 */
- (UINavigationController *)navigationViewController;

/**
 跳入相应的页面
 @param viewController 视图
 @param animated 是否动画
 */
-(void)dd_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end
