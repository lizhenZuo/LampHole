//
//  DDApplicationConfig.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2019/4/8.
//  Copyright © 2019 ddkt365. All rights reserved.
//

#import "DDApplicationConfig.h"

#pragma mark - ......::::::: 渠道编号，不能随意更改 :::::::......
static NSString *const kDDChannelForApplication_AppStore = @"iPhoneAppstore";
static NSString *const kDDChannelForApplication_Tester = @"iPhoneTester";
static NSString *const kDDChannelForApplication_Developer = @"iPhoneDeveloper";
static NSString *const kDDChannelForApplication_PreRelease= @"iPhonePreRelease";
static NSString *const kDDChannelForApplication_Record = @"iPhoneRecorder";

@implementation DDApplicationConfig
/**
 获取实例
 @return DDApplicationConfig
 */
+ (instancetype)shareInstance{
    static id _this = nil;
    static dispatch_once_t onceTokenInit;
    dispatch_once(&onceTokenInit, ^{
        _this = [self appconfigFromCache];
    });
    return _this;
}


#pragma mark - ......::::::: 从缓存中获取配置对象 :::::::......
/**
 从缓存中获取配置对象
 @return 配置对象 DDApplicationConfig
 */
+(instancetype)appconfigFromCache{
    DDApplicationConfig *config = nil;
    NSInteger type = [self getStoreConfigType];
    if (type == 0) {
        //默认缓存数据时，去Default数据，第一次启动或者未更改缓存环境
        type = kDefaultDDAppConfigType;
    }
    switch (type) {
        case DDAppConfigType_Release:{
            config = [[self alloc] initRelease];
            break;
        }
        case DDAppConfigType_PreRelease:{
            config = [[self alloc] initPreRelease];
            break;
        }
        case DDAppConfigType_Develop:{
            config = [[self alloc] initDevelop];
            break;
        }
        case DDAppConfigType_Test:{
            config = [[self alloc] initTest];
            break;
        }
        case DDAppConfigType_Record:{
            config = [[self alloc] initRecord];
            break;
        }
        case DDAppConfigType_Right:{
            config = [[self alloc] initRight];
            break;
        }
        case DDAppConfigType_Wrong:{
            config = [[self alloc] initWrong];
            break;
        }
        case DDAppConfigType_NoOperation:{
            config = [[self alloc] initNoOperation];
            break;
        }
        default:
            break;
    }
    return config;
}

/**
 更新本地的配置类型 DEBUG_MODE有define时才生效
 @param type DDAppConfigType
 @return 配置是否成功 YES NO
 */
-(BOOL)updateConfigType:(DDAppConfigType)type{
    //只有在DEBUG_MODE环境下允许配置
    BOOL flag = NO;
    DDAppConfigType cachedType = [self.class getStoreConfigType];
    if (type != cachedType) {
        flag = [self.class storeConfigType:type];
    }
    return flag;
}


#pragma mark - ......::::::: 缓存的key :::::::......
+(NSString *)udsKey{
    return @"DD_Application_Config".md5String;
}

/**
 缓存配置的缓存类型
 @param type DDAppConfigType
 @return YES NO
 */
+(BOOL)storeConfigType:(DDAppConfigType)type{
    NSUserDefaults *uds = [NSUserDefaults standardUserDefaults];
    [uds setInteger:type forKey:[self udsKey]];
    return [uds synchronize];
}


/**
 获取缓存的版本配置类型
 @return DDAppConfigType
 */
+(NSInteger)getStoreConfigType{
    NSUserDefaults *uds = [NSUserDefaults standardUserDefaults];
    NSInteger type = [uds integerForKey:[self udsKey]];
    return type;
}

#pragma mark - ......::::::: 正式环境 :::::::......
- (instancetype)initRelease{
    self = [super init];
    if (self) {
        _configType = DDAppConfigType_Release;
        /** api请求地址 */
        _serverHostPort_Api = @"https://api.ddkt365.com";
        /** h5请求地址 */
        _serverH5_Api = @"https://h5.ddkt365.com";
        /** 礼物URL */
        _serverURL_Gift = @"https://h5.ddkt365.com/h5/v2/gift-exchange";
        /** js资源下载 */
        _serverHostDownJSURL = @"http://fyh5.ddkt365.com/fydingdongh5.zip";
        /** CRM系统 */
        _serverHostCRMURL =  @"https://sa.ddkt365.com/customer/#/?type=3&";
        /** 神策地址 */
        _serverHostSensorsAnalyticsURL =  @"https://sc.ddkt365.com/sa?project=production";
        /** 任务首页地址 */
        _serverURL_Task = @"https://h5.ddkt365.com/h5/task";
        /** 腾讯上传验证 */
        _serverURL_TecentQCloud = @"https://api.ddkt365.com/api/client/upload/au";
        /** 勋章首页地址 */
        _serverURL_Medal = @"http://h5.ddkt365.com/h5/v2/honor";
        /** 获取优惠 */
        _serverURL_Preferential = @"https://h5.ddkt365.com/h5/study-remind/preferential";
        /** WX学习提醒 */
        _serverURL_WX_Study_Recommend = @"https://h5.ddkt365.com/h5/study-remind/report";
        /** 学习计划 */
        _serverURL_StudyPlan = @"https://h5.ddkt365.com/h5/studyplan/level/personal";
        /** 奖学金 */
        _serverURL_ScholarShip = @"https://h5.ddkt365.com/h5/scholarship";
        /** 分析日志上传地址 */
        _serverURL_Analytic = @"https://logreport.ddkt365.com/client_report";
        /** 级别引导推荐 */
        _serverURL_LevelRecommend = @"https://h5.ddkt365.com/h5/levelRecommend";
        /** 游戏 */
        _serverURL_Game = @"https://h5.ddkt365.com/h5/game-park";
        /** 地址管理 */
        _serverURL_AddressManager = @"https://h5.ddkt365.com/h5/address-list";
        /** 课时购买 */
        _serverURL_TimeCardPurchase = @"https://h5.ddkt365.com/h5/v2/class-mall";
        /** 课时不足邀请链接 */
        _serverURL_NoCardInvite = @"https://h5.ddkt365.com/h5/invite-ddkt";
        /** 扩展课列表 */
        _serverURL_ThemeClassList = @"https://h5.ddkt365.com/h5/v2/class-mall";
        /** 用户协议*/
        _serverURL_UserAgentment = @"http://h5.ddkt365.com/h5/v2/about/protocol?type=register";
        /** 课程服务协议*/
        _serverURL_ClassServiceAgreement = @"http://h5.ddkt365.com/h5/v2/about/protocol?type=service";
        /** 隐私协议*/
        _serverURL_PrivacyAgreement = @"http://h5.ddkt365.com/h5/v2/about/protocol?type=privacy";
        /** 帮助 */
        _serverURL_CourseHelp = @"http://h5.ddkt365.com/h5/v2/class-help";
        /**常见问题*/
        _serverURL_FAQ = @"https://h5.ddkt365.com/h5/v2/help";
        /**课时卡说明*/
        _serverURL_MyLessonCardsFAQ = @"https://h5.ddkt365.com/h5/v2/card-explain";
        /**收货信息*/
        _serverURL_ReceiptInfo = @"https://h5.ddkt365.com/h5/v2/receipt-info";
        
        /** lbs socket host */
        _lbsSocketServerHost = @"lbs.ddkt365.com";
        _lbsSocketServerPort = 4000;
        /** aps推送是否是正式上线flag */
        _apsForProduction = YES;
        /** zego环境配置，测试环境为YES */
        _isUseTestEnv = NO;
        /** 设置app 自定义渠道标识 */
        _channelForApplication = kDDChannelForApplication_AppStore;
    }
    return self;
}

#pragma mark - ......::::::: 开发环境 :::::::......
- (instancetype)initDevelop{
    self = [super init];
    if (self) {
        _configType = DDAppConfigType_Develop;
        /** api请求地址 */
        _serverHostPort_Api = @"http://apitest.ddkt365.com";
        /** h5请求地址 */
        _serverH5_Api = @"https://h5test.ddkt365.com";
        /** 礼物URL */
        _serverURL_Gift = @"https://h5test.ddkt365.com/h5/v2/gift-exchange";
        /** js资源下载 */
        _serverHostDownJSURL = @"http://fyh5test.ddkt365.com/fydingdongh5.zip";
        /** CRM系统 */
        _serverHostCRMURL =  @"https://satest.ddkt365.com/customer/#/?type=3&";
        /** 神策地址 */
        _serverHostSensorsAnalyticsURL =  @"https://sc.ddkt365.com/sa?project=default";
        /** 任务首页地址 */
        _serverURL_Task = @"http://h5test.ddkt365.com/h5/task";
        /** 腾讯上传验证 */
        _serverURL_TecentQCloud = @"http://apitest.ddkt365.com/api/client/upload/au";
        /** 勋章首页地址 */
        _serverURL_Medal = @"http://h5test.ddkt365.com/h5/v2/honor";
        /** 获取优惠 */
        _serverURL_Preferential = @"https://h5test.ddkt365.com/h5/study-remind/preferential";
        /** WX学习提醒 */
        _serverURL_WX_Study_Recommend = @"https://h5test.ddkt365.com/h5/study-remind/report";
        /** 学习计划 */
        _serverURL_StudyPlan = @"http://h5test.ddkt365.com/h5/studyplan/level/personal";
        /** 奖学金 */
        _serverURL_ScholarShip = @"http://h5test.ddkt365.com/h5/scholarship";
        /** 分析日志上传地址 */
        _serverURL_Analytic = @"https://lbstest.ddkt365.com/client_report";
        /** 级别引导推荐 */
        _serverURL_LevelRecommend = @"http://h5test.ddkt365.com/h5/levelRecommend";
        /** 游戏 */
        _serverURL_Game = @"http://h5test.ddkt365.com/h5/game-park";
        /** 地址管理 */
        _serverURL_AddressManager = @"http://h5test.ddkt365.com/h5/address-list";
        /** 课时购买 */
        _serverURL_TimeCardPurchase = @"http://h5test.ddkt365.com/h5/v2/class-mall";
        /** 课时不足邀请链接 */
        _serverURL_NoCardInvite = @"https://h5test.ddkt365.com/h5/invite-ddkt";
        /** 扩展课列表 */
        _serverURL_ThemeClassList = @"http://h5test.ddkt365.com/h5/v2/class-mall";
        /** 用户协议*/
        _serverURL_UserAgentment = @"http://h5test.ddkt365.com/h5/v2/about/protocol?type=register";
        /** 课程服务协议*/
        _serverURL_ClassServiceAgreement = @"http://h5test.ddkt365.com/h5/v2/about/protocol?type=service";
        /** 隐私协议*/
        _serverURL_PrivacyAgreement = @"http://h5test.ddkt365.com/h5/v2/about/protocol?type=privacy";
        /** 帮助 */
        _serverURL_CourseHelp = @"http://h5test.ddkt365.com/h5/v2/class-help";
        /**常见问题*/
        _serverURL_FAQ = @"https://h5test.ddkt365.com/h5/v2/help";
        /**课时卡说明*/
        _serverURL_MyLessonCardsFAQ = @"https://h5test.ddkt365.com/h5/v2/card-explain";
        /**收货信息*/
        _serverURL_ReceiptInfo = @"https://h5test.ddkt365.com/h5/v2/receipt-info";
        
        /** lbs socket host */
        _lbsSocketServerHost = @"lbsdev.ddkt365.com";//@"1 92.168.0.108" //小泉测试专用
        _lbsSocketServerPort = 4000;
        /** aps推送是否是正式上线flag */
        _apsForProduction = NO;
        /** zego环境配置，测试环境为YES */
        _isUseTestEnv = YES;
        /** 设置app 自定义渠道标识 */
        _channelForApplication = kDDChannelForApplication_Developer;
    }
    return self;
}

#pragma mark - ......::::::: 测试环境 :::::::......
- (instancetype)initTest{
    self = [super init];
    if (self) {
        _configType = DDAppConfigType_Test;
        /** api请求地址 */
        _serverHostPort_Api = @"http://apitest.ddkt365.com";
        /** h5请求地址 */
        _serverH5_Api = @"https://h5test.ddkt365.com";
        /** 礼物URL */
        _serverURL_Gift = @"https://h5test.ddkt365.com/h5/v2/gift-exchange";
        /** js资源下载 */
        _serverHostDownJSURL = @"http://fyh5test.ddkt365.com/fydingdongh5.zip";
        /** CRM系统 */
        _serverHostCRMURL =  @"https://satest.ddkt365.com/customer/#/?type=3&";
        /** 神策地址 */
        _serverHostSensorsAnalyticsURL =  @"https://sc.ddkt365.com/sa?project=default";
        /** 任务首页地址 */
        _serverURL_Task = @"http://h5test.ddkt365.com/h5/task";
        /** 腾讯上传验证 */ 
        _serverURL_TecentQCloud = @"http://apitest.ddkt365.com/api/client/upload/au";
        /** 勋章首页地址 */
        _serverURL_Medal = @"http://h5test.ddkt365.com/h5/v2/honor";
        /** 获取优惠 */
        _serverURL_Preferential = @"https://h5test.ddkt365.com/h5/study-remind/preferential";
        /** WX学习提醒 */
        _serverURL_WX_Study_Recommend = @"https://h5test.ddkt365.com/h5/study-remind/report";
        /** 学习计划 */
        _serverURL_StudyPlan = @"http://h5test.ddkt365.com/h5/studyplan/level/personal";
        /** 游戏 */
        _serverURL_Game = @"http://h5test.ddkt365.com/h5/game-park";
        /** 地址管理 */
        _serverURL_AddressManager = @"http://h5test.ddkt365.com/h5/address-list";
        /** 奖学金 */
        _serverURL_ScholarShip = @"http://h5test.ddkt365.com/h5/scholarship";
        /** 分析日志上传地址 */
        _serverURL_Analytic = @"https://lbstest.ddkt365.com/client_report";
        /** 级别引导推荐 */
        _serverURL_LevelRecommend = @"http://h5test.ddkt365.com/h5/levelRecommend";
        /** 课时购买 */
        _serverURL_TimeCardPurchase = @"http://h5test.ddkt365.com/h5/v2/class-mall";
        /** 课时不足邀请链接 */
        _serverURL_NoCardInvite = @"https://h5test.ddkt365.com/h5/invite-ddkt";
        /** 扩展课列表 */
        _serverURL_ThemeClassList = @"http://h5test.ddkt365.com/h5/v2/class-mall";
        /** 用户协议*/
        _serverURL_UserAgentment = @"http://h5test.ddkt365.com/h5/v2/about/protocol?type=register";
        /** 课程服务协议*/
        _serverURL_ClassServiceAgreement = @"http://h5test.ddkt365.com/h5/v2/about/protocol?type=service";
        /** 隐私协议*/
        _serverURL_PrivacyAgreement = @"http://h5test.ddkt365.com/h5/v2/about/protocol?type=privacy";
        /** 帮助 */
        _serverURL_CourseHelp = @"http://h5test.ddkt365.com/h5/v2/class-help";
        /**常见问题*/
        _serverURL_FAQ = @"https://h5test.ddkt365.com/h5/v2/help";
        /**课时卡说明*/
        _serverURL_MyLessonCardsFAQ = @"https://h5test.ddkt365.com/h5/v2/card-explain";
        /**收货信息*/
        _serverURL_ReceiptInfo = @"https://h5test.ddkt365.com/h5/v2/receipt-info";
        
        /** lbs socket host */
        _lbsSocketServerHost = @"lbstest.ddkt365.com";//@"1 92.168.0.108" //小泉测试专用
        _lbsSocketServerPort = 4000;
        /** aps推送是否是正式上线flag */
        _apsForProduction = NO;
        /** zego环境配置，测试环境为YES */
        _isUseTestEnv = YES;
        /** 设置app 自定义渠道标识 */
        _channelForApplication = kDDChannelForApplication_Tester;
    }
    return self;
}

#pragma mark - ......::::::: 预发布环境 :::::::......
- (instancetype)initPreRelease{
    self = [super init];
    if (self) {
        _configType = DDAppConfigType_PreRelease;
        /** api请求地址 */
        _serverHostPort_Api = @"https://apialpha.ddkt365.com";
        /** h5请求地址 */
        _serverH5_Api = @"https://h5.ddkt365.com";
        /** 礼物URL */
        _serverURL_Gift = @"https://h5.ddkt365.com/h5/v2/gift-exchange";
        /** js资源下载 */
        _serverHostDownJSURL = @"http://fyh5.ddkt365.com/fydingdongh5.zip";
        /** CRM系统 */
        _serverHostCRMURL =  @"https://sa.ddkt365.com/customer/#/?type=3&";
        /** 神策地址 */
        _serverHostSensorsAnalyticsURL =  @"https://sc.ddkt365.com/sa?project=production";
        /** 任务首页地址 */
        _serverURL_Task = @"https://h5.ddkt365.com/h5/task";
        /** 腾讯上传验证 */
        _serverURL_TecentQCloud = @"https://api.ddkt365.com/api/client/upload/au";
        /** 勋章首页地址 */
        _serverURL_Medal = @"http://h5.ddkt365.com/h5/v2/honor";
        /** 获取优惠 */
        _serverURL_Preferential = @"https://h5.ddkt365.com/h5/study-remind/preferential";
        /** WX学习提醒 */
        _serverURL_WX_Study_Recommend = @"https://h5.ddkt365.com/h5/study-remind/report";
        /** 学习计划 */
        _serverURL_StudyPlan = @"https://h5.ddkt365.com/h5/studyplan/level/personal";
        /** 奖学金 */
        _serverURL_ScholarShip = @"https://h5.ddkt365.com/h5/scholarship";
        /** 分析日志上传地址 */
        _serverURL_Analytic = @"https://logreport.ddkt365.com/client_report";
        /** 级别引导推荐 */
        _serverURL_LevelRecommend = @"https://h5.ddkt365.com/h5/levelRecommend";
        /** 游戏 */
        _serverURL_Game = @"https://h5.ddkt365.com/h5/game-park";
        /** 地址管理 */
        _serverURL_AddressManager = @"https://h5.ddkt365.com/h5/address-list";
        /** 课时购买 */
        _serverURL_TimeCardPurchase = @"https://h5.ddkt365.com/h5/v2/class-mall";
        /** 课时不足邀请链接 */
        _serverURL_NoCardInvite = @"https://h5.ddkt365.com/h5/invite-ddkt";
        /** 扩展课列表 */
        _serverURL_ThemeClassList = @"https://h5.ddkt365.com/h5/v2/class-mall";
        /** 用户协议*/
        _serverURL_UserAgentment = @"http://h5.ddkt365.com/h5/v2/about/protocol?type=register";
        /** 课程服务协议*/
        _serverURL_ClassServiceAgreement = @"http://h5.ddkt365.com/h5/v2/about/protocol?type=service";
        /** 隐私协议*/
        _serverURL_PrivacyAgreement = @"http://h5.ddkt365.com/h5/v2/about/protocol?type=privacy";
        /** 帮助 */
        _serverURL_CourseHelp = @"http://h5.ddkt365.com/h5/v2/class-help";
        /**常见问题*/
        _serverURL_FAQ = @"https://h5.ddkt365.com/h5/v2/help";
        /**课时卡说明*/
        _serverURL_MyLessonCardsFAQ = @"https://h5.ddkt365.com/h5/v2/card-explain";
        /**收货信息*/
        _serverURL_ReceiptInfo = @"https://h5.ddkt365.com/h5/v2/receipt-info";
        
        /** lbs socket host */
        _lbsSocketServerHost = @"lbspre.ddkt365.com";
        _lbsSocketServerPort = 4000;
        /** aps推送是否是正式上线flag */
        _apsForProduction = YES;
        /** zego环境配置，测试环境为YES */
        _isUseTestEnv = NO;
        /** 设置app 自定义渠道标识 */
        _channelForApplication = kDDChannelForApplication_PreRelease;
    }
    return self;
}

#pragma mark - ......::::::: 录制环境 :::::::......
- (instancetype)initRecord{
    self = [super init];
    if (self) {
        _configType = DDAppConfigType_Record;
        /** api请求地址 */
        _serverHostPort_Api = @"http://apitest.ddkt365.com";
        /** h5请求地址 */
        _serverH5_Api = @"https://h5test.ddkt365.com";
        /** 礼物URL */
        _serverURL_Gift = @"https://h5test.ddkt365.com/h5/v2/gift-exchange";
        /** js资源下载 */
        _serverHostDownJSURL = @"http://fyh5test.ddkt365.com/fydingdongh5.zip";
        /** CRM系统 */
        _serverHostCRMURL =  @"https://satest.ddkt365.com/customer/#/?type=3&";
        /** 神策地址 */
        _serverHostSensorsAnalyticsURL =  @"https://sc.ddkt365.com/sa?project=default";
        /** 任务首页地址 */
        _serverURL_Task = @"http://h5test.ddkt365.com/h5/task";
        /** 腾讯上传验证 */
        _serverURL_TecentQCloud = @"http://apitest.ddkt365.com/api/client/upload/au";
        /** 勋章首页地址 */
        _serverURL_Medal = @"http://h5test.ddkt365.com/h5/v2/honor";
        /** 获取优惠 */
        _serverURL_Preferential = @"https://h5test.ddkt365.com/h5/study-remind/preferential";
        /** WX学习提醒 */
        _serverURL_WX_Study_Recommend = @"https://h5test.ddkt365.com/h5/study-remind/report";
        /** 学习计划 */
        _serverURL_StudyPlan = @"http://h5test.ddkt365.com/h5/studyplan/level/personal";
        /** 游戏 */
        _serverURL_Game = @"http://h5test.ddkt365.com/h5/game-park";
        /** 地址管理 */
        _serverURL_AddressManager = @"http://h5test.ddkt365.com/h5/address-list";
        /** 奖学金 */
        _serverURL_ScholarShip = @"http://h5test.ddkt365.com/h5/scholarship";
        /** 分析日志上传地址 */
        _serverURL_Analytic = @"https://lbstest.ddkt365.com/client_report";
        /** 级别引导推荐 */
        _serverURL_LevelRecommend = @"http://h5test.ddkt365.com/h5/levelRecommend";
        /** 课时购买 */
        _serverURL_TimeCardPurchase = @"http://h5test.ddkt365.com/h5/v2/class-mall";
        /** 课时不足邀请链接 */
        _serverURL_NoCardInvite = @"https://h5test.ddkt365.com/h5/invite-ddkt";
        /** 扩展课列表 */
        _serverURL_ThemeClassList = @"http://h5test.ddkt365.com/h5/v2/class-mall";
        /** 用户协议*/
        _serverURL_UserAgentment = @"http://h5test.ddkt365.com/h5/v2/about/protocol?type=register";
        /** 课程服务协议*/
        _serverURL_ClassServiceAgreement = @"http://h5test.ddkt365.com/h5/v2/about/protocol?type=service";
        /** 隐私协议*/
        _serverURL_PrivacyAgreement = @"http://h5test.ddkt365.com/h5/v2/about/protocol?type=privacy";
        /** 帮助 */
        _serverURL_CourseHelp = @"http://h5test.ddkt365.com/h5/v2/class-help";
        /**常见问题*/
        _serverURL_FAQ = @"https://h5test.ddkt365.com/h5/v2/help";
        /**课时卡说明*/
        _serverURL_MyLessonCardsFAQ = @"https://h5test.ddkt365.com/h5/v2/card-explain";
        /**收货信息*/
        _serverURL_ReceiptInfo = @"https://h5test.ddkt365.com/h5/v2/receipt-info";
        
        /** lbs socket host */
        _lbsSocketServerHost = @"lbsrecord.ddkt365.com";
        _lbsSocketServerPort = 4000;
        /** aps推送是否是正式上线flag */
        _apsForProduction = NO;
        /** zego环境配置，测试环境为YES */
        _isUseTestEnv = YES;
        /** 设置app 自定义渠道标识 */
        _channelForApplication = kDDChannelForApplication_Record;
    }
    return self;
}

#pragma mark - ......::::::: 回答正常环境 :::::::......
- (instancetype)initRight{
    self = [super init];
    if (self) {
        _configType = DDAppConfigType_Right;
        /** api请求地址 */
        _serverHostPort_Api = @"http://apitest.ddkt365.com";
        /** h5请求地址 */
        _serverH5_Api = @"https://h5test.ddkt365.com";
        /** 礼物URL */
        _serverURL_Gift = @"https://h5test.ddkt365.com/h5/v2/gift-exchange";
        /** js资源下载 */
        _serverHostDownJSURL = @"http://fyh5test.ddkt365.com/fydingdongh5.zip";
        /** CRM系统 */
        _serverHostCRMURL =  @"https://satest.ddkt365.com/customer/#/?type=3&";
        /** 神策地址 */
        _serverHostSensorsAnalyticsURL =  @"https://sc.ddkt365.com/sa?project=default";
        /** 任务首页地址 */
        _serverURL_Task = @"http://h5test.ddkt365.com/h5/task";
        /** 腾讯上传验证 */
        _serverURL_TecentQCloud = @"http://apitest.ddkt365.com/api/client/upload/au";
        /** 勋章首页地址 */
        _serverURL_Medal = @"http://h5test.ddkt365.com/h5/v2/honor";
        /** 获取优惠 */
        _serverURL_Preferential = @"https://h5test.ddkt365.com/h5/study-remind/preferential";
        /** WX学习提醒 */
        _serverURL_WX_Study_Recommend = @"https://h5test.ddkt365.com/h5/study-remind/report";
        /** 学习计划 */
        _serverURL_StudyPlan = @"http://h5test.ddkt365.com/h5/studyplan/level/personal";
        /** 游戏 */
        _serverURL_Game = @"http://h5test.ddkt365.com/h5/game-park";
        /** 地址管理 */
        _serverURL_AddressManager = @"http://h5test.ddkt365.com/h5/address-list";
        /** 奖学金 */
        _serverURL_ScholarShip = @"http://h5test.ddkt365.com/h5/scholarship";
        /** 分析日志上传地址 */
        _serverURL_Analytic = @"https://lbstest.ddkt365.com/client_report";
        /** 级别引导推荐 */
        _serverURL_LevelRecommend = @"http://h5test.ddkt365.com/h5/levelRecommend";
        /** 课时购买 */
        _serverURL_TimeCardPurchase = @"http://h5test.ddkt365.com/h5/v2/class-mall";
        /** 课时不足邀请链接 */
        _serverURL_NoCardInvite = @"https://h5test.ddkt365.com/h5/invite-ddkt";
        /** 扩展课列表 */
        _serverURL_ThemeClassList = @"http://h5test.ddkt365.com/h5/v2/class-mall";
        /** 用户协议*/
        _serverURL_UserAgentment = @"http://h5test.ddkt365.com/h5/v2/about/protocol?type=register";
        /** 课程服务协议*/
        _serverURL_ClassServiceAgreement = @"http://h5test.ddkt365.com/h5/v2/about/protocol?type=service";
        /** 隐私协议*/
        _serverURL_PrivacyAgreement = @"http://h5test.ddkt365.com/h5/v2/about/protocol?type=privacy";
        /** 帮助 */
        _serverURL_CourseHelp = @"http://h5test.ddkt365.com/h5/v2/class-help";
        /**常见问题*/
        _serverURL_FAQ = @"https://h5test.ddkt365.com/h5/v2/help";
        /**课时卡说明*/
        _serverURL_MyLessonCardsFAQ = @"https://h5test.ddkt365.com/h5/v2/card-explain";
        /**收货信息*/
        _serverURL_ReceiptInfo = @"https://h5test.ddkt365.com/h5/v2/receipt-info";
        
        /** lbs socket host */
        _lbsSocketServerHost = @"lbsright.ddkt365.com";
        _lbsSocketServerPort = 4010;
        /** aps推送是否是正式上线flag */
        _apsForProduction = NO;
        /** zego环境配置，测试环境为YES */
        _isUseTestEnv = YES;
        /** 设置app 自定义渠道标识 */
        _channelForApplication = kDDChannelForApplication_Record;
    }
    return self;
}

#pragma mark - ......::::::: 回答错误环境 :::::::......
- (instancetype)initWrong{
    self = [super init];
    if (self) {
        _configType = DDAppConfigType_Wrong;
        /** api请求地址 */
        _serverHostPort_Api = @"http://apitest.ddkt365.com";
        /** h5请求地址 */
        _serverH5_Api = @"https://h5test.ddkt365.com";
        /** 礼物URL */
        _serverURL_Gift = @"https://h5test.ddkt365.com/h5/v2/gift-exchange";
        /** js资源下载 */
        _serverHostDownJSURL = @"http://fyh5test.ddkt365.com/fydingdongh5.zip";
        /** CRM系统 */
        _serverHostCRMURL =  @"https://satest.ddkt365.com/customer/#/?type=3&";
        /** 神策地址 */
        _serverHostSensorsAnalyticsURL =  @"https://sc.ddkt365.com/sa?project=default";
        /** 任务首页地址 */
        _serverURL_Task = @"http://h5test.ddkt365.com/h5/task";
        /** 腾讯上传验证 */
        _serverURL_TecentQCloud = @"http://apitest.ddkt365.com/api/client/upload/au";
        /** 勋章首页地址 */
        _serverURL_Medal = @"http://h5test.ddkt365.com/h5/v2/honor";
        /** 获取优惠 */
        _serverURL_Preferential = @"https://h5test.ddkt365.com/h5/study-remind/preferential";
        /** WX学习提醒 */
        _serverURL_WX_Study_Recommend = @"https://h5test.ddkt365.com/h5/study-remind/report";
        /** 学习计划 */
        _serverURL_StudyPlan = @"http://h5test.ddkt365.com/h5/studyplan/level/personal";
        /** 游戏 */
        _serverURL_Game = @"http://h5test.ddkt365.com/h5/game-park";
        /** 地址管理 */
        _serverURL_AddressManager = @"http://h5test.ddkt365.com/h5/address-list";
        /** 奖学金 */
        _serverURL_ScholarShip = @"http://h5test.ddkt365.com/h5/scholarship";
        /** 分析日志上传地址 */
        _serverURL_Analytic = @"https://lbstest.ddkt365.com/client_report";
        /** 级别引导推荐 */
        _serverURL_LevelRecommend = @"http://h5test.ddkt365.com/h5/levelRecommend";
        /** 课时购买 */
        _serverURL_TimeCardPurchase = @"http://h5test.ddkt365.com/h5/v2/class-mall";
        /** 课时不足邀请链接 */
        _serverURL_NoCardInvite = @"https://h5test.ddkt365.com/h5/invite-ddkt";
        /** 扩展课列表 */
        _serverURL_ThemeClassList = @"http://h5test.ddkt365.com/h5/v2/class-mall";
        /** 用户协议*/
        _serverURL_UserAgentment = @"http://h5test.ddkt365.com/h5/v2/about/protocol?type=register";
        /** 课程服务协议*/
        _serverURL_ClassServiceAgreement = @"http://h5test.ddkt365.com/h5/v2/about/protocol?type=service";
        /** 隐私协议*/
        _serverURL_PrivacyAgreement = @"http://h5test.ddkt365.com/h5/v2/about/protocol?type=privacy";
        /** 帮助 */
        _serverURL_CourseHelp = @"http://h5test.ddkt365.com/h5/v2/class-help";
        /**常见问题*/
        _serverURL_FAQ = @"https://h5test.ddkt365.com/h5/v2/help";
        /**课时卡说明*/
        _serverURL_MyLessonCardsFAQ = @"https://h5test.ddkt365.com/h5/v2/card-explain";
        /**收货信息*/
        _serverURL_ReceiptInfo = @"https://h5test.ddkt365.com/h5/v2/receipt-info";
        
        /** lbs socket host */
        _lbsSocketServerHost = @"lbswrong.ddkt365.com";
        _lbsSocketServerPort = 4020;
        /** aps推送是否是正式上线flag */
        _apsForProduction = NO;
        /** zego环境配置，测试环境为YES */
        _isUseTestEnv = YES;
        /** 设置app 自定义渠道标识 */
        _channelForApplication = kDDChannelForApplication_Record;
    }
    return self;
}

#pragma mark - ......::::::: 未说话环境 :::::::......
- (instancetype)initNoOperation{
    self = [super init];
    if (self) {
        _configType = DDAppConfigType_NoOperation;
        /** api请求地址 */
        _serverHostPort_Api = @"http://apitest.ddkt365.com";
        /** h5请求地址 */
        _serverH5_Api = @"https://h5test.ddkt365.com";
        /** 礼物URL */
        _serverURL_Gift = @"https://h5test.ddkt365.com/h5/v2/gift-exchange";
        /** js资源下载 */
        _serverHostDownJSURL = @"http://fyh5test.ddkt365.com/fydingdongh5.zip";
        /** CRM系统 */
        _serverHostCRMURL =  @"https://satest.ddkt365.com/customer/#/?type=3&";
        /** 神策地址 */
        _serverHostSensorsAnalyticsURL =  @"https://sc.ddkt365.com/sa?project=default";
        /** 任务首页地址 */
        _serverURL_Task = @"http://h5test.ddkt365.com/h5/task";
        /** 腾讯上传验证 */
        _serverURL_TecentQCloud = @"http://apitest.ddkt365.com/api/client/upload/au";
        /** 勋章首页地址 */
        _serverURL_Medal = @"http://h5test.ddkt365.com/h5/v2/honor";
        /** 获取优惠 */
        _serverURL_Preferential = @"https://h5test.ddkt365.com/h5/study-remind/preferential";
        /** WX学习提醒 */
        _serverURL_WX_Study_Recommend = @"https://h5test.ddkt365.com/h5/study-remind/report";
        /** 学习计划 */
        _serverURL_StudyPlan = @"http://h5test.ddkt365.com/h5/studyplan/level/personal";
        /** 游戏 */
        _serverURL_Game = @"http://h5test.ddkt365.com/h5/game-park";
        /** 地址管理 */
        _serverURL_AddressManager = @"http://h5test.ddkt365.com/h5/address-list";
        /** 奖学金 */
        _serverURL_ScholarShip = @"http://h5test.ddkt365.com/h5/scholarship";
        /** 分析日志上传地址 */
        _serverURL_Analytic = @"https://lbstest.ddkt365.com/client_report";
        /** 级别引导推荐 */
        _serverURL_LevelRecommend = @"http://h5test.ddkt365.com/h5/levelRecommend";
        /** 课时购买 */
        _serverURL_TimeCardPurchase = @"http://h5test.ddkt365.com/h5/v2/class-mall";
        /** 课时不足邀请链接 */
        _serverURL_NoCardInvite = @"https://h5test.ddkt365.com/h5/invite-ddkt";
        /** 扩展课列表 */
        _serverURL_ThemeClassList = @"http://h5test.ddkt365.com/h5/v2/class-mall";
        /** 用户协议*/
        _serverURL_UserAgentment = @"http://h5test.ddkt365.com/h5/v2/about/protocol?type=register";
        /** 课程服务协议*/
        _serverURL_ClassServiceAgreement = @"http://h5test.ddkt365.com/h5/v2/about/protocol?type=service";
        /** 隐私协议*/
        _serverURL_PrivacyAgreement = @"http://h5test.ddkt365.com/h5/v2/about/protocol?type=privacy";
        /** 帮助 */
        _serverURL_CourseHelp = @"http://h5test.ddkt365.com/h5/v2/class-help";
        /**常见问题*/
        _serverURL_FAQ = @"https://h5test.ddkt365.com/h5/v2/help";
        /**收货信息*/
        _serverURL_ReceiptInfo = @"https://h5test.ddkt365.com/h5/v2/receipt-info";
        
        /** lbs socket host */
        _lbsSocketServerHost = @"lbsnooperation.ddkt365.com";
        _lbsSocketServerPort = 4030;
        /** aps推送是否是正式上线flag */
        _apsForProduction = NO;
        /** zego环境配置，测试环境为YES */
        _isUseTestEnv = YES;
        /** 设置app 自定义渠道标识 */
        _channelForApplication = kDDChannelForApplication_Record;
    }
    return self;
}

#pragma mark - ......::::::: 变量校验 :::::::......
@synthesize serverHostPort_Api = _serverHostPort_Api;
@synthesize serverH5_Api = _serverH5_Api;
@synthesize serverURL_Gift = _serverURL_Gift;
@synthesize serverHostDownJSURL = _serverHostDownJSURL;
@synthesize serverHostCRMURL = _serverHostCRMURL;
@synthesize serverHostSensorsAnalyticsURL = _serverHostSensorsAnalyticsURL;
@synthesize serverURL_Task = _serverURL_Task;
@synthesize serverURL_TecentQCloud = _serverURL_TecentQCloud;
@synthesize serverURL_Medal = _serverURL_Medal;
@synthesize serverURL_Preferential = _serverURL_Preferential;
@synthesize serverURL_WX_Study_Recommend = _serverURL_WX_Study_Recommend;
@synthesize serverURL_StudyPlan = _serverURL_StudyPlan;
@synthesize serverURL_ScholarShip = _serverURL_ScholarShip;
@synthesize serverURL_Analytic = _serverURL_Analytic;
@synthesize serverURL_LevelRecommend = _serverURL_LevelRecommend;
@synthesize lbsSocketServerHost = _lbsSocketServerHost;
@synthesize channelForApplication = _channelForApplication;
@synthesize serverURL_Game = _serverURL_Game;
@synthesize serverURL_AddressManager = _serverURL_AddressManager;
@synthesize serverURL_TimeCardPurchase = _serverURL_TimeCardPurchase;
@synthesize serverURL_NoCardInvite = _serverURL_NoCardInvite;
@synthesize serverURL_ThemeClassList = _serverURL_ThemeClassList;
@synthesize serverURL_UserAgentment = _serverURL_UserAgentment;
@synthesize serverURL_ClassServiceAgreement = _serverURL_ClassServiceAgreement;
@synthesize serverURL_PrivacyAgreement = _serverURL_PrivacyAgreement;
@synthesize serverURL_CourseHelp = _serverURL_CourseHelp;
@synthesize serverURL_FAQ = _serverURL_FAQ;
@synthesize serverURL_MyLessonCardsFAQ = _serverURL_MyLessonCardsFAQ;
@synthesize serverURL_ReceiptInfo = _serverURL_ReceiptInfo;

-(NSString *)getServerHostPortApi{
    NSAssert(_serverHostPort_Api!=nil, @"getServerHostPortApi 没有初始化值...");
    return _serverHostPort_Api;
}

- (NSString *)getServerH5Api{
    NSAssert(_serverH5_Api!=nil, @"getServerH5Api 没有初始化值...");
    return _serverH5_Api;
}


-(NSString *)getServerURLGift{
    NSAssert(_serverURL_Gift!=nil, @"getServerURLGift 没有初始化值...");
    return _serverURL_Gift;
}

-(NSString *)getServerHostDownJSURL{
    NSAssert(_serverHostDownJSURL!=nil, @"getServerHostDownJSURL 没有初始化值...");
    return _serverHostDownJSURL;
}
-(NSString *)getServerHostCRMURL{
    NSAssert(_serverHostCRMURL!=nil, @"getServerHostCRMURL 没有初始化值...");
    return _serverHostCRMURL;
}
-(NSString *)getServerHostSensorsAnalyticsURL{
    NSAssert(_serverHostSensorsAnalyticsURL!=nil, @"getServerHostSensorsAnalyticsURL 没有初始化值...");
    return _serverHostSensorsAnalyticsURL;
}
-(NSString *)getServerURLTask{
    NSAssert(_serverURL_Task!=nil, @"getServerURLTask 没有初始化值...");
    return _serverURL_Task;
}
-(NSString *)getServerURLTecentQCloud{
    NSAssert(_serverURL_TecentQCloud!=nil, @"getServerURLTecentQCloud 没有初始化值...");
    return _serverURL_TecentQCloud;
}
-(NSString *)getServerURLMedal{
    NSAssert(_serverURL_Medal!=nil, @"getServerURLMedal 没有初始化值...");
    return _serverURL_Medal;
}
-(NSString *)getServerURLPreferential{
    NSAssert(_serverURL_Preferential!=nil, @"getServerURLPreferential 没有初始化值...");
    return _serverURL_Preferential;
}
-(NSString *)getserverURLWXStudyRecommend{
    NSAssert(_serverURL_WX_Study_Recommend!=nil, @"getserverURLWXStudyRecommend 没有初始化值...");
    return _serverURL_WX_Study_Recommend;
}
-(NSString *)getServerURLStudyPlan{
    NSAssert(_serverURL_StudyPlan!=nil, @"getServerURLStudyPlan 没有初始化值...");
    return _serverURL_StudyPlan;
}
-(NSString *)getServerURLScholarShip{
    NSAssert(_serverURL_ScholarShip!=nil, @"getServerURLScholarShip 没有初始化值...");
    return _serverURL_ScholarShip;
}
-(NSString *)getServerURLAnalytic{
    NSAssert(_serverURL_Analytic!=nil, @"getServerURLAnalytic 没有初始化值...");
    return _serverURL_Analytic;
}
-(NSString *)getServerURLLevelRecommend{
    NSAssert(_serverURL_LevelRecommend!=nil, @"getServerURLLevelRecommend 没有初始化值...");
    return _serverURL_LevelRecommend;
}
-(NSString *)getLbsSocketServerHost{
    NSAssert(_lbsSocketServerHost!=nil, @"getLbsSocketServerHost 没有初始化值...");
    return _lbsSocketServerHost;
}
-(NSString *)getChannelForApplication{
    NSAssert(_channelForApplication!=nil, @"getChannelForApplication 没有初始化值...");
    return _channelForApplication;
}

-(NSString *)getServerURLGame{
    NSAssert(_serverURL_Game!=nil, @"getChannelForApplication 没有初始化值...");
    return _serverURL_Game;
}

-(NSString *)getServerURLAddressManager{
    NSAssert(_serverURL_AddressManager!=nil, @"getChannelForApplication 没有初始化值...");
    return _serverURL_AddressManager;
}

-(NSString *)getServerURLTimeCardPurchase{
    NSAssert(_serverURL_TimeCardPurchase!=nil, @"getChannelForApplication 没有初始化值...");
    return _serverURL_TimeCardPurchase;
}

-(NSString *)getServerURLNoCardInvite{
    NSAssert(_serverURL_NoCardInvite!=nil, @"getChannelForApplication 没有初始化值...");
    return _serverURL_NoCardInvite;
}

-(NSString *)getServerURLThemeClassList{
    NSAssert(_serverURL_ThemeClassList!=nil, @"getChannelForApplication 没有初始化值...");
    return _serverURL_ThemeClassList;
}

-(NSString *)getServerURLUserAgentment{
    NSAssert(_serverURL_UserAgentment!=nil, @"getServerURLUserAgentment 没有初始化值...");
    return _serverURL_UserAgentment;
}

-(NSString *)getServerURLClassServiceAgreement{
    NSAssert(_serverURL_ClassServiceAgreement!=nil, @"getServerURLClassServiceAgreement 没有初始化值...");
    return _serverURL_ClassServiceAgreement;
}

-(NSString *)getServerURLPrivacyAgreement{
    NSAssert(_serverURL_PrivacyAgreement!=nil, @"getServerURLPrivacyAgreement 没有初始化值...");
    return _serverURL_PrivacyAgreement;
}

- (NSString *)getServerURLCourseHelp{
    NSAssert(_serverURL_CourseHelp!=nil, @"getServerURLCourseHelp 没有初始化值...");
    return _serverURL_CourseHelp;
}

- (NSString *)getServerURLFAQ{
    NSAssert(_serverURL_FAQ!=nil, @"getServerURLFAQ 没有初始化值...");
    return _serverURL_FAQ;
}

- (NSString *)getServerURLMyLessonCardsFAQ{
    NSAssert(_serverURL_MyLessonCardsFAQ!=nil, @"getServerURLMyLessonCardsFAQ 没有初始化值...");
    return _serverURL_MyLessonCardsFAQ;
}

- (NSString *)getServerURLReceiptInfo{
    NSAssert(_serverURL_ReceiptInfo!=nil, @"getServerURLReceiptInfo 没有初始化值...");
    return _serverURL_ReceiptInfo;
}

@end
