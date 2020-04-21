//
//  NSTimeZone+DDAddition.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2019/4/18.
//  Copyright © 2019 ddkt365. All rights reserved.
//

#import "NSTimeZone+DDAddition.h"

@implementation NSTimeZone (DDAddition)

+(instancetype)dd_TimeZoneShanghai{
    return [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
}

@end
