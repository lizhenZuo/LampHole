//
//  DDVersion_Release.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/8/25.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

/**  正式上架版本 */
#ifndef DDVersion_Release_h
#define DDVersion_Release_h

/** 客户端版本号  注意：上线时必须修改为最新版本号 */
static NSString *const kAppReleaseVersionBuilder = @"2.1.5";
/** 客户端debug flag  注意：上线必须注释该DEBUG_MODE */
//#define DEBUG_MODE

#pragma mark - ......::::::: 服务器地址 :::::::......
/** api请求地址 */
static NSString *const kServerHostPort_Api = @"https://api.ddkt365.com";
/** 下载地址 */
static NSString *const kServerHostDownURL = @"https://118.126.91.194/ddktRes/classRes/video/";
/** 礼物URL */
static NSString *const kStaticURL_Gift = @"https://h5.ddkt365.com/h5/goods";
/** js资源下载 */
static NSString *const kServerHostDownJSURL =  @"http://fyh5.ddkt365.com/fydingdongh5.zip";
/** CRM系统 */
static NSString *const kServerHostCRMURL =  @"https://sa.ddkt365.com/customer/#/?type=3&";
/** 神策地址 */
static NSString *const kServerHostSensorsAnalyticsURL =  @"https://sc.ddkt365.com/sa?project=production";
/** 任务首页地址 */
static NSString *const kServerURL_Task = @"https://h5.ddkt365.com/h5/task";
/** 腾讯上传验证 */
static NSString *const kServerURL_TecentQCloud = @"https://api.ddkt365.com/api/client/upload/au";
/** 勋章首页地址 */
static NSString *const kServerURL_Medal = @"https://h5.ddkt365.com/h5/achievement";
/** 获取优惠 */
static NSString *const kServerURL_Preferential = @"https://h5.ddkt365.com/h5/study-remind/preferential";
/** WX学习提醒 */
static NSString *const kServerURL_WX_Study_Recommend = @"https://h5.ddkt365.com/h5/study-remind/report";
/** 学习计划 */
static NSString *const kServerURL_StudyPlan = @"https://h5.ddkt365.com/h5/studyplan/level/personal";
/** 奖学金 */
static NSString *const kServerURL_ScholarShip = @"https://h5.ddkt365.com/h5/scholarship";
/** 分析日志上传地址 */
static NSString *const kServerURL_Analytic = @"http://logreport.ddkt365.com";
/** 级别引导推荐 */
static NSString *const kServerURL_LevelRecommend = @"https://h5.ddkt365.com/h5/levelRecommend";

#pragma mark - ......::::::: lbs socket host :::::::......
static NSString *const kLbsSocketServerHost = @"lbs.ddkt365.com";
//static NSString *const kLbsSocketServerHost = @"129.204.33.136";//129.204.33.136（锦远）
static uint16_t const kLbsSocketServerPort = 4000;

#pragma mark - ......::::::: 第三方申明 :::::::......
/** 设置app 自定义渠道标识 */
static inline NSString *const kDDChannelForApplication(){
    return @"iPhoneAppstore";
}
#define kDDChannelForApplication kDDChannelForApplication()
/** aps推送是否是正式上线flag */
static BOOL const kApsForProduction = YES;

/** zego环境配置，正式环境为NO */
static BOOL const isUseTestEnv = NO;

#endif /* DDVersion_Release_h */
