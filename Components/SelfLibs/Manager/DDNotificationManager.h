//
//  DDNotificationManager.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/6.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,DDReservationListStatus) {
    DDReservationListStatus_Resume = 1,//页面resume时刷新
    DDReservationListStatus_NowNotLoading = 2, //立刻刷新,无loading
};

typedef NS_ENUM(NSInteger,DDCRMMessageType) {
    DDCRMMessageType_Add = 0,//消息数+1
    DDCRMMessageType_Clean = 1, //清空消息
};



#pragma mark - ......::::::: 广播名称 :::::::......
///tabbar 双击广播
UIKIT_EXTERN NSString *const kDDNotificationTabItemDoubleClick;

@interface DDNotificationManager : NSObject

+ (instancetype)shareInstance;

#pragma mark - ......::::::: 广播 :::::::......
/**
 发送广播
 @param notification NSNotificationName
 */
+ (void)postNotification:(NSNotification *)notification;

/**
 发送广播
 @param aName NSNotificationName
 @param anObject id
 */
+ (void)postNotificationName:(NSNotificationName)aName object:(nullable id)anObject;

/**
 发送广播
 @param aName NSNotificationName
 @param anObject id
 @param aUserInfo NSDictionary
 */
+ (void)postNotificationName:(NSNotificationName)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo;

/**
 添加广播监听
 @param observer 监听者
 @param aSelector 方法
 @param aName NSNotificationName
 @param anObject id
 */
+ (void)addObserver:(id)observer selector:(SEL)aSelector name:(nullable NSNotificationName)aName object:(nullable id)anObject;

/**
 移除监听
 @param observer 监听者
 */
+ (void)removeObserver:(id)observer;

/**
 移除监听
 @param observer 监听者
 @param aName NSNotificationName
 @param anObject id
 */
+ (void)removeObserver:(id)observer name:(nullable NSNotificationName)aName object:(nullable id)anObject;


#pragma mark - ......::::::: token失效 :::::::......
/**
 *  发送token失效广播
 */
- (void)postTokenInvalid;

/**
 *  添加token失效
 *  @param observer 监听对象
 *  @param aSelector 相应方法
 */
- (void)addTokenInvalid:(id)observer selector:(SEL)aSelector;

#pragma mark - ......::::::: 版本失效 :::::::......
/**
 *  发送版本失效广播
 */
- (void)postVersonInvalid:(id)object;

/**
 *  添加版本失效
 *  @param observer 监听对象
 *  @param aSelector 相应方法
 */
- (void)addVersonInvalid:(id)observer selector:(SEL)aSelector;

#pragma mark - ......::::::: 消息更新广播 :::::::......
/**
 *  消息更新广播
 */
- (void)postMessageUpdate;

/**
 *  添加消息更新广播
 *  @param observer 监听对象
 *  @param aSelector 相应方法
 */
- (void)addMessageUpdate:(id)observer selector:(SEL)aSelector;

/**
 *  CRM消息更新广播
 */
- (void)postCRMMessageUpdate:(DDCRMMessageType)crmMessageType;

/**
 *  添加CRM消息更新广播
 *  @param observer 监听对象
 *  @param aSelector 相应方法
 */
- (void)addCRMMessageUpdate:(id)observer selector:(SEL)aSelector;

#pragma mark - ......::::::: 更新预约列表 :::::::......
/**
 更新预约列表
 
 *  @param observer 监听对象
 *  @param aSelector 相应方法
 */
- (void)addReservationList:(id)observer selector:(SEL)aSelector;

/**
 发送更新预约列表广播
 */
- (void)postReservationList:(DDReservationListStatus )status;

#pragma mark - ......::::::: 更新用户信息 :::::::......
/**
 更新用户信息
 
 *  @param observer 监听对象
 *  @param aSelector 相应方法
 */
- (void)addUserInfo:(id)observer selector:(SEL)aSelector;

/**
 发送更新用户信息
 */
- (void)postUserInfo;
#pragma mark - ......::::::: dialog优先级广播 :::::::......
/**
 Dialog优先级广播
 @param observer 监听对象
 @param aSelector 相应方法
 */
- (void)addDialogPriorityHigh:(id)observer selector:(SEL)aSelector;

/** 发送Dialog优先级广播 */
- (void)postDialogPriorityHigh:(id)object;

#pragma mark - ......::::::: 用户退出登录广播 :::::::......
/**
 用户退出
 @param observer 监听对象
 @param aSelector 相应方法
 */
- (void)addUserLogout:(id)observer selector:(SEL)aSelector;

/** 发送用户退出 */
- (void)postUserLogout;

#pragma mark - ......::::::: 系统初始化数据更新 :::::::......
/**
 系统初始化数据更新
 @param observer 监听对象
 @param aSelector 相应方法
 */
- (void)addThemeConfig:(id)observer selector:(SEL)aSelector;

/** 发送系统初始化数据更新 */
- (void)postThemeConfig;

#pragma mark - ......::::::: 提示上课弹窗 :::::::......
/**
 提示上课弹窗
 @param observer 监听对象
 @param aSelector 相应方法
 */
- (void)addStartLessonDialog:(id)observer selector:(SEL)aSelector;

/** 发送提示上课弹窗 */
- (void)postStartLessonDialog;

#pragma mark - ......::::::: 新课时列表刷新通知 :::::::......
/**
 新课时列表刷新上课弹窗
 @param observer 监听对象
 @param aSelector 相应方法
 */
- (void)addNewLessonListRefresh:(id)observer selector:(SEL)aSelector;

/** 刷新列表 */
- (void)postNewLessonListRefresh:(id)data;

#pragma mark - ......::::::: 新课程列表刷新通知 :::::::......
/**
 新课程列表刷新通知
 @param observer 监听对象
 @param aSelector 相应方法
 */
- (void)addNewCourseListRefresh:(id)observer selector:(SEL)aSelector;

/** 刷新列表 */
- (void)postNewCourseListRefresh:(id)data;

#pragma mark - ......::::::: 课时卡片刷新 :::::::......
/**
 课时卡片刷新
 @param observer 监听对象
 @param aSelector 相应方法
 */
- (void)addNewCardRefresh:(id)observer selector:(SEL)aSelector;

/** 刷新列表 */
- (void)postNewCardRefresh:(id)data;

#pragma mark - ......::::::: 通用通知UI刷新 :::::::......
/**
 通用通知UI刷新
 @param observer 监听对象
 @param aSelector 相应方法
 */
- (void)addUIRefresh:(id)observer selector:(SEL)aSelector;

/** 刷新 */
- (void)postUIRefresh:(id)data;

#pragma mark - ......::::::: 配音秀分享 :::::::......
/**
 配音秀分享
 @param observer 监听对象
 @param aSelector 相应方法
 */
- (void)addShareDub:(id)observer selector:(SEL)aSelector;

/** 刷新 */
- (void)postShareDub:(id)data;

#pragma mark - ......::::::: 绘本岛 - 搜索 :::::::......
/**
 绘本岛 - 搜索
 @param observer 监听对象
 @param aSelector 相应方法
 */
- (void)addSearch:(id)observer selector:(SEL)aSelector;

/** 刷新 */
- (void)postSearch:(id)data;


#pragma mark - ......::::::: 流视图信息打印 :::::::......
/**
 添加展示流信息视图信息打印
 @param observer 监听对象
 @param aSelector 相应方法
 */
- (void)addDisplayLiveStreamViewInfo:(id)observer selector:(SEL)aSelector;

/**
 发送流信息打印
 @param fromWhere 发起来源
 */
- (void)postDisplayLiveStreamViewInfo:(NSString *)fromWhere;

#pragma mark - ......::::::: 约课成功通知 :::::::......
/**
 约课成功通知
 @param observer 监听对象
 @param aSelector 相应方法
 */
- (void)addBespeakSuccess:(id)observer selector:(SEL)aSelector;

/** 刷新 */
- (void)postBespeakSuccess:(id)data;

#pragma mark - ......::::::: 课程数据拉取成功通知 :::::::......
/**
  课程数据拉取成功通知
 @param observer 监听对象
 @param aSelector 相应方法
 */
- (void)addCourseSuccess:(id)observer selector:(SEL)aSelector;

/** 刷新 */
- (void)postCourseSuccess:(id)data;

@end
NS_ASSUME_NONNULL_END
