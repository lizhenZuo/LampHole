//
//  NSDateFormatter+DDAddition.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2019/4/18.
//  Copyright © 2019 ddkt365. All rights reserved.
//

#import "NSDateFormatter+DDAddition.h"

@implementation NSDateFormatter (DDAddition)

+(instancetype)dd_dateFormatter{
//    NSDateFormatter *formmatter = [[NSDateFormatter alloc] init];
//    NSTimeZone *timeZone = [NSTimeZone dd_TimeZoneShanghai];
//    NSLocale *locale = [NSLocale dd_LocalezhCN];
//    [formmatter setTimeZone:timeZone];
//    [formmatter setLocale:locale];
//    return formmatter;
    static NSDateFormatter *sharedDateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSTimeZone *timeZone = [NSTimeZone dd_TimeZoneShanghai];
        NSLocale *locale = [NSLocale dd_LocalezhCN];
        [formatter setTimeZone:timeZone];
        [formatter setLocale:locale];
        sharedDateFormatter = formatter;
    });
    return sharedDateFormatter;
}

@end
