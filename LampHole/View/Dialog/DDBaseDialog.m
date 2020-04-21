//
//  DDBaseDialog.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/22.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "DDBaseDialog.h"
#import "DDAppWindow.h"

@interface DDBaseDialog()

@end

@implementation DDBaseDialog

/**
 加载Nib视图
 @return DDBaseDialog
 */
+(instancetype)loadFromSelfNibName{
    return [[[NSBundle mainBundle] loadNibNamed:[self.class nibName] owner:nil options:nil] firstObject];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initDiloag];
    }
    return self;
}


-(void)awakeFromNib{
    [super awakeFromNib];
    [self initDiloag];
}

-(void)dealloc{
    NSLog(@"DDBaseDialog -> %@ dealloc()",self.className);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)initDiloag{
    self.dialogLevel = DDDialogLevelNormal;
    [self addNotifications];
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7f]];
}

-(void)addNotifications{
    //弹窗优先级
    [[DDNotificationManager shareInstance] addDialogPriorityHigh:self selector:@selector(handleDialogPriorityHigh:)];
    //token失效
    [[DDNotificationManager shareInstance] addTokenInvalid:self selector:@selector(handleTokeInvalid)];
    //隐藏对话框
    [DDNotificationManager addObserver:self selector:@selector(handleDismissAllDialogNotification:) name:@"dismissAllDialog" object:nil];
}


-(void)handleDialogPriorityHigh:(NSNotification *)notification{
    id object = notification.object;
    if (self != object) {
        [self dismissNoAnimation];
    }
}

-(void)handleTokeInvalid{
    [DDProgressHUD dismissWindowLoading];
    [self dismissNoAnimation];
}

/**
 弹窗消失广播接受处理（子类实现之后可以处理）
 @param notification 广播
 */
-(void)handleDismissAllDialogNotification:(NSNotification *)notification{
    NSLog(@"handleDismissAllDialogNotification");
    [self dismissNoAnimation];
}

/**
 弹窗显示
 @param dialogView 动画视图
 */
-(void)showAnimation:(UIView *)dialogView{
    _isShow = YES;
    @weakify(self);
    @weakify(dialogView);
    dispatch_sync_on_main_queue(^{
        @strongify(self);
        @strongify(dialogView);
        self.alpha = 0.0;
        [self showNoAnimation];
        CGFloat top = dialogView.top;
        dialogView.top = kDDScreenHeight;
        @weakify(self);
        [UIView animateWithDuration:kDDAnimationDurationShort
                         animations:^{
                             @strongify(self);
                             dialogView.top = top;
                             self.alpha = 1;
                         } completion:nil];
        [self layoutIfNeeded];
    });
}

- (void)showRightToLeftAnimation:(UIView *)dialogView{
    _isShow = YES;
    @weakify(self);
    @weakify(dialogView);
    dispatch_sync_on_main_queue(^{
        @strongify(self);
        @strongify(dialogView);
        self.alpha = 0.0;
        [self showNoAnimation];
        CGFloat left = dialogView.left;
        dialogView.left = kDDScreenWidth;
        @weakify(self);
        [UIView animateWithDuration:kDDAnimationDurationLong
                         animations:^{
                             @strongify(self);
                             dialogView.left = left;
                             self.alpha = 1;
                         } completion:nil];
        [self layoutIfNeeded];
    });
}

- (void)dismissLeftToRightAnimation:(UIView *)dialogView{
    _isShow = NO;
    @weakify(dialogView);
    @weakify(self);
    dispatch_sync_on_main_queue(^{
        @strongify(self);
        @weakify(self);
        [UIView animateWithDuration:kDDAnimationDurationLong
                         animations:^{
                             @strongify(dialogView);
                             @strongify(self);
                             dialogView.left = kDDScreenWidth;
                             self.alpha = 0;
                         } completion:^(BOOL finished) {
                             @strongify(self);
                             if (finished) {
                                 [self removeFromSuperview];
                             }
                         }];
        [self layoutIfNeeded];
    });
}

/**
 弹窗消失
 @param dialogView 动画视图
 */
-(void)dismissAnimation:(UIView *)dialogView{
    _isShow = NO;
    @weakify(dialogView);
    @weakify(self);
    dispatch_sync_on_main_queue(^{
        @strongify(self);
        @weakify(self);
        [UIView animateWithDuration:kDDAnimationDurationShort
                         animations:^{
                             @strongify(dialogView);
                             @strongify(self);
                             dialogView.top = kDDScreenHeight;
                             self.alpha = 0;
                         } completion:^(BOOL finished) {
                             @strongify(self);
                             if (finished) {
                                 [self removeFromSuperview];
                             }
                         }];
        [self layoutIfNeeded];
    });
}

/** 弹窗显示 */
-(void)showNoAnimation{
    _isShow = YES;
    @weakify(self);
    dispatch_sync_on_main_queue(^{
        @strongify(self);
        [self addToDialogWindow];
    });
}

/** 弹窗消失 */
-(void)dismissNoAnimation{
    _isShow = NO;
    @weakify(self);
    dispatch_sync_on_main_queue(^{
        @strongify(self);
        [self removeFromSuperview];
    });
}

/** 添加视图到 dialog window上面 */
-(void)addToDialogWindow{
    [self.dialogWindow addDialog:self];
    self.frame = CGRectMake(0, 0, kDDScreenWidth, kDDScreenHeight);
    @weakify(self);
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self.dialogWindow);
    }];
}

/**
 获取dialogWindow（无window 则创建）
 @return UIWindow
 */
-(DDAppWindow *)dialogWindow{
    return [DDAppWindow shareAppWindow];
}

@end
