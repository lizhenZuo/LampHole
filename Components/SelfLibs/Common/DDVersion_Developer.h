//
//  DDVersion_Developer.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/8/25.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

/**  开发版本，内网环境 */
#ifndef DDVersion_Developer_h
#define DDVersion_Developer_h

/** 客户端版本号  注意：上线时必须修改为最新版本号 */
static NSString *const kAppReleaseVersionBuilder = @"2.1.5";
/** 客户端debug flag  注意：上线必须注释该DEBUG_MODE */
#define DEBUG_MODE

#pragma mark - ......::::::: 服务器地址 :::::::......
/** api请求地址 */
static NSString *const kServerHostPort_Api = @"http://apitest.ddkt365.com";
/** 下载地址 */
static NSString *const kServerHostDownURL = @"http://118.126.91.194/ddktRes/classRes/video/";
/** 礼物URL */
static NSString *const kStaticURL_Gift = @"http://h5test.ddkt365.com/h5/goods";//http://h5.ddkt365.com/pad/mall
/** js资源下载 */
static NSString *const kServerHostDownJSURL =  @"http://fyh5test.ddkt365.com/fydingdongh5.zip";
/** CRM系统 */
static NSString *const kServerHostCRMURL =  @"https://satest.ddkt365.com/customer/#/?type=3&";
/** 神策地址 */
static NSString *const kServerHostSensorsAnalyticsURL =  @"https://sc.ddkt365.com/sa?project=default";
/** 任务首页地址 */
static NSString *const kServerURL_Task = @"http://h5test.ddkt365.com/h5/task";
/** 腾讯上传验证 */
static NSString *const kServerURL_TecentQCloud = @"http://apitest.ddkt365.com/api/client/upload/au";
/** 勋章首页地址 */
static NSString *const kServerURL_Medal = @"http://h5test.ddkt365.com/h5/achievement";
/** 获取优惠 */
static NSString *const kServerURL_Preferential = @"https://h5test.ddkt365.com/h5/study-remind/preferential";
/** WX学习提醒 */
static NSString *const kServerURL_WX_Study_Recommend = @"https://h5test.ddkt365.com/h5/study-remind/report";
/** 学习计划 */
static NSString *const kServerURL_StudyPlan = @"http://h5test.ddkt365.com/h5/studyplan/level/personal";
/** 奖学金 */
static NSString *const kServerURL_ScholarShip = @"http://h5test.ddkt365.com/h5/scholarship";
/** 分析日志上传地址 */
static NSString *const kServerURL_Analytic = @"http://lbstest.ddkt365.com";
/** 级别引导推荐 */
static NSString *const kServerURL_LevelRecommend = @"http://h5test.ddkt365.com/h5/levelRecommend";

#pragma mark - ......::::::: lbs socket host :::::::......
static NSString *const kLbsSocketServerHost = @"lbsdev.ddkt365.com";//@"1 92.168.0.108" //小泉测试专用
static uint16_t const kLbsSocketServerPort = 4000;

#pragma mark - ......::::::: 第三方申明 :::::::......
/** 设置app 自定义渠道标识 */
static inline NSString *const kDDChannelForApplication(){
    return @"iPhoneDeveloper";
}
#define kDDChannelForApplication kDDChannelForApplication()
/** aps推送是否是正式上线flag */
static BOOL const kApsForProduction = NO;

/** zego环境配置，测试环境为YES */
static BOOL const isUseTestEnv = YES;

#endif /* DDVersion_Developer_h */
