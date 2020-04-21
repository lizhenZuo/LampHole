//
//  DDBaseViewController.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/8/25.
//  Copyright © 2018年 ddkt365. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "DDProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDBaseViewController : UIViewController

/** 导航控制器 */
@property (weak, nonatomic) DDNavigationBarView *customNavigationBar;
/** 不需要执行旋转代码，自视图时不需要执行设置为YES */
@property (nonatomic, assign) BOOL dd_cannot_orientation;

/// 是否隐藏navigationBar
@property (nonatomic, assign) BOOL dd_isHiddenNaviBar;

/// 是否为竖屏
@property (nonatomic, assign) BOOL dd_isPortrait;

#pragma mark - ......::::::: loading (菊花设置) 后期可考虑注册方式 :::::::......
/** 显示默认的加载框 */
- (DDProgressHUD *)showLoading;

/**
 显示loading 自定义文字. 在哪个 View 弹出
 @param str 文字
 @param view 父视图
 */
- (DDProgressHUD *)showLoading:(NSString *)str inView:(UIView *)view;

/**
 显示loading 自定义文字
 @param str 自定义文字
 */
- (DDProgressHUD *)showLoading:(NSString *)str;

/** 取消loading */
- (void)dismissLoading;

/** 取消loading */
- (void)dismissLoadingInView:(UIView *)view;

#pragma mark - ......::::::: Localizable.string 文本查找 :::::::......
/**
 文本查找
 @param resKey 文本资源key
 @return 资源文本
 */
- (NSString *)findStringBy:(NSString *)resKey;

#pragma mark - ......::::::: 导航栏视图 :::::::......
/**
 整屏幕导航
 @return DDNavigationBarView
 */
-(DDNavigationBarView *)addCustomNavigationBar;

/**
 整屏幕导航
 @param title 标题
 @return DDNavigationBarView
 */
-(DDNavigationBarView *)addCustomNavigationBar:(NSString *)title;

/**
 整屏幕导航
 @param title 标题
 @param color 颜色
 @param backImage 返回按钮图片
 @return DDNavigationBarView
 */
-(DDNavigationBarView *)addCustomNavigationBar:(NSString *)title
                                    titleColor:(UIColor *)color
                                     backImage:(UIImage * _Nullable)backImage;

/**
 只显示单个返回按钮
 @param backImageName 返回按钮图片
 @return DDNavigationBarView
 */
-(DDNavigationBarView *)addCustomOnlyBackNavigationBar:(NSString *)backImageName;


#pragma mark - ......::::::: 背景 :::::::......
/** 初始化背景 imageView */
-(void)initBackGroundImageView;

/** 隐藏背景 imageView */
-(void)hiddenBackGroundImageView;

/** 获取背景 imageView */
-(UIImageView *)backGroundImageView;

/// 当前类执行了Tabbar双击刷新
-(void)onTabbarDoubleClickImpl;

@end

NS_ASSUME_NONNULL_END
