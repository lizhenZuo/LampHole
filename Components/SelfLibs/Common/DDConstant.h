//
//  DDConstant.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/8/25.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

/**   用于定义全局常量  */
#ifndef DDConstant_h
#define DDConstant_h

/** js版本号(用户后台交互，使用不同的index.html) */
static NSString *const kPPTJavascriptVersion = @"v6";
#pragma mark - ......::::::: 静态地址 :::::::......
/** 用户注册协议 */
static NSString *const kStaticURL_Register = @"https://h5.ddkt365.com/h5/reg-agreement";
/** 常见问题 */
static NSString *const kStaticURL_FAQ = @"https://h5.ddkt365.com/h5/help-v2";
/** 课时卡说明 */
static NSString *const kStaticURL_MyLessonCardsFAQ = @"https://h5.ddkt365.com/h5/course-explain";
/** Airplay使用说明 */
static NSString *const kStaticURL_AirPlayInstruction = @"https://h5.ddkt365.com/h5/ios-airplay-instruction";

#pragma mark - ......::::::: 请求头key :::::::......
//ios  3、iphone
static NSString *const kDDHttpHeaderKeyClient = @"ddclient";
//当前版本名称
static NSString *const kDDHttpHeaderKeyVersion = @"ddversion";
//token
static NSString *const kDDHttpHeaderKeyToken = @"ddtoken";
//神策idkey
static NSString *const kDDHttpHeaderKeyDistinctId = @"dddistinctid";
//设备类型  1、iPhone 2、iPad 3、Android Phone 4、Android Pad
static NSString *const kDDHttpHeaderKeyDeviceType = @"dddevicetype";
//app是否为审核中
static NSString *const kDDHttpHeaderKeyInReview = @"ddinreview";
//app登录Token
static NSString *const kDDHttpHeaderKeyAuthKey = @"authkey";

//设备类型 3、iphone
static inline NSString *const kAppReleaseKeyClientType(){
    return @"3";
}
#pragma mark - ......::::::: 性别 1、男 2、女 0、其他:::::::......
typedef NS_ENUM(NSInteger, DDSex){
    DDSex_None = 0,
    DDSex_Boy = 1,
    DDSex_Girl = 2,
};

#pragma mark - ......::::::: 状态码 :::::::......
//请求成功 code
static NSString *const kDDHttpResponseSuccess = @"0";
//token失效 code 
static NSString *const kDDHttpResponseTokenInvalid = @"9999";
//版本失效 code
static NSString *const kDDHttpResponseVersonInvalid = @"9000";
//服务器500错误
static NSString *const kDDHttpResponseServerNotResponse = @"500";
//微信未绑定
static NSString *const kDDHttpResponseWXUnBind = @"9980";

#pragma mark - ......::::::: 定义全局枚举 :::::::......
/** 课程类型 */
typedef NS_ENUM(NSInteger, DDCourseState) {
    DDCourseTypeAll = 0,//所有课程
    DDCourseStateMajor = 1,//美国小学
    DDCourseStateMinor = 2,//自然拼读
};

/** 学习乐园类型 */
typedef NS_ENUM(NSInteger, DDFindState) {
    DDFindTypeAll = 0,//所有类型
    DDFindStateAlphabet = 1,//字母歌
    DDFindStateBook = 2,//绘本
    DDFindStateSong = 3,//儿歌
};

/** 学习状态 */
typedef NS_ENUM(NSInteger, DDLearnState) {
    DDLearnStateNone = 0,
    DDLearnStateCurrent, // 当前学习
    DDLearnStateRecommend, // 推荐学习
    DDLearnStateCustom, // 定制学
};



static NSString *const kNameAmericanSchool = @"美国小学";
static NSString *const kNamePhonics = @"自然拼读";
static NSString *const kNameMajor = @"英语课程";
static NSString *const kNamePurchase = @"课时购买";
static NSString *const kNameFind = @"学习乐园";
static NSString *const kNameGift = @"礼物兑换";

static NSString *const kMeItemName_WXStudyRemind = @"微信学习提醒";
static NSString *const kMeItemName_StudyPlan = @"学习计划";
static NSString *const kMeItemName_AccountSystem = @"我的账户";
static NSString *const kMeItemName_StudyReport = @"学习报告";
static NSString *const kMeItemName_LessonHistory = @"上课记录";
static NSString *const kMeItemName_BugHistory = @"购买记录";
static NSString *const kMeItemName_GitHistory = @"礼物兑换记录";
static NSString *const kMeItemName_MyPictureBook = @"我的绘本跟读";
static NSString *const kMeItemName_AddressManager = @"收货信息";
static NSString *const kMeItemName_Dub = @"我的配音秀";

static NSString *const kMeItemName_Scholarship = @"奖学金";
static NSString *const kMeItemName_MyOrderList = @"我的订单";
static NSString *const KMeItemName_Setting = @"设置";

static NSInteger const kNameMajorIndex = 1; // 英语课程 tab_index
static NSInteger const kNameFindIndex = 2; // 学习乐园 tab_index
static NSInteger const kNamePurchaseIndex = 4; // 课时购买 tab_index
static NSInteger const kNameHomeTaskIndex = 5; // 首页任务红点 

#pragma mark - ......::::::: 验证码类型 :::::::......
typedef NS_ENUM(NSInteger, DDVerifyCodeType) {
    DDVerifyCodeType_Registe = 1,//注册
    DDVerifyCodeType_BindWechat = 2,//绑定微信
    DDVerifyCodeType_FindPwd = 3,//找回密码
    DDVerifyCodeType_Login = 4,//登录
    DDVerifyCodeType_CreatePwd = 5, //创建登录密码
    DDVerifyCodeType_LoginORRegiter = 11,//新版登录或者注册
    DDVerifyCodeType_SecurityMobile = 19,//验证旧手机号
    DDVerifyCodeType_ChangeMobile = 20,//修改手机号
    DDVerifyCodeType_CancellationAccount = 99,//注销账号
};

#pragma mark - ......::::::: 登录页面类型 :::::::......
typedef NS_ENUM(NSInteger, LOGIN_TYPE)
{
    LOGIN_TYPE_DEFAULT = 0,
    LOGIN_TYPE_AddDev = 1,
};

#pragma mark - ......::::::: 播放模式 :::::::......
typedef NS_ENUM(NSInteger,DDAudioPlayState) {
    DDAudioPlayState_none = 0, //初始状态
    DDAudioPlayState_ing = 1, //播放
    DDAudioPlayState_pause = 2,//暂停
    DDAudioPlayState_stop = 3,//停止
    DDAudioPlayState_destory = 4,//销毁
    DDAudioPlayState_finish = 5, //播放结束
};

#pragma mark - ......::::::: 页面刷新模式 :::::::......
typedef NS_ENUM(NSInteger, REFRESH_TYPE)
{
    REFRESH_TYPE_HEADER = 0,
    REFRESH_TYPE_FOOTER,
};

#pragma mark - ......::::::: 叮咚币/课时卡购买模式 :::::::......
typedef NS_ENUM(NSInteger, PURCHASE_CONFIRM_TYPE)
{
    PURCHASE_CONFIRM_TYPE_DEFAULT = 0, //不上报
    PURCHASE_CONFIRM_TYPE_SCHOLARSHIP = 1, //奖学金页面
    PURCHASE_CONFIRM_TYPE_H5 = 2,  //H5活动页，iOS端用不到
    PURCHASE_CONFIRM_TYPE_CARDTIME = 3,  //课时卡页面(账户体系入口)
    PURCHASE_CONFIRM_TYPE_CLASS_RECORD = 4, //上课记录页面购买
    PURCHASE_CONFIRM_TYPE_PURCHASE_SUCCESS = 5, //购买记录成功页面再次购买
    PURCHASE_CONFIRM_TYPE_PURCHASE_CANCEL = 6, //购买记录取消订单再次购买
    PURCHASE_CONFIRM_TYPE_MY_ACCOUNT = 7, //我的账户
    PURCHASE_CONFIRM_TYPE_RECHASE_RECORD = 8, //叮咚币充值记录
    PURCHASE_CONFIRM_TYPE_TIME_CARD = 9, //课时购买 (课时卡入口)
    PURCHASE_CONFIRM_TYPE_LIMIT_TIME_ORIGIN = 10, //原生限时购买
    PURCHASE_CONFIRM_TYPE_LIMIT_TIME_H5_BANNER = 11, //H5限时购买（banner点击进入）
    PURCHASE_CONFIRM_TYPE_LIMIT_TIME_H5_HOME = 12, //H5限时购买（首页进入）
    PURCHASE_CONFIRM_TYPE_LIMIT_TIME_H5_AFTER_CLASS = 13, //H5限时购买（课后进入）
    PURCHASE_CONFIRM_TYPE_LIMIT_TIME_H5_HOME_ADVERTIS = 14, //首页悬浮框进去H5限时优惠
    PURCHASE_CONFIRM_TYPE_LIMIT_TIME_H5_COURSE_LIST_ADVERTIS = 15, //课时列表悬浮框进去H5限时优惠
};

//SAP管理的Room的状态
typedef NS_ENUM(NSInteger, SAP_ROOM_STATUS)
{
    SAP_ROOM_STATUS_NORMAL,//初始状态，也就是连接SAP转态
    SAP_ROOM_STATUS_SAP_JOIN,//加入SAP
    //    SAP_ROOM_STATUS_SAP_JOIN_SUCCESS,//加入SAP成功,每三十秒发送一次心跳(此状态可以不要)
    SAP_ROOM_STATUS_WAIT_MATCH,//等待match（检测到是此状态应该发起匹配）
    SAP_ROOM_STATUS_MATCHING,//正在匹配中
    SAP_ROOM_STATUS_STOP_MATCHING,//停止匹配
    SAP_ROOM_STATUS_CLASSING,//表示有了可以上课的房间，可以开始连接Room服务器
    SAP_ROOM_STATUS_CLASS_END,//表示课程结束，同时也可以开始重新预约
    SAP_ROOM_STATUS_RECONNECT_SAP,//处于重连状态（此状态需要重连）
    SAP_ROOM_STATUS_STOP //表示此状态已经停止，需要重新激活
};

//Room的状态
typedef NS_ENUM(NSInteger, DDLessonRoomSocketState) {
    DDLessonRoomSocketState_UnJoinSap = 0,//说明还没有连接上SAP，需要用LBS开始重新开始
    DDLessonRoomSocketState_MatchRoom,//表示需要math
    DDLessonRoomSocketState_ReJoinRoom,//表示直接进入Room服务器
    DDLessonRoomSocketState_OverRoom//表示课程已经结束
};

typedef NS_ENUM(NSInteger, DDStudentVideoType){
    DDStudentVideoType_Open,
    DDStudentVideoType_Close,
};

#pragma mark - ......::::::: 账户相关 :::::::......
static int const kMinAccountLenght = 6;//账户长度
static int const kMaxAccountLenght = 11;//账户长度
static int const kMaxVerifyCodeLenght = 4;//验证码长度
static int const kMinPasswordLenght = 6;//最少密码长度
static int const kMaxPasswordLenght = 12;//最大密码长度
static int const kMaxVerifyCodeTimer = 60;//验证码时长
static int const kMaxNickNameLenght = 15;//昵称最大长度
static int const kMaxRoomIdLenght = 20;//roomid长度
static int const kMinSchoolVerifyCodeLength = 8;//校园验证码最小长度
static int const kMaxSchoolVerifyCodeLength = 10;//校园验证码最大长度

#pragma mark - ......::::::: 动画时长 :::::::......
static CGFloat const kDDAnimationDurationShort = 0.15f;
static CGFloat const kDDAnimationDurationNormal = 0.2f;
static CGFloat const kDDAnimationDurationLong = 0.3f;

#pragma mark - ......::::::: 屏幕宽度 :::::::......
static NSInteger const kDDPageSizeDefault = 20;//默认翻页数据总数
static NSInteger const kiPhoneXAdaptiveNumber = 30;//iphonex 侧边宽度适配
static NSInteger const kiPhoneStatusBarHeight = 20; //时间状态栏的高度
static NSInteger const kCommonMarginHeight = 10;//通用的高度间距，tableview collectionview margin height
static NSInteger const kLeadingIPhoneXValue = kCommonMarginHeight + kiPhoneXAdaptiveNumber;//iphonex 侧边宽度适配
//导航栏高度
static inline CGFloat const kCustonNavigationBarHeight() {
    if (DDisiPad) {
        return 110;
    }else{
        return 70;
    }
}
static inline CGFloat const kDDNavigationBarHeight() {
    return [[UIApplication sharedApplication] statusBarFrame].size.height + 44;
}

#define kDDNavigationBarHeight kDDNavigationBarHeight()
#define kCustonNavigationBarHeight kCustonNavigationBarHeight()
/** 导航栏最低透明度 */
static CGFloat const kCustonNavigationMinAlpha = 0.6f;
/** socket心跳时间 */
static CGFloat const kIMHearBeatTime = 10.f;
/** webview广告弹窗 X 按钮的显示延迟时间 */
static CGFloat const kAdvertWebViewAfterDelay = 3.f;

#pragma mark - ......::::::: 解压路径配置 :::::::......
/** eg:document/kUnzipDir_root */
static NSString *const kUnzipDir_root = @"unzipdir";//解压的root目录
/** eg:kUnzipDir_root/kUnzipDir_root/kUnzipDir_video */
static NSString *const kUnzipDir_video = @"video";//视频解压文件目录
/** eg:kUnzipDir_root/kUnzipDir_finishOrderVideo */
static NSString *const kUnzipDir_finishOrderVideo = @"finishordervideo";//关单视频解压文件目录
/** eg:kUnzipDir_root/kUnzipDir_fydingdongh5 */
static NSString *const kUnzipDir_fydingdongh5 = @"fydingdongh5";//解压的父级目录
/** eg:kUnzipDir_root/kUnzipDir_fydingdongh5/kUnzipDir_ppt */
static NSString *const kUnzipDir_ppt = @"ppt";//ppt解压目录
/** eg:kUnzipDir_root/kUnzipDir_fydingdongh5/kDDWebResourseIndexHtmlName */
static NSString *const kDDWebResourseIndexHtmlName = @"index_web_v5.html";//app打包在资源包的html索引
/** eg:kUnzipDir_root/kUnzipDir_fydingdongh5/kDDWebResourseIndexHtmlName_Math */
static NSString *const kDDWebResourseIndexHtmlName_Math = @"index_math_v6.html";//app打包在资源包的数学html索引

typedef NSString *DDLessonServiceManagerType NS_TYPED_ENUM;
static DDLessonServiceManagerType const DDLessonServiceManagerType_Preview=@"preview";//预习
static DDLessonServiceManagerType const DDLessonServiceManagerType_Lesson=@"lesson";//上课
static DDLessonServiceManagerType const DDLessonServiceManagerType_Review=@"review";//复习
static DDLessonServiceManagerType const DDLessonServiceManagerType_PicBook=@"picbook";//绘本
static DDLessonServiceManagerType const DDLessonServiceManagerType_Dub=@"dub";//配音
static DDLessonServiceManagerType const DDLessonServiceManagerType_Listen=@"listen";//听一听

/** 分享相关文案 */
static NSString *const kShareStr_NotInstallCommon = @"当前设备暂不支持分享";
static NSString *const kShareStr_NotInstallCommon_Activity = @"检测到您的设备未安装微信，暂时不能分享该活动";

static NSString *const kShareStr_NotInstallCommon_Remind = @"检测到您的设备未安装微信，暂时不能获取学习提醒";
static NSString *const kShareStr_NotInstallCommon_Discounts = @"检测到您的设备未安装微信，暂时不能获取优惠";
static NSString *const kShareStr_NotInstallCommon_Login = @"检测到您的设备未安装微信，暂时不能微信登录";



#endif /* DDConstant_h */
