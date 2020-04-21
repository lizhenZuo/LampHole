//
//  NSDate+DDAddition.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/7.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DDAddition)

/**
 中文星期
 @return NSString
 */
-(NSString *)weekChinese;

/**
 日期文本
 @param format yyyy-MM-dd
 @return NSString
 */
- (NSString *)dd_stringWithFormat:(NSString *)format;

/**
 文本转日期
 @param dateString 2019-04-18
 @param format yyyy-MM-dd
 @return NSDate
 */
+ (NSDate *)dd_dateWithString:(NSString *)dateString format:(NSString *)format;

@end
