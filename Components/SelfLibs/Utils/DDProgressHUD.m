//
//  DDProgressHUD.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/13.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "DDProgressHUD.h"

NSString *const kLoadingTips = @"加载中...";

@interface DDProgressHUD()

@end

@implementation DDProgressHUD

/**
 显示弹窗 (默认文本 加载中...)
 @param view 视图
 */
+(DDProgressHUD *)showLoading:(UIView *)view{
    return [self showLoading:kLoadingTips inView:view];
}


/**
 显示弹窗
 @param tips 内容
 @param view 视图
 */
+ (DDProgressHUD *)showLoading:(NSString *)tips inView:(UIView *)view{
    NSAssert(view, @"loading框的视图不能为空");
    @weakify(self);
    __block  DDProgressHUD *hud = nil;
    dispatch_sync_on_main_queue(^{
        @strongify(self);
        hud = [DDProgressHUD HUDForView:view];
        if (hud == nil) {
            hud = [[DDProgressHUD alloc] initWithView:view];
            [self initHUD:hud tips:tips];
            [view addSubview:hud];
        }
        [self showHUD:hud];
    });
    return hud;
}

/**
 设置hud样式
 @param hud 窗体
 @param tips 显示的文本
 */
+(void)initHUD:(DDProgressHUD *)hud tips:(NSString *)tips{
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = YES;
    hud.detailsLabelText = tips;
    if(DDisiPad){
        hud.detailsLabelFont = [UIFont systemFontOfSize:21.f];
        [hud setMinSize:CGSizeMake(180, 180)];
    }else{
        hud.detailsLabelFont = [UIFont boldSystemFontOfSize:15.0];
        [hud setMinSize:CGSizeMake(120, 120)];
    }
}

/**  显示 */
+(DDProgressHUD *)showHUD:(DDProgressHUD *)hud{
    if (hud) {
        [hud show:YES];
    }
    return hud;
}

/** 隐藏 */
+ (void)dismissLoading:(UIView *)view{
    dispatch_sync_on_main_queue(^{
        NSArray<DDProgressHUD *> *array = [DDProgressHUD allHUDsForView:view];
        if (array && array.count > 0) {
            for (DDProgressHUD *progressHUD in array) {
                [progressHUD hide:YES];
                [progressHUD removeFromSuperview];
            }
        }
     });
}

/**
 window显示loading (默认文本 加载中...)
 */
+(DDProgressHUD *)showWindowLoading{
    return [self showWindowLoading:kLoadingTips];
}

/**
 window显示loading
 @param tips loading文本
 */
+(DDProgressHUD *)showWindowLoading:(NSString *)tips{
    @weakify(self);
    __block DDProgressHUD *hud = nil;
    dispatch_sync_on_main_queue(^{
        @strongify(self);
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        hud = [DDProgressHUD HUDForView:window];
        if (hud == nil) {
            hud = [[DDProgressHUD alloc] initWithWindow:window];
            [self initHUD:hud tips:tips];
            [window addSubview:hud];
        }else{
            hud.detailsLabelText = tips;
        }
        if (![NSThread isMainThread]) {
            [self performSelectorOnMainThread:@selector(showHUD:)
                                 withObject:hud
                              waitUntilDone:YES];
        }else{
            [self showHUD:hud];
        }
    });
    return hud;
}

/**
 window消失loading
 */
+(void)dismissWindowLoading{
    @weakify(self);
    dispatch_sync_on_main_queue(^{
        @strongify(self);
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        [self dismissLoading:window];
    });
}

@end
