//
//  DDPermissionManager.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/22.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DDPermissBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@protocol DDPermissionManagerNetDelegate <NSObject>

-(void)onNetPermissionSuccess:(BOOL)isNetSuccess;

@end

@interface DDPermissionManager : NSObject

+ (instancetype)sharePermissionManager;


/** Camera 是否可用（没有被抢占）*/
+(BOOL)isCameraAvailable;

/**
 检查麦克风权限
 
 @param successHandler 有权限的回调
 */
-(instancetype)checkMicrophonePermission:(DDPermissBlock)successHandler fail:(DDPermissBlock)failBlock;

/**
 检查相机权限
 
 @param successHandler 成功回调
 @param failBlock 失败回调
 @return 对象
 */
-(instancetype)checkCameraPermission:(DDPermissBlock)successHandler fail:(DDPermissBlock)failBlock;


/**
 检查相册权限
 
 @param successHandler 成功回调
 @param failBlock 失败回调
 @return 对象
 */
-(instancetype)checkPhotoPermission:(DDPermissBlock)successHandler fail:(DDPermissBlock)failBlock;


///**
// 检查联系人权限
//
// @param successHandler 成功回调
// @param failBlock 失败回调
// @return 对象
// */
//-(instancetype)checkContactPermission:(DDPermissBlock)successHandler fail:(DDPermissBlock)failBlock;


/**
 检查定位权限
 
 @param successHandler 成功回调
 @param failBlock 失败回调
 @return 对象
 */
-(instancetype)checkLocationPermission:(DDPermissBlock)successHandler fail:(DDPermissBlock)failBlock;


/**
 检查通知权限
 
 @param successHandler 成功回调
 @param failBlock 失败回调
 @return 对象
 */
-(instancetype)checkNotificationPermission:(DDPermissBlock)successHandler fail:(DDPermissBlock)failBlock;

/**
 获取当前通知权限的装填
 */
-(UIUserNotificationType)getNotificationPermission;

/**
 显示权限对话框
 
 @param tips 提示内容
 */
-(void)showNoPermissionDialogWithTips:(NSString *)tips;

/**
 显示权限对话框
 
 @param title 标题
 @param tips 提示内容
 @param leftTips 左按钮字段
 @param rightTips 右按钮字段
 @param cancelBlock 取消按钮点击回调
 */
-(void)showNoPermissionDialogWithTitle:(NSString *)title
                                  tips:(NSString *)tips
                              leftTips:(NSString *)leftTips
                             rightTips:(NSString *)rightTips
                                cancel:(void(^ _Nullable)(void))cancelBlock;

/**
 显示权限对话框
 
 @param title 标题
 @param tips 提示内容
 @param leftTips 左按钮字段
 @param rightTips 右按钮字段
 @param confirmBlock 确认按钮点击回调
 @param cancelBlock 取消按钮点击回调
 */
-(void)showNoPermissionDialogWithTitle:(NSString *)title
                                  tips:(NSString *)tips
                              leftTips:(NSString *)leftTips
                             rightTips:(NSString *)rightTips
                               confirm:( void(^ _Nullable)(void))confirmBlock
                                cancel:( void(^ _Nullable)(void))cancelBlock;
/**
 打开系统设置
 @return 能否打开
 */
+(BOOL)openPermissionSetting;
@end

NS_ASSUME_NONNULL_END

