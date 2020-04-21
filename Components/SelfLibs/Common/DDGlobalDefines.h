//
//  DDGlobalDefines.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/8/25.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

/**  全局宏定义，所有需要用到的宏全部卸载这里  */
#ifndef DDGlobalDefines_h
#define DDGlobalDefines_h

#ifdef __cplusplus
extern "C" {
#endif

/** 屏幕宽高*/
#define kDDScreenWidth [UIScreen mainScreen].bounds.size.width
#define kDDScreenHeight [UIScreen mainScreen].bounds.size.height

#define kDDApplicationWindow  [[UIApplication sharedApplication].delegate window]

//判断系统是IOS10以后
#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS10Later ([UIDevice currentDevice].systemVersion.floatValue >= 10.0f)
#define iOS11Later ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f)

#define kNotification [NSNotificationCenter defaultCenter]
#define kUserDefaults [NSUserDefaults standardUserDefaults]

/** 锁 */
#define DDLock() dispatch_semaphore_wait(self->_lock, DISPATCH_TIME_FOREVER)
#define DDUnlock() dispatch_semaphore_signal(self->_lock)
/** 子类重载预言 */
#define NSAssertMustOverridden  NSAssert(NO, @"The method \"%@\" in \"%@\" must be overridden.",NSStringFromSelector(_cmd),NSStringFromClass(self.class))
/** 是否为iPad */
static inline BOOL const kDDisiPad() {
    static dispatch_once_t one;
    static BOOL pad;
    dispatch_once(&one, ^{
        pad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
    });
    return pad;
}
/** 是否为iPad */
#define DDisiPad kDDisiPad()
/** 禁止神策LBS采集 */
#define SENSORS_ANALYTICS_DISABLE_TRACK_GPS
/** 当前版本数字 */
#define kAppReleaseVersionBuilderNumber [kAppReleaseVersionBuilder replaceString:@"." withString:@""].intValue
/**
 获取文字 v2.2.5
 @param format 格式
 @param ... 文本列表
 @return NSString
 */
static inline NSString *const DDStringFormat(NSString *format,...) {
    @try {
        va_list args;
        va_start(args, format);
        NSString *str = [[NSString alloc] initWithFormat:format arguments:args];
        va_end(args);
        return str;
    } @catch(NSException *e) {
    }
    return nil;
}

/**
 全局异步线程
 @param block 回调
 */
static inline void dispatch_async_global_queue_default(void (^block)(void)) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        block();
    });
}

/// 设计的宽度尺寸
#define kDDUIDesignScreenWidth DDUIDesignScreenWidth()
static inline CGFloat DDUIDesignScreenWidth() {
    static CGFloat width;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       width = DDisiPad?768:375;
    });
    return width;
}

#pragma mark - ......::::::: 屏幕size计算 :::::::......
#define kDDScreenPortraitWidth DDScreenPortraitSize().width
#define kDDScreenPortraitHeight DDScreenPortraitSize().height
/// 获取已竖屏计算的屏幕Size
static inline CGSize DDScreenPortraitSize() {
    static CGSize size;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size = [UIScreen mainScreen].bounds.size;
        if (size.height < size.width) {
            CGFloat tmp = size.height;
            size.height = size.width;
            size.width = tmp;
        }
    });
    return size;
}

#define kDDScreenLandScapeWidth DDScreenLandScapeSize().width
#define kDDScreenLandScapeHeight DDScreenLandScapeSize().height
/// 获取已横屏计算的屏幕Size
static inline CGSize DDScreenLandScapeSize() {
    static CGSize size;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size = [UIScreen mainScreen].bounds.size;
        if (size.width < size.height) {
            CGFloat tmp = size.width;
            size.width = size.height;
            size.height = tmp;
        }
    });
    return size;
}

#ifdef __cplusplus
}
#endif

#endif /* DDGlobalDefines_h */
