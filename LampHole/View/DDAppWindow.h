//
//  DDDialogWindow.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2019/2/26.
//  Copyright © 2019 ddkt365. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DDAppWindow : UIWindow

+(instancetype)shareAppWindow;

/**
 添加弹窗
 @param dialog DDBaseDialog
 */
-(void)addDialog:(DDBaseDialog *)dialog;

@end
