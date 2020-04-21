//
//  DDUtilities.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2019/2/19.
//  Copyright © 2019 ddkt365. All rights reserved.
//

#import "DDUtilities.h"

@implementation DDUtilities

/** 是否为iphonex系列 iPhoneXS iPhoneXR iPhoneXSMax*/
+ (BOOL)isDeviceIphoneXSeries{
    return [self isDeviceIphoneXSMax] || [self isDeviceIphoneXS];
}

/**
 显示为00:00
 @param intDuration 时间s
 @return 00:00
 */
+ (NSString *)convertTotDurationString:(NSInteger)intDuration{
    return [NSString stringWithFormat:@"%02d:%02d", (int)(intDuration / 60), (int)(intDuration % 60)];
}

@end
