//
//  DDApplicationConfig.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2019/4/8.
//  Copyright © 2019 ddkt365. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kAppConfig [DDApplicationConfig shareInstance]

@interface DDApplicationConfig : NSObject

-(instancetype)init NS_UNAVAILABLE;

-(instancetype)new NS_UNAVAILABLE;

#pragma mark - public Method
/**
 获取实例
 @return DDApplicationConfig
 */
+(instancetype)shareInstance;

/**
 更新本地的配置类型 DEBUG_MODE有define时才生效
 @param type DDAppConfigType
 @return 配置是否成功 YES NO
 */
-(BOOL)updateConfigType:(DDAppConfigType)type;

#pragma mark - ......::::::: 配置数据变量 :::::::......
/** api请求地址 */
@property (nonatomic, strong,readonly,getter=getServerHostPortApi)NSString *serverHostPort_Api;
/** h5请求地址 */
@property (nonatomic, strong,readonly,getter=getServerH5Api)NSString *serverH5_Api;
/** 礼物URL */
@property (nonatomic, strong,readonly,getter=getServerURLGift)NSString *serverURL_Gift;
/** js资源下载 */
@property (nonatomic, strong,readonly,getter=getServerHostDownJSURL)NSString *serverHostDownJSURL;
/** CRM系统 */
@property (nonatomic, strong,readonly,getter=getServerHostCRMURL)NSString *serverHostCRMURL;
/** 神策地址 */
@property (nonatomic, strong,readonly,getter=getServerHostSensorsAnalyticsURL)NSString *serverHostSensorsAnalyticsURL;
/** 任务首页地址 */
@property (nonatomic, strong,readonly,getter=getServerURLTask)NSString *serverURL_Task;
/** 腾讯上传验证 */
@property (nonatomic, strong,readonly,getter=getServerURLTecentQCloud)NSString *serverURL_TecentQCloud;
/** 勋章首页地址 */
@property (nonatomic, strong,readonly,getter=getServerURLMedal)NSString *serverURL_Medal;
/** 获取优惠 */
@property (nonatomic, strong,readonly,getter=getServerURLPreferential)NSString *serverURL_Preferential;
/** WX学习提醒 */
@property (nonatomic, strong,readonly,getter=getserverURLWXStudyRecommend)NSString *serverURL_WX_Study_Recommend;
/** 学习计划 */
@property (nonatomic, strong,readonly,getter=getServerURLStudyPlan)NSString *serverURL_StudyPlan;
/** 奖学金 */
@property (nonatomic, strong,readonly,getter=getServerURLScholarShip)NSString *serverURL_ScholarShip;
/** 分析日志上传地址 */
@property (nonatomic, strong,readonly,getter=getServerURLAnalytic)NSString *serverURL_Analytic;
/** 级别引导推荐 */
@property (nonatomic, strong,readonly,getter=getServerURLLevelRecommend)NSString *serverURL_LevelRecommend;
/** 游戏 */
@property (nonatomic, strong,readonly,getter=getServerURLGame)NSString *serverURL_Game;
/** 地址管理*/
@property (nonatomic, strong,readonly,getter=getServerURLAddressManager)NSString *serverURL_AddressManager;
/** 课时购买入口 */
@property (nonatomic, strong,readonly,getter=getServerURLTimeCardPurchase)NSString *serverURL_TimeCardPurchase;
/** 课时不足邀请链接 */
@property (nonatomic, strong,readonly,getter=getServerURLNoCardInvite)NSString *serverURL_NoCardInvite;
/** 拓展课列表 */
@property (nonatomic, strong,readonly,getter=getServerURLThemeClassList)NSString *serverURL_ThemeClassList;
/** 用户协议*/
@property (nonatomic, strong,readonly,getter=getServerURLUserAgentment)NSString *serverURL_UserAgentment;
/** 课程服务协议*/
@property (nonatomic, strong,readonly,getter=getServerURLClassServiceAgreement)NSString *serverURL_ClassServiceAgreement;
/** 隐私协议*/
@property (nonatomic, strong,readonly,getter=getServerURLPrivacyAgreement)NSString *serverURL_PrivacyAgreement;
/** 课程中心-帮助*/
@property (nonatomic, strong,readonly,getter=getServerURLCourseHelp)NSString *serverURL_CourseHelp;
/** 常见问题 */
@property (nonatomic, strong,readonly,getter=getServerURLFAQ)NSString *serverURL_FAQ;
/** 课时卡说明 */
@property (nonatomic, strong,readonly,getter=getServerURLMyLessonCardsFAQ)NSString *serverURL_MyLessonCardsFAQ;
/** 收货信息 */
@property (nonatomic, strong,readonly,getter=getServerURLReceiptInfo)NSString *serverURL_ReceiptInfo;

#pragma mark - ......::::::: lbs socket host :::::::......
@property (nonatomic, strong,readonly,getter=getLbsSocketServerHost)NSString *lbsSocketServerHost;
@property (nonatomic, assign,readonly) uint16_t lbsSocketServerPort;
/** aps推送是否是正式上线flag */
@property (nonatomic, assign,readonly) BOOL apsForProduction;
/** zego环境配置，测试环境为YES */
@property (nonatomic, assign,readonly) BOOL isUseTestEnv;
/** 设置app 自定义渠道标识 */
@property (nonatomic, strong,readonly,getter=getChannelForApplication)NSString *channelForApplication;
/** 环境类型 */
@property (nonatomic, assign,readonly)DDAppConfigType configType;

@end
