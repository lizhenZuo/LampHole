//
//  DDShareCommonHelper.h
//  AiTeacheriPhone
//
//  Created by tms on 2018/6/6.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "DDBaseModel.h"

@interface DDShareCommonHelper : DDBaseModel

+ (instancetype)shareInstance;

/**
 是否是新用户
 */
+ (BOOL)isFirstLogin;

/**
 设置用户状态
 */
+ (void)updateLoginStauts:(BOOL)isFirstLogin;

@end
