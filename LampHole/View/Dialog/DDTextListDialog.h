//
//  DDTextListDialog.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/5.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DDTextListDialogBlock)(NSString *str,NSInteger idx);

@interface DDTextListDialog : DDBaseDialog


+(instancetype)shareView:(NSArray<NSString *> *)list;

/**
 显示单按钮对话框
 @param block 确认回调
 */
-(void)showDialog:(DDTextListDialogBlock)block;

/**
 隐藏
 */
-(void)dismissDialog;
@end
