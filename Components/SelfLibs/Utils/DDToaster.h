//
//  DDToaster.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/8/29.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DDTosterBlock)(void);

typedef NS_ENUM(NSInteger,ShowToasterType){
    // 1、获取注册验证码
    ShowToastLength_Normal = 1,
    //2、获取登录验证码
    ShowToastLength_Long = 2,
    
};

@interface DDToaster : NSObject

/**
 显示文本toast
 
 @param text 文本
 */
+ (void)showWindowToastWithText:(NSString *)text;


/**
 显示文本toast
 
 @param text 文本
 @param completionBlock 结束block
 */
+ (void)showWindowToastWithText:(NSString *)text
                completionBlock:(DDTosterBlock)completionBlock;

/**
 显示文本toast
 
 @param text 文本
 @param toasterType 显示时长
 */
+ (void)showWindowToastWithText:(NSString *)text
                    toasterType:(ShowToasterType)toasterType;
/**
 显示文本toast
 
 @param text 文本
 @param toasterType 显示时长
 @param completionBlock 结束block
 */
+ (void)showWindowToastWithText:(NSString *)text
                    toasterType:(ShowToasterType)toasterType
                completionBlock:(DDTosterBlock)completionBlock;

@end

