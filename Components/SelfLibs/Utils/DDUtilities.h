//
//  DDUtilities.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2019/2/19.
//  Copyright © 2019 ddkt365. All rights reserved.
//

#import "OurUtilities.h"

@interface DDUtilities : OurUtilities

/** 是否为iphonex系列 iPhoneXS iPhoneXR iPhoneXSMax*/
+ (BOOL)isDeviceIphoneXSeries;

/**
 显示为00:00
 @param intDuration 时间s
 @return 00:00
 */
+ (NSString *)convertTotDurationString:(NSInteger)intDuration;

@end
