//
//  DDToaster.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/8/29.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "DDToaster.h"

static inline CGFloat kToasterTimeSecond(ShowToasterType toastLeght){
    switch (toastLeght) {
        case ShowToastLength_Normal:{
            return 1.0;
        }
        case ShowToastLength_Long:{
            return 2.0;
        }
        default:
            break;
    }
}

/**
 *  显示时间
 */
static ShowToasterType const kShowToastLength = ShowToastLength_Long;

@implementation DDToaster

/**
 显示文本toast
 
 @param text 文本
 */
+ (void)showWindowToastWithText:(NSString *)text{
    [self.class showWindowToastWithText:text completionBlock:nil];
}


/**
 显示文本toast
 
 @param text 文本
 @param completionBlock 结束block
 */
+ (void)showWindowToastWithText:(NSString *)text
                completionBlock:(DDTosterBlock)completionBlock{
    [self.class showWindowToastWithText:text toasterType:kShowToastLength completionBlock:completionBlock];
}

/**
 显示文本toast
 
 @param text 文本
 @param toasterType 显示时长
 */
+ (void)showWindowToastWithText:(NSString *)text
                toasterType:(ShowToasterType)toasterType{
    [self.class showWindowToastWithText:text toasterType:toasterType completionBlock:nil];
}

/**
 显示文本toast
 
 @param text 文本
 @param toasterType 显示时长
 @param completionBlock 结束block
 */
+ (void)showWindowToastWithText:(NSString *)text
                toasterType:(ShowToasterType)toasterType
                completionBlock:(DDTosterBlock)completionBlock{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [self.class lastWindow];
        MBProgressHUD *mHud = [[MBProgressHUD alloc] initWithWindow:window];
        [window addSubview:mHud];
        mHud.detailsLabelText = text;
        mHud.animationType = MBProgressHUDAnimationFade;
        if(DDisiPad){
            mHud.detailsLabelFont = [UIFont systemFontOfSize:21.f];
            [mHud setMinSize:CGSizeMake(350, 80)];
        }else{
            mHud.detailsLabelFont = [UIFont systemFontOfSize:14.f];
            [mHud setMinSize:CGSizeMake(220, 50)];
        }
        mHud.userInteractionEnabled = NO;
        mHud.mode = MBProgressHUDModeText;
        [mHud showAnimated:YES whileExecutingBlock:^{
            CGFloat len = kToasterTimeSecond(toasterType);
            sleep(len);
        } completionBlock:^{
            if (completionBlock){
                completionBlock();
            }
            [mHud removeFromSuperview];
        }];
    });
}

/**
 获取最上层window
 */
+ (UIWindow *)lastWindow {
    NSArray<UIWindow *> *winArray = [UIApplication sharedApplication].windows;
    NSEnumerator<UIWindow *> *enumerator = winArray.reverseObjectEnumerator;
    for(UIWindow *window in enumerator) {
        if (![window isKindOfClass:[UIWindow class]] || [window.className isEqualToString:@"UIRemoteKeyboardWindow"] || window.hidden) {
            continue;
        }else{
            BOOL isValidFrame = CGSizeEqualToSize(window.bounds.size, DDScreenPortraitSize()) || CGSizeEqualToSize(window.bounds.size, DDScreenLandScapeSize());
            if ( isValidFrame) return window;
        }
    }
    return [UIApplication sharedApplication].keyWindow;
}


@end
