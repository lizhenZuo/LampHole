//
//  UIDevice+Model.h
//  AiTeacheriPhone
//
//  Created by tms on 2018/6/20.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Model)

//原始名字
+ (NSString *)getDeviceOriginName;

//人能看得懂的名字
+ (NSString *)getDeviceName;



@end
