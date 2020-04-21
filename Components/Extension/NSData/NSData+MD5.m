//
//  NSData+MD5.m
//  AiTeacheriPhone
//
//  Created by dingdong on 2018/9/12.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "NSData+MD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (MD5)

- (NSString *)md5
{
    const char* str = [self bytes];
    unsigned char result[16];
    CC_MD5(str, (CC_LONG)self.length, result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:16 * 2];
    for(int i = 0; i<16; i++) {
        [ret appendFormat:@"%02x",(unsigned int)(result[i])];
    }
    return ret;
}

@end
