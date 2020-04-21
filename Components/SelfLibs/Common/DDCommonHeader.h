//
//  DDCommonHeader.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/8/25.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#ifndef DDCommonHeader_h
#define DDCommonHeader_h

#pragma mark - ......:::::::    发布、开发、测试、预发布   :::::::......
typedef NS_ENUM(NSUInteger,DDAppConfigType) {
    DDAppConfigType_Release = 100, //正式环境，此处不能设置为0
    DDAppConfigType_Develop = 101, //开发环境
    DDAppConfigType_Test = 102, //测试环境
    DDAppConfigType_PreRelease = 103, //预发布环境
    DDAppConfigType_Record = 104, //录制环境
    DDAppConfigType_Right = 105, //说话成功
    DDAppConfigType_Wrong = 106, //说话失败
    DDAppConfigType_NoOperation = 107, //未说话
};
/** 客户端版本号  注意：上线时必须修改为最新版本号 */
static NSString *const kAppReleaseVersionBuilder = @"2.4.2";
/** 客户端debug flag  注意：上线必须注释该DEBUG_MODE */
#define DEBUG_MODE
/** 客户端默认的版本类型 */
static DDAppConfigType const kDefaultDDAppConfigType = DDAppConfigType_Test;
/** 客户端全局变量定义 */
#import "DDApplicationConfig.h"


/** 全局宏定义 */
#import "DDGlobalDefines.h"
#pragma mark - ......:::::::    常量设置   :::::::......
/** 全局常量 */
#import "DDConstant.h"
/** 色彩值 */
#import "DDColorConstant.h"
/** 第三方key */
#import "DDThirdPlatform.h"


#endif /* DDCommonHeader_h */
