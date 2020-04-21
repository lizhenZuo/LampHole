//
//  DDProgressHUD.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/13.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kLoadingTips;

@interface DDProgressHUD : MBProgressHUD

/**
 显示弹窗 (默认文本 加载中...)
 @param view 视图
 */
+(DDProgressHUD *)showLoading:(UIView *)view;

/**
 显示弹窗
 @param tips 内容
 @param view 视图
 */
+ (DDProgressHUD *)showLoading:(NSString *)tips inView:(UIView *)view;

/**  显示 */
+(DDProgressHUD *)showHUD:(MBProgressHUD *)hud;

/** 隐藏 */
+ (void)dismissLoading:(UIView *)view;

/**
 window显示loading (默认文本 加载中...)
 */
+(DDProgressHUD *)showWindowLoading;
/**
 window显示loading
 @param tips loading文本
 */
+(DDProgressHUD *)showWindowLoading:(NSString *)tips;

/**
 window消失loading
 */
+(void)dismissWindowLoading;

@end
