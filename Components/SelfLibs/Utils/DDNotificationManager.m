//
//  DDNotificationManager.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/6.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "DDNotificationManager.h"


#define DDNotificationCenter [NSNotificationCenter defaultCenter]

///tabbar 双击广播
NSString *const kDDNotificationTabItemDoubleClick = @"kDDNotificationTabItemDoubleClick";

@implementation DDNotificationManager
/**  token失效 */
static NSString *const kNotificationTokenInvalid=@"kNotificationTokenInvalid";
/**  版本失效 */
static NSString *const kNotificationVersonInvalid=@"kNotificationVersonInvalid";
/**  消息更新广播 */
static NSString *const kNotificationMessageUpdate=@"kNotificationMessageUpdate";
/**  CRM消息更新广播 */
static NSString *const kNotificationCRMMessageUpdate=@"kNotificationCRMMessageUpdate";
/**  更新预约列表 */
static NSString *const kNotificationReservationList=@"kNotificationReservationList";
/**  更新用户信息 */
static NSString *const kNotificationUserInfo=@"kNotificationUserInfo";
/**  对话框监听广播，当收到此广播不是自己发送的则关闭自己 */
static NSString *const kNotificationDialogPriorityHigh = @"kNotificationDialogPriorityHigh";
/**  用户退出 */
static NSString *const kNotificationLogoutUser=@"kNotificationLogoutUser";
/**  系统风格变更 */
static NSString *const kNotificationThemeConfig=@"kNotificationThemeConfig";
/**  系统初始化数据更新 */
static NSString *const kNotificationSystemInitConfig=@"kNotificationSystemInitConfig";
/**  预约上课弹窗提示 */
static NSString *const kNotificationStartLessonDialog=@"kkNotificationStartLessonDialog";
/**  新课时列表刷新通知 */
static NSString *const kNotificationNewLessonListRefresh=@"kNotificationNewLessonListRefresh";
/**  新课程列表刷新通知 */
static NSString *const kNotificationNewCourseListRefresh=@"kNotificationNewCourseListRefresh";
/**  课时卡片刷新通知 */
static NSString *const kNotificationNewCardRefresh=@"kNotificationNewCardRefresh";
/**  通用通知UI刷新 */
static NSString *const kNotificationUIRefresh=@"kNotificationUIRefresh";
/**  配音秀 */
static NSString *const kNotificationShareDub=@"kNotificationShareDub";
/**  绘本课 - 听一听 */
static NSString *const kNotificationListen=@"kNotificationListen";
/**  绘本 - 搜索 */
static NSString *const kNotificationSearch=@"kNotificationSearch";
/** 流视图信息打印 */
static NSString *const kNotificationDisplayLiveStreamViewInfo=@"kNotificationDisplayLiveStreamViewInfo";
/**  约课成功通知 */
static NSString *const kNotificationBespeakSuccess=@"kNotificationBespeakSuccess";
/**  课程数据成功通知 */
static NSString *const kNotificationCourseListSuccess=@"kNotificationCourseListSuccess";
+ (instancetype)shareInstance{
    id instance = [[self.class alloc] init];
    return instance;
}

#pragma mark - ......::::::: 发送广播 :::::::......
/**
 发送广播
 @param notification NSNotificationName
 */
+ (void)postNotification:(NSNotification *)notification{
    dispatch_sync_on_main_queue(^{
        [DDNotificationCenter postNotification:notification];
    });
}

/**
 发送广播
 @param aName NSNotificationName
 @param anObject id
 */
+ (void)postNotificationName:(NSNotificationName)aName object:(nullable id)anObject{
    dispatch_sync_on_main_queue(^{
        [DDNotificationCenter postNotificationName:aName object:anObject];
    });
}

/**
 发送广播
 @param aName NSNotificationName
 @param anObject id
 @param aUserInfo NSDictionary
 */
+ (void)postNotificationName:(NSNotificationName)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo{
    dispatch_sync_on_main_queue(^{
        [DDNotificationCenter postNotificationName:aName object:anObject userInfo:aUserInfo];
    });
}

/**
 添加广播监听
 @param observer 监听者
 @param aSelector 方法
 @param aName NSNotificationName
 @param anObject id
 */
+ (void)addObserver:(id)observer selector:(SEL)aSelector name:(nullable NSNotificationName)aName object:(nullable id)anObject{
    [DDNotificationCenter addObserver:observer selector:aSelector name:aName object:anObject];
}

/**
 移除监听
 @param observer 监听者
 */
+ (void)removeObserver:(id)observer{
    [DDNotificationCenter removeObserver:observer];
}

/**
 移除监听
 @param observer 监听者
 @param aName NSNotificationName
 @param anObject id
 */
+ (void)removeObserver:(id)observer name:(nullable NSNotificationName)aName object:(nullable id)anObject{
    [DDNotificationCenter removeObserver:observer name:aName object:anObject];
}

#pragma mark - ......::::::: token失效 :::::::......
/**
 *  发送token失效广播
 */
- (void)postTokenInvalid{
    [self.class postNotificationName:kNotificationTokenInvalid object:nil];
}

/**
 *  添加token失效
 *  @param observer 监听对象
 *  @param aSelector 相应方法
 */
- (void)addTokenInvalid:(id)observer selector:(SEL)aSelector{
    [self.class addObserver:observer selector:aSelector name:kNotificationTokenInvalid object:nil];
}

#pragma mark  版本失效
/**
 *  发送版本失效广播
 */
- (void)postVersonInvalid:(id)object{
    [self.class postNotificationName:kNotificationVersonInvalid object:object];
}

/**
 *  添加版本失效
 *  @param observer 监听对象
 *  @param aSelector 相应方法
 */
- (void)addVersonInvalid:(id)observer selector:(SEL)aSelector{
    [self.class addObserver:observer selector:aSelector name:kNotificationVersonInvalid object:nil];
}

#pragma mark - ......::::::: 消息更新广播 :::::::......
/**
 *  消息更新广播
 */
- (void)postMessageUpdate{
    [self.class postNotificationName:kNotificationMessageUpdate object:nil];
}

/**
 *  添加消息更新广播
 *  @param observer 监听对象
 *  @param aSelector 相应方法
 */
- (void)addMessageUpdate:(id)observer selector:(SEL)aSelector{
    [self.class addObserver:observer selector:aSelector name:kNotificationMessageUpdate object:nil];
}

/**
 *  CRM消息更新广播
 */
- (void)postCRMMessageUpdate:(DDCRMMessageType)crmMessageType{
    [self.class postNotificationName:kNotificationCRMMessageUpdate object:@(crmMessageType)];
}

/**
 *  添加CRM消息更新广播
 *  @param observer 监听对象
 *  @param aSelector 相应方法
 */
- (void)addCRMMessageUpdate:(id)observer selector:(SEL)aSelector{
    [self.class addObserver:observer selector:aSelector name:kNotificationCRMMessageUpdate object:nil];
}

#pragma mark - ......::::::: 更新预约列表 :::::::......
/**
 更新预约列表
 
 *  @param observer 监听对象
 *  @param aSelector 相应方法
 */
- (void)addReservationList:(id)observer selector:(SEL)aSelector {
    [self.class addObserver:observer selector:aSelector name:kNotificationReservationList object:nil];
}


/**
 发送更新预约列表广播
 */
- (void)postReservationList:(DDReservationListStatus )status{
    [self.class postNotificationName:kNotificationReservationList object:@(status)];
}

#pragma mark - ......::::::: 更新用户信息 :::::::......
/**
 更新用户信息
 
 *  @param observer 监听对象
 *  @param aSelector 相应方法
 */
- (void)addUserInfo:(id)observer selector:(SEL)aSelector{
    [self.class addObserver:observer selector:aSelector name:kNotificationUserInfo object:nil];
}

/**
 发送更新用户信息
 */
- (void)postUserInfo{
    [self.class postNotificationName:kNotificationUserInfo object:nil];
}


#pragma mark - ......::::::: dialog优先级广播 :::::::......
/**
 Dialog优先级广播
 @param observer 监听对象
 @param aSelector 相应方法
 */
- (void)addDialogPriorityHigh:(id)observer selector:(SEL)aSelector {
    [self.class addObserver:observer selector:aSelector name:kNotificationDialogPriorityHigh object:nil];
}

/** 发送Dialog优先级广播 */
- (void)postDialogPriorityHigh:(id)object{
    [self.class postNotificationName:kNotificationDialogPriorityHigh object:object];
}

#pragma mark - ......::::::: dialog优先级广播 :::::::......
/**
 用户退出
 @param observer 监听对象
 @param aSelector 相应方法
 */
- (void)addUserLogout:(id)observer selector:(SEL)aSelector {
    [self.class addObserver:observer selector:aSelector name:kNotificationLogoutUser object:nil];
}

/** 发送用户退出 */
- (void)postUserLogout{
    [self.class postNotificationName:kNotificationLogoutUser object:nil];
}

#pragma mark - ......::::::: 系统初始化数据更新 :::::::......
/**
 系统初始化数据更新
 @param observer 监听对象
 @param aSelector 相应方法
 */
- (void)addThemeConfig:(id)observer selector:(SEL)aSelector{
    [self.class addObserver:observer selector:aSelector name:kNotificationSystemInitConfig object:nil];
}

/** 发送系统初始化数据更新 */
- (void)postThemeConfig{
    [self.class postNotificationName:kNotificationSystemInitConfig object:nil];
}

#pragma mark - ......::::::: 提示上课弹窗 :::::::......
/**
 提示上课弹窗
 @param observer 监听对象
 @param aSelector 相应方法
 */
- (void)addStartLessonDialog:(id)observer selector:(SEL)aSelector{
    [self.class addObserver:observer selector:aSelector name:kNotificationStartLessonDialog object:nil];
}

/** 发送提示上课弹窗 */
- (void)postStartLessonDialog{
    [self.class postNotificationName:kNotificationStartLessonDialog object:nil];
}


#pragma mark - ......::::::: 新课时列表刷新通知 :::::::......
/**
 新课时列表刷新上课弹窗
 @param observer 监听对象
 @param aSelector 相应方法
 */
- (void)addNewLessonListRefresh:(id)observer selector:(SEL)aSelector{
    [self.class addObserver:observer selector:aSelector name:kNotificationNewLessonListRefresh object:nil];
}

/** 刷新列表 */
- (void)postNewLessonListRefresh:(id)data{
    [self.class postNotificationName:kNotificationNewLessonListRefresh object:data];
}

#pragma mark - ......::::::: 新课程列表刷新通知 :::::::......
/**
 新课程列表刷新通知
 @param observer 监听对象
 @param aSelector 相应方法
 */
- (void)addNewCourseListRefresh:(id)observer selector:(SEL)aSelector{
    [self.class addObserver:observer selector:aSelector name:kNotificationNewCourseListRefresh object:nil];
}

/** 刷新列表 */
- (void)postNewCourseListRefresh:(id)data{
    [self.class postNotificationName:kNotificationNewCourseListRefresh object:data];
}

#pragma mark - ......::::::: 课时卡片刷新 :::::::......
/**
 课时卡片刷新
 @param observer 监听对象
 @param aSelector 相应方法
 */
- (void)addNewCardRefresh:(id)observer selector:(SEL)aSelector{
    [self.class addObserver:observer selector:aSelector name:kNotificationNewCardRefresh object:nil];
}

/** 刷新列表 */
- (void)postNewCardRefresh:(id)data{
    [self.class postNotificationName:kNotificationNewCardRefresh object:data];
}

#pragma mark - ......::::::: 通用通知UI刷新 :::::::......
/**
 通用通知UI刷新
 @param observer 监听对象
 @param aSelector 相应方法
 */
- (void)addUIRefresh:(id)observer selector:(SEL)aSelector{
    [self.class addObserver:observer selector:aSelector name:kNotificationUIRefresh object:nil];
}

/** 刷新 */
- (void)postUIRefresh:(id)data{
    [self.class postNotificationName:kNotificationUIRefresh object:data];
}

#pragma mark - ......::::::: 配音秀分享 :::::::......
/**
 配音秀分享
 @param observer 监听对象
 @param aSelector 相应方法
 */
- (void)addShareDub:(id)observer selector:(SEL)aSelector{
    [self.class addObserver:observer selector:aSelector name:kNotificationShareDub object:nil];
}

/** 刷新 */
- (void)postShareDub:(id)data{
    [self.class postNotificationName:kNotificationShareDub object:data];
}

#pragma mark - ......::::::: 绘本岛 - 搜索 :::::::......
/**
 绘本岛 - 搜索
 @param observer 监听对象
 @param aSelector 相应方法
 */
- (void)addSearch:(id)observer selector:(SEL)aSelector{
     [self.class addObserver:observer selector:aSelector name:kNotificationSearch object:nil];
}

/** 刷新 */
- (void)postSearch:(id)data{
    [self.class postNotificationName:kNotificationSearch object:data];
}


#pragma mark - ......::::::: 流视图信息打印 :::::::......
/**
 添加展示流信息视图信息打印
 @param observer 监听对象
 @param aSelector 相应方法
 */
- (void)addDisplayLiveStreamViewInfo:(id)observer selector:(SEL)aSelector{
     [self.class addObserver:observer selector:aSelector name:kNotificationDisplayLiveStreamViewInfo object:nil];
}

/**
 发送流信息打印
 @param fromWhere 发起来源
 */
- (void)postDisplayLiveStreamViewInfo:(NSString *)fromWhere{
    [self.class postNotificationName:kNotificationDisplayLiveStreamViewInfo object:fromWhere];
}

#pragma mark - ......::::::: 约课成功通知 :::::::......
/**
 约课成功通知
 @param observer 监听对象
 @param aSelector 相应方法
 */
- (void)addBespeakSuccess:(id)observer selector:(SEL)aSelector{
    [self.class addObserver:observer selector:aSelector name:kNotificationBespeakSuccess object:nil];
}

/** 刷新 */
- (void)postBespeakSuccess:(id)data{
    [self.class postNotificationName:kNotificationBespeakSuccess object:data];
}

#pragma mark - ......::::::: 课程数据拉取成功通知 :::::::......
/**
  课程数据拉取成功通知
 @param observer 监听对象
 @param aSelector 相应方法
 */
- (void)addCourseSuccess:(id)observer selector:(SEL)aSelector{
    [self.class addObserver:observer selector:aSelector name:kNotificationCourseListSuccess object:nil];
}

/** 刷新 */
- (void)postCourseSuccess:(id)data{
    [self.class postNotificationName:kNotificationCourseListSuccess object:data];
}


@end



