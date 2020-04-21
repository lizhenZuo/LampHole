//
//  UIViewController+DDAddition.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2019/10/24.
//  Copyright © 2019 ddkt365. All rights reserved.
//

#import "UIViewController+DDAddition.h"
#import "DDBaseNavigationController.h"

@implementation UIViewController (DDAddition)

+(void)load{
    [super load];
    //dismiss
    method_exchangeImplementations(
                                   class_getInstanceMethod(self.class,NSSelectorFromString(@"dismissViewControllerAnimated:completion:")),
                                   class_getInstanceMethod(self.class,@selector(dd_dismissViewControllerAnimated:completion:))
                                   );
    //present
    method_exchangeImplementations(
                                   class_getInstanceMethod(self.class,NSSelectorFromString(@"presentViewController:animated:completion:")),
                                   class_getInstanceMethod(self.class,@selector(dd_presentViewController:animated:completion:))
                                   );
    
    //push
    method_exchangeImplementations(
                                   class_getInstanceMethod(self.class,NSSelectorFromString(@"pushViewController:animated:")),
                                   class_getInstanceMethod(self.class,@selector(dd_pushViewController:animated:))
                                   );
    //pop
    method_exchangeImplementations(
                                   class_getInstanceMethod(self.class,NSSelectorFromString(@"popViewControllerAnimated:")),
                                   class_getInstanceMethod(self.class,@selector(dd_popViewControllerAnimated:))
                                   );
    //dealloc
    method_exchangeImplementations(
                                   class_getInstanceMethod(self.class,NSSelectorFromString(@"dealloc")),
                                   class_getInstanceMethod(self.class,@selector(dd_dealloc))
                                   );
}

#pragma mark - ......::::::: Runtime->dealloc :::::::......
-(void)dd_dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    NSLog(@"vc:%@ -> dealloc()",self.className);
    [self dd_dealloc];
}

#pragma mark - ......::::::: Runtime->变量 是否隐藏navigationBar :::::::......
- (void)setDd_isHiddenNaviBar:(BOOL)dd_isHiddenNaviBar{
    NSNumber *number = [NSNumber numberWithBool:dd_isHiddenNaviBar];
    objc_setAssociatedObject(self, @selector(dd_isHiddenNaviBar), number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)dd_isHiddenNaviBar{
    NSNumber *number = objc_getAssociatedObject(self, @selector(dd_isHiddenNaviBar));
    return number.boolValue;
}

#pragma mark - ......::::::: Runtime->变量 是否为竖屏 :::::::......
- (void)setDd_isPortrait:(BOOL)portrait{
    NSNumber *number = [NSNumber numberWithBool:portrait];
    objc_setAssociatedObject(self, @selector(dd_isPortrait), number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)dd_isPortrait{
    NSNumber *number = objc_getAssociatedObject(self, @selector(dd_isPortrait));
    return number.boolValue;
}

#pragma mark - ......::::::: Runtime->设置设备方向 :::::::......
-(NSString *)selSetOrientation{
    NSString *s = [@"s e t - O -r i -e n t a -t i o n -:" replaceString:@" " withString:@""];
    NSString *ss = [s replaceString:@"-" withString:@""];
    return ss;
}

/// 设置是否显示导航栏
/// @param isHidden YES NO
-(void)dd_setHiddenNavigationBar:(BOOL)isHidden{
    self.dd_isHiddenNaviBar = isHidden;
    if ([self isKindOfClass:UINavigationController.class]) {
        UINavigationController *naviSelf = (UINavigationController *)self;
        [naviSelf setNavigationBarHidden:isHidden animated:YES];
    }else{
        [self.navigationController setNavigationBarHidden:isHidden animated:YES];
    }
}

#pragma mark - ......::::::: Runtime->vc退出页面 :::::::......
/// 页面模态弹出
/// @param viewControllerToPresent UIViewController
/// @param flag animated
/// @param completion 回调
-(void)dd_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    //解决CRM调用系统相册的问题
    [self dd_presentViewController:viewControllerToPresent animated:flag completion:completion];
}

/**
 消失VC
 @param flag YES
 @param completion 回调
 */
-(void)dd_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [self dd_dismissViewControllerAnimated:flag completion:^{
        if (completion) {
            completion();
        }
    }];
}

#pragma mark - ......::::::: Runtime->退出页面 :::::::......
/**
 退出页面
 @param animated 动画
 */
-(void)dd_popViewControllerAnimated:(BOOL)animated{
    [self dd_popViewControllerAnimated:animated completion:^{
    }];
}

/**
 退出页面
 @param animated 动画
 @param completionBlk 完成回调
 */
-(void)dd_popViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completionBlk{
    UINavigationController *navi = self.navigationController;
    if (navi && navi.viewControllers.count>1) {
        [navi popViewControllerAnimated:animated];
        if (completionBlk) completionBlk();
    }else{
        [self dismissViewControllerAnimated:animated completion:^{
            if (completionBlk) completionBlk();
        }];
    }
}

/**
 集合内是否包含当前视图为横屏，上一视图为竖屏
 @param vc UIViewController
 @return YES NO
 */
-(BOOL)isPresentLandScapeContains:(UIViewController *)vc{
    //是否包含为竖屏
    BOOL isLandScape = vc.presentingViewController && !vc.presentingViewController.dd_isPortrait;
    return isLandScape;
}

#pragma mark - ......::::::: Runtime->进入新页面 :::::::......
/**
 进入新页面
 @param viewController 新页面
 @param animated 动画
 */
-(BOOL)dd_pushViewController:(UIViewController *_Nonnull)viewController animated:(BOOL)animated{
    return [self dd_pushViewController:viewController animated:animated completion:^{
    }];
}

/**
 进入新页面
 @param viewController 新页面
 @param animated 动画
 @param completionBlk 回到
 @return YES代表竖屏进入 NO代表非竖屏进入
 */
-(BOOL)dd_pushViewController:(UIViewController *_Nonnull)viewController animated:(BOOL)animated completion:(void (^)(void))completionBlk{
    //当即将进入的页面为横屏，此时当前VC或者当前视图为竖屏时（处理横竖屏切换）
    BOOL isSameOreintation = (viewController.dd_isPortrait == self.dd_isPortrait);
    if(![self isKindOfClass:UINavigationController.class] && [viewController isKindOfClass:UINavigationController.class]){
        isSameOreintation = (self.navigationController.dd_isPortrait == viewController.dd_isPortrait);
    }else{
        isSameOreintation = (viewController.dd_isPortrait == self.dd_isPortrait);
    }
    //如果为不同方向，采用present方式（旋转方向）
    if (!isSameOreintation) {
        UINavigationController *navi = nil;
        if ([viewController isKindOfClass:UINavigationController.class]) {
            navi = (UINavigationController *)viewController;
        }else{
            navi = [[DDBaseNavigationController alloc] initWithRootViewController:viewController];
        }
        //横竖屏（navi需要）
        navi.dd_isPortrait=viewController.dd_isPortrait;
        
        //present
        [self presentViewController:navi animated:animated completion:^{
            if (completionBlk) {
                completionBlk();
            }
        }];
    }else{
        //push
        DDBaseNavigationController *curNavi = (DDBaseNavigationController *)self.navigationController;
        NSArray *array = curNavi.viewControllers;
        if (![viewController isKindOfClass:UINavigationController.class] && curNavi && array && array.count > 0) {
            [self.class dd_navigationPush:curNavi viewController:viewController animated:animated completion:completionBlk];
            return NO;
        }
        //present
        [self presentViewController:viewController animated:animated completion:^{
            if (completionBlk) {
                completionBlk();
            }
        }];
    }
    return YES;
}

/// 页面导航（类方法）
/// @param navi UINavigationController
/// @param viewController UIViewController
/// @param animated animated
/// @param completionBlk void (^)(void)
+(void)dd_navigationPush:(UINavigationController *)navi  viewController:(UIViewController *_Nonnull)viewController animated:(BOOL)animated completion:(void (^)(void))completionBlk{
    [navi pushViewController:viewController animated:animated];
    if (completionBlk) {
        completionBlk();
    }
}

@end
