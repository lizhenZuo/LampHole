//
//  DDBaseDialog.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/22.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/** 弹窗层级控制 */
typedef NS_ENUM(NSInteger,DDDialogLevel){
    DDDialogLevelBackground = -1,//最后面显示
    DDDialogLevelNormal = 0, //普通级别
    DDDialogLevelHigh = 1, //高级别
    DDDialogLevelForefront = 100, //最前端显示
};

@interface DDBaseDialog : UIView

//是否已展示
@property (nonatomic,assign,readonly)BOOL isShow;
//dialog等级,中途修改level是不能将窗口前置
@property (nonatomic,assign)DDDialogLevel dialogLevel;
//是否清空其他dialog
@property (nonatomic,assign)BOOL cleanOtherDialogs;

-(instancetype)init NS_UNAVAILABLE;

-(instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

/**
 加载Nib视图
 @return DDBaseDialog
 */
+(instancetype)loadFromSelfNibName;
/**
 弹窗显示
 @param dialogView 动画视图
 */
-(void)showAnimation:(UIView *)dialogView;

/**
 弹窗显示，从右到左动画
 */
- (void)showRightToLeftAnimation:(UIView *)dialogView;

/**
 弹窗消失，从左到右动画
 */
- (void)dismissLeftToRightAnimation:(UIView *)dialogView;

/**
 弹窗消失
 @param dialogView 动画视图
 */
-(void)dismissAnimation:(UIView *)dialogView;

/** 弹窗显示 */
-(void)showNoAnimation;

/** 弹窗消失 */
-(void)dismissNoAnimation;

/**
 弹窗消失广播接受处理（子类实现之后可以处理）
 @param notification 广播
 */
-(void)handleDismissAllDialogNotification:(NSNotification *)notification;

@end

NS_ASSUME_NONNULL_END
