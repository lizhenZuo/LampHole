//
//  UIViewController+DDAddition.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2019/10/24.
//  Copyright © 2019 ddkt365. All rights reserved.
//
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (DDAddition)

/// 是否隐藏navigationBar
@property (nonatomic, assign) BOOL dd_isHiddenNaviBar;

/// 是否为竖屏
@property (nonatomic, assign) BOOL dd_isPortrait;

/// viewWillAppear重新设置方向
- (void)dd_viewWillAppearOrientation;

/// 设置是否显示导航栏
/// @param isHidden YES NO
-(void)dd_setHiddenNavigationBar:(BOOL)isHidden;

#pragma mark - ......::::::: 新增方法 -> 进入新页面 :::::::......
/**
 进入新页面
 @param viewController 新页面
 @param animated 动画
 */
-(BOOL)dd_pushViewController:(UIViewController *_Nonnull)viewController animated:(BOOL)animated;

/**
 进入新页面
 @param viewController 新页面
 @param animated 动画
 @param completionBlk 回到
 @return YES代表竖屏进入 NO代表非竖屏进入
 */
-(BOOL)dd_pushViewController:(UIViewController *_Nonnull)viewController animated:(BOOL)animated completion:(void (^ _Nullable)(void))completionBlk;

#pragma mark - ......::::::: 退出页面 :::::::......
/**
 退出页面
 @param animated 动画
 */
-(void)dd_popViewControllerAnimated:(BOOL)animated;
/**
 退出页面
 @param animated 动画
 @param completionBlk 完成回调
 */
-(void)dd_popViewControllerAnimated:(BOOL)animated completion:(void (^ _Nullable)(void))completionBlk;

@end

NS_ASSUME_NONNULL_END
