//
//  NSString+Common.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/8/27.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)


+ (BOOL)isEmpty:(NSString *)string;

/** 男 */
-(BOOL)isSexMale;

/** 女 */
-(BOOL)isSexFemale;

/**
 性别中文名
 */
-(NSString *)sexChineseName;


/**
 idfa 字段
 */
+(NSString *)advertisingIdentifier;


/** 是否为http https头*/
-(BOOL)isValidHTTP;

/// 是否为Base64的图片字符
-(BOOL)isBase64Image;

//两种格式的字符串
+ (NSMutableAttributedString *)getAttributedStringWithString:(NSString *)string font1:(UIFont *)font1 color1:(UIColor *)color1 length1:(NSInteger)length1 font2:(UIFont *)font2 color2:(UIColor *)color2;

//三种格式的字符串
+ (NSMutableAttributedString *)getAttributedStringWithString:(NSString *)string font1:(UIFont *)font1 color1:(UIColor *)color1 length1:(NSInteger)length1 font2:(UIFont *)font2 color2:(UIColor *)color2 length2:(NSInteger)length2 font3:(UIFont *)font3 color3:(UIColor *)color3;

//整个字符串下划线
+ (NSMutableAttributedString *)getUnderlineString:(NSString *)string font:(UIFont *)font color:(UIColor *)color;

//整个字符串下划线
+ (NSMutableAttributedString *)getUnderlineString:(NSString *)string font1:(UIFont *)font1 color1:(UIColor *)color1 length1:(NSInteger)length1 font2:(UIFont *)font2 color2:(UIColor *)color2;

//三段式的下划线
+ (NSMutableAttributedString *)getUnderlineString:(NSString *)string font1:(UIFont *)font1 color1:(UIColor *)color1 length1:(NSInteger)length1 font2:(UIFont *)font2 color2:(UIColor *)color2 length2:(NSInteger)length2 font3:(UIFont *)font3 color3:(UIColor *)color3;

//中划线
+ (NSMutableAttributedString *)getStrikethroughString:(NSString *)string font:(UIFont *)font color:(UIColor *)color;

//两段式的中划线
+ (NSMutableAttributedString *)getStrikethroughString:(NSString *)string font1:(UIFont *)font1 color1:(UIColor *)color1 length1:(NSInteger)length1 font2:(UIFont *)font2 color2:(UIColor *)color2;

@end
