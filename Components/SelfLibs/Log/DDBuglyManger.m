//
//  DDBuglyManger.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2019/1/7.
//  Copyright © 2019 ddkt365. All rights reserved.
//

#import "DDBuglyManger.h"
#import <Bugly/Bugly.h>

@interface DDBuglyManger()<BuglyDelegate>

@end

@implementation DDBuglyManger

+ (instancetype)shareInstance{
    static id _this = nil;
    static dispatch_once_t onceTokenInit;
    dispatch_once(&onceTokenInit, ^{
        _this = [[self.class alloc] init];
    });
    return _this;
}

-(BuglyConfig *)buglyConfig{
    BuglyConfig * config = [[BuglyConfig alloc] init];
    //设置自定义版本号
    config.version = kAppReleaseVersionBuilder;
#ifdef DEBUG_MODE
    config.reportLogLevel = BuglyLogLevelVerbose;
    config.debugMode = YES;
    //卡顿监控开关，默认关闭
    config.blockMonitorEnable = YES;
    //卡顿监控判断间隔，单位为秒
    config.blockMonitorTimeout = 3.5;
    //非正常退出事件记录开关，默认关闭
    //config.unexpectedTerminatingDetectionEnable = YES;
#else
    config.debugMode = NO;
    // 设置自定义日志上报的级别，默认不上报自定义日志
    config.reportLogLevel = BuglyLogLevelWarn;
#endif
    //设置自定义渠道标识
    config.channel = kAppConfig.channelForApplication;
    config.delegate = self;
    return config;
}

#pragma -mark 注册腾讯Bugly
/**
 注册腾讯Bugly
 */
-(void)registerBugly{
    BuglyConfig * config = [self buglyConfig];
    //启动监听
    [Bugly startWithAppId:kPlatform_BuglyKey
#if DEBUG
        developmentDevice:YES
#endif
                   config:config];
    //登录bugly,现网已登录用户
    [[DDBuglyManger shareInstance] loginBugly];
}

#pragma mark - ......::::::: 保存crash上传成功的标志位 :::::::......
static NSString *const kKeyUploadCrashReportFail = @"kKeyUploadCrashReportFail";
/**
 保存为crash日志上传失败
 */
-(void)saveUploadCrashReportFail{
    NSUserDefaults *uds = [NSUserDefaults standardUserDefaults];
    [uds setBool:YES forKey:kKeyUploadCrashReportFail];
    [uds synchronize];
}

/**
 清除crash日志上传失败标识量
 */
-(void)removeUploadCrashReportFail{
    NSUserDefaults *uds = [NSUserDefaults standardUserDefaults];
    [uds removeObjectForKey:kKeyUploadCrashReportFail];
    [uds synchronize];
}

/**
 获取日志上传是否失败过
 */
-(BOOL)isUploadCrashReportFail{
    NSUserDefaults *uds = [NSUserDefaults standardUserDefaults];
    return [uds boolForKey:kKeyUploadCrashReportFail];
}

@end
