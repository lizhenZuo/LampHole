//
//  DDOKCancelDialog.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/5.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DDOKCancelDialogBlock)(void);

@interface DDOKCancelDialog : DDBaseDialog

/**
 初始化alertView 双按钮

 @param title 标题
 @param subTitle 副标题
 @param cancelTitle 取消按钮文本
 @param confirmTitle 确认按钮文本
 @return 当前对象
 */
+(instancetype)alertWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                 leftlTitle:(NSString *)cancelTitle
                rightlTitle:(NSString *)confirmTitle;

/**
 初始化alertView

 @param title 标题
 @param subTitle 副标题
 @param cancelTitle 取消按钮文本
 @param confirmTitle 确认按钮文本
 @param titleImageName tips图片名称
 @return 当前对象
 */
+(instancetype)alertWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                  leftlTitle:(NSString *)cancelTitle
                 rightlTitle:(NSString *)confirmTitle
               titleImageName:(NSString *)titleImageName;


/**
 初始化alertView
 
 @param title 标题
 @param subTitle 副标题
 @param cancelTitle 取消按钮文本
 @param confirmTitle 确认按钮文本
 @param dialogIconName dialog顶部图片
 @return 当前对象
 */
+(instancetype)alertWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                   leftlTitle:(NSString *)cancelTitle
                  rightlTitle:(NSString *)confirmTitle
                   dialogIcon:(NSString *)dialogIconName
                 isCanClickBg:(BOOL)isCanClickBg;

/**
 显示双按钮对话框

 @param rightBlock 确认回调
 @param leftBlock 取消回调
 */
-(void)showDialog:(DDOKCancelDialogBlock)rightBlock
        leftBlock:(DDOKCancelDialogBlock)leftBlock;


/**
 隐藏
 */
-(void)dismissDialog;
@end
