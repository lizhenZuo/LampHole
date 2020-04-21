//
//  NSDate+DDAddition.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/7.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "NSDate+DDAddition.h"

@implementation NSDate (DDAddition)

/**
 中文星期
 @return NSString
 */
-(NSString *)weekChinese{
    NSTimeZone *timeZone = [NSTimeZone dd_TimeZoneShanghai];
    NSLocale *locale = [NSLocale dd_LocalezhCN];
    NSCalendar *calender = [NSCalendar currentCalendar];
    [calender setTimeZone:timeZone];
    [calender setLocale:locale];
    NSInteger weekday = [[calender components:NSCalendarUnitWeekday fromDate:self] weekday];
    NSArray *weekdayArray = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    return [weekdayArray objectAtIndex:weekday];
};

/**
 日期文本
 @param format yyyy-MM-dd
 @return NSString
 */
- (NSString *)dd_stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [NSDateFormatter dd_dateFormatter];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:self];
}

/**
 文本转日期
 @param dateString 2019-04-18
 @param format yyyy-MM-dd
 @return NSDate
 */
+ (NSDate *)dd_dateWithString:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *formatter = [NSDateFormatter dd_dateFormatter];
    [formatter setDateFormat:format];
    return [formatter dateFromString:dateString];
}

@end
