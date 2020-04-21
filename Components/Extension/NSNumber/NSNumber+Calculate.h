//
//  NSNumber+Calculate.h
//  AiTeacheriPhone
//
//  Created by dingdong on 2019/3/7.
//  Copyright © 2019年 ddkt365. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (Calculate)

//做加法
+ (NSNumber *)addNumber:(NSNumber *)first second:(NSNumber *)second;

//做减法
+ (NSNumber *)subNumber:(NSNumber *)subtractor minuend:(NSNumber *)minuend;

//四舍五入
+ (NSNumber *)rounded:(NSNumber *)srcNum;

@end

NS_ASSUME_NONNULL_END
