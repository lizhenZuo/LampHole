//
//  NSString+Common.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/8/27.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "NSString+Common.h"
#import <AdSupport/AdSupport.h>

@implementation NSString (Common)

+ (BOOL)isEmpty:(NSString *)string{
    return string == nil || string.length == 0;
};

/** 男 */
-(BOOL)isSexMale{
    return DDSex_Boy==self.integerValue;
}

/** 女 */
-(BOOL)isSexFemale{
    return DDSex_Girl==self.integerValue;
}


/**
 性别中文名
 */
-(NSString *)sexChineseName{
    if (self.isSexFemale) {
        return @"女";
    }else if (self.isSexMale) {
        return @"男";
    }else{
        return @"未知";
    }
}

/**
 获取idfa
 */
+(NSString *)advertisingIdentifier{
    if ([ASIdentifierManager sharedManager].isAdvertisingTrackingEnabled) {
        NSString *idfaStr = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        return idfaStr;
    }
    return @"";
}


/** 是否为http https头*/
-(BOOL)isValidHTTP{
    return [self hasPrefix:@"http://"] || [self hasPrefix:@"https://"];
}

/// 是否为Base64的图片字符
-(BOOL)isBase64Image{
    return [self hasPrefix:@"data:image"];
}

+ (NSMutableAttributedString *)getAttributedStringWithString:(NSString *)string font1:(UIFont *)font1 color1:(UIColor *)color1 length1:(NSInteger)length1 font2:(UIFont *)font2 color2:(UIColor *)color2
{
    //total
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSInteger totalLength = attributedString.length;
    
    //title1
    [attributedString addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(0, length1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color1 range:NSMakeRange(0, length1)];
    
    //title2
    [attributedString addAttribute:NSFontAttributeName value:font2 range:NSMakeRange(length1, totalLength-length1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color2 range:NSMakeRange(length1, totalLength-length1)];
    
    return attributedString;
}

+ (NSMutableAttributedString *)getAttributedStringWithString:(NSString *)string font1:(UIFont *)font1 color1:(UIColor *)color1 length1:(NSInteger)length1 font2:(UIFont *)font2 color2:(UIColor *)color2 length2:(NSInteger)length2 font3:(UIFont *)font3 color3:(UIColor *)color3
{
    //total
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSInteger totalLength = attributedString.length;
    
    //title1
    [attributedString addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(0, length1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color1 range:NSMakeRange(0, length1)];
    
    //title2
    [attributedString addAttribute:NSFontAttributeName value:font2 range:NSMakeRange(length1, totalLength-length1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color2 range:NSMakeRange(length1, totalLength-length1)];
    
    //title2
    [attributedString addAttribute:NSFontAttributeName value:font3 range:NSMakeRange(length1+length2, totalLength-(length1+length2))];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color3 range:NSMakeRange(length1+length2, totalLength-(length1+length2))];
    
    return attributedString;
}

//下划线
+ (NSMutableAttributedString *)getUnderlineString:(NSString *)string font:(UIFont *)font color:(UIColor *)color
{
    NSDictionary *attribtDic2 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:string attributes:attribtDic2];
    [attribtStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, string.length)];
    [attribtStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, string.length)];
    
    return attribtStr;
}

//下划线
+ (NSMutableAttributedString *)getUnderlineString:(NSString *)string font1:(UIFont *)font1 color1:(UIColor *)color1 length1:(NSInteger)length1 font2:(UIFont *)font2 color2:(UIColor *)color2
{
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:string];
    
    [attribtStr addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(0, string.length-length1)];
    [attribtStr addAttribute:NSForegroundColorAttributeName value:color1 range:NSMakeRange(0, string.length-length1)];
    
    [attribtStr addAttribute:NSFontAttributeName value:font2 range:NSMakeRange(string.length-length1, length1)];
    [attribtStr addAttribute:NSForegroundColorAttributeName value:color2 range:NSMakeRange(string.length-length1, length1)];
    [attribtStr addAttributes:attribtDic range:NSMakeRange(string.length-length1, length1)];
    
    return attribtStr;
}

//下划线
+ (NSMutableAttributedString *)getUnderlineString:(NSString *)string font1:(UIFont *)font1 color1:(UIColor *)color1 length1:(NSInteger)length1 font2:(UIFont *)font2 color2:(UIColor *)color2 length2:(NSInteger)length2 font3:(UIFont *)font3 color3:(UIColor *)color3
{
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:string];
    
    [attribtStr addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(0, length1)];
    [attribtStr addAttribute:NSForegroundColorAttributeName value:color1 range:NSMakeRange(0, length1)];
    
    [attribtStr addAttribute:NSFontAttributeName value:font2 range:NSMakeRange(length1, length2)];
    [attribtStr addAttribute:NSForegroundColorAttributeName value:color2 range:NSMakeRange(length1, length2)];
    [attribtStr addAttributes:attribtDic range:NSMakeRange(length1, length2)];
    
    [attribtStr addAttribute:NSFontAttributeName value:font3 range:NSMakeRange(length1+length2, string.length-length1-length2)];
    [attribtStr addAttribute:NSForegroundColorAttributeName value:color3 range:NSMakeRange(length1+length2, string.length-length1-length2)];
    
    return attribtStr;
}

//中划线
+ (NSMutableAttributedString *)getStrikethroughString:(NSString *)string font:(UIFont *)font color:(UIColor *)color
{
    NSDictionary *attribtDic2 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:string attributes:attribtDic2];
    [attribtStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, string.length)];
    [attribtStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, string.length)];
    [attribtStr addAttribute:NSBaselineOffsetAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, string.length)];
    
    return attribtStr;
}

//中划线
+ (NSMutableAttributedString *)getStrikethroughString:(NSString *)string font1:(UIFont *)font1 color1:(UIColor *)color1 length1:(NSInteger)length1 font2:(UIFont *)font2 color2:(UIColor *)color2
{
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:string];
    
    [attribtStr addAttribute:NSFontAttributeName value:font1 range:NSMakeRange(0, string.length-length1)];
    [attribtStr addAttribute:NSForegroundColorAttributeName value:color1 range:NSMakeRange(0, string.length-length1)];
    
    [attribtStr addAttribute:NSFontAttributeName value:font2 range:NSMakeRange(string.length-length1, length1)];
    [attribtStr addAttribute:NSForegroundColorAttributeName value:color2 range:NSMakeRange(string.length-length1, length1)];
    [attribtStr addAttribute:NSBaselineOffsetAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(string.length-length1, length1)];
    [attribtStr addAttributes:attribtDic range:NSMakeRange(string.length-length1, length1)];
    
    return attribtStr;
}

@end
