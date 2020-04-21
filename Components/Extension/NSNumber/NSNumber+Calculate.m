//
//  NSNumber+Calculate.m
//  AiTeacheriPhone
//
//  Created by dingdong on 2019/3/7.
//  Copyright © 2019年 ddkt365. All rights reserved.
//

#import "NSNumber+Calculate.h"

@implementation NSNumber (Calculate)

+ (NSNumber *)addNumber:(NSNumber *)first second:(NSNumber *)second
{
    CGFloat count = [first floatValue] + [second floatValue];
    NSString *addStr = [NSString stringWithFormat:@"%.2f", count];
    return [NSNumber numberWithString:addStr];
}

+ (NSNumber *)subNumber:(NSNumber *)subtractor minuend:(NSNumber *)minuend
{
    CGFloat sub = [subtractor floatValue] - [minuend floatValue];
    NSString *subStr = [NSString stringWithFormat:@"%.2f", sub];
    return [NSNumber numberWithString:subStr];
}

+ (NSNumber *)rounded:(NSNumber *)srcNum
{
    NSString *strNumStr = [NSString stringWithFormat:@"%.2f", [srcNum floatValue]];
    return [NSNumber numberWithString:strNumStr];
}

@end
