//
//  DDBuglyManger.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2019/1/7.
//  Copyright © 2019 ddkt365. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDBuglyManger : NSObject

+ (instancetype)shareInstance;
/**
 注册腾讯Bugly
 */
-(void)registerBugly;

/**
 登录设置用户信息
 */
-(void)loginBugly;

@end

NS_ASSUME_NONNULL_END
