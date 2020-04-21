//
//  DDShareCommonHelper.m
//  AiTeacheriPhone
//
//  Created by tms on 2018/6/6.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "DDShareCommonHelper.h"

@implementation DDShareCommonHelper{
    
}


+ (instancetype)shareInstance{
    static id _this = nil;
    static dispatch_once_t onceTokenInit;
    dispatch_once(&onceTokenInit, ^{
        _this = [[self.class alloc] init];
    });
    return _this;
}


/**
 是否是新用户
 */
+ (BOOL)isFirstLogin
{
    NSString *loginKey = [NSString stringWithFormat:@"user_login_%@", [DDUserDBManager shareInstance].getLoginUser.user_name];
    return ![[NSUserDefaults standardUserDefaults] boolForKey:loginKey];
}

/**
 设置用户状态
 */
+ (void)updateLoginStauts:(BOOL)isFirstLogin
{
    NSString *loginKey = [NSString stringWithFormat:@"user_login_%@", [DDUserDBManager shareInstance].getLoginUser.user_name];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:isFirstLogin forKey:loginKey];
}

@end
