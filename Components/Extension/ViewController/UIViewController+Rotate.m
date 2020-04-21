////
////  UIViewController+Rotate.m
////  AiTeacheriPhone
////
////  Created by eason yin on 2019/10/25.
////  Copyright © 2019 ddkt365. All rights reserved.
////
//#import "UIViewController+Rotate.h"
//#import <objc/runtime.h>
//
//const NSString *ExtensionKey_SupportOrientations = @"ExtensionKey_SupportOrientations";
//
//#pragma mark - ......::::::: UIViewController :::::::......
//@implementation UIViewController (Rotate)
//
//#pragma mark - ......::::::: Runtime :::::::......
//- (void)setDdSupportOrientations:(DDDeviceRotateOrientation)ddSupportOrientations{
//    objc_setAssociatedObject(self, &ExtensionKey_SupportOrientations, @(ddSupportOrientations), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    
//    /** 收集可支持的方向，在没有指定方向时，根据可支持的枚举值最小为进入页面时强转的方向*/
//    NSMutableArray *orientationsCollections = [NSMutableArray array];
//    
//    if ((ddSupportOrientations & DDDeviceRotateOrientationPortrait) == DDDeviceRotateOrientationPortrait ) {
//        [orientationsCollections addObject:@(UIInterfaceOrientationPortrait)];
//    }
//    if ((ddSupportOrientations & DDDeviceRotateOrientationLandscapeLeft) == DDDeviceRotateOrientationLandscapeLeft) {
//        [orientationsCollections addObject:@(UIInterfaceOrientationLandscapeLeft)];
//    }
//    if ((ddSupportOrientations & DDDeviceRotateOrientationLandscapeRight) == DDDeviceRotateOrientationLandscapeRight) {
//        [orientationsCollections addObject:@(UIInterfaceOrientationLandscapeRight)];
//    }
//    if ((ddSupportOrientations & DDDeviceRotateOrientationLandscape) == DDDeviceRotateOrientationLandscape) {
//        [orientationsCollections addObject:@(UIInterfaceOrientationLandscapeLeft)];
//        [orientationsCollections addObject:@(UIInterfaceOrientationLandscapeRight)];
//    }
//    if ((ddSupportOrientations & DDDeviceRotateOrientationPortraitUpsideDown) == DDDeviceRotateOrientationPortraitUpsideDown) {
//        [orientationsCollections addObject:@(UIInterfaceOrientationPortraitUpsideDown)];
//    }
//    if ((ddSupportOrientations & DDDeviceRotateOrientationAll) == DDDeviceRotateOrientationAll) {
//        [orientationsCollections addObject:@(UIInterfaceOrientationPortrait)];
//        [orientationsCollections addObject:@(UIInterfaceOrientationLandscapeLeft)];
//        [orientationsCollections addObject:@(UIInterfaceOrientationLandscapeRight)];
//        [orientationsCollections addObject:@(UIInterfaceOrientationPortraitUpsideDown)];
//    }
//    if ((ddSupportOrientations & DDDeviceRotateOrientationAllButUpsideDown)) {
//        [orientationsCollections addObject:@(UIInterfaceOrientationPortrait)];
//        [orientationsCollections addObject:@(UIInterfaceOrientationLandscapeLeft)];
//        [orientationsCollections addObject:@(UIInterfaceOrientationLandscapeRight)];
//    }
//    NSArray *orientationsArray = [orientationsCollections sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//        return [obj1 integerValue] > [obj2 integerValue];
//    }];
//    UIInterfaceOrientation forceOrientation = UIInterfaceOrientationPortrait;
//    if (![orientationsArray containsObject:@(forceOrientation)]) {
//        if (orientationsArray.count == 0) {
//            forceOrientation = UIInterfaceOrientationPortrait;
//        } else {
//            forceOrientation = [orientationsArray.firstObject integerValue];
//        }
//    }
//    
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:@selector(setOrientation:)]];
//    invocation.selector = NSSelectorFromString(self.selSetOrientation);
//    invocation.target = [UIDevice currentDevice];
//    UIInterfaceOrientation initOrientation = forceOrientation;
//    [invocation setArgument:&initOrientation atIndex:2];
//    [invocation invoke];
////    /** 下面两行代码是为了当前导航栏或底部栏旋转至设备方向*/
////    [UINavigationController attemptRotationToDeviceOrientation];
////    [UITabBarController attemptRotationToDeviceOrientation];
//}
//
//-(NSString *)selSetOrientation{
//    NSString *s = [@"s e t - O -r i -e n t a -t i o n -:" replaceString:@" " withString:@""];
//    NSString *ss = [s replaceString:@"-" withString:@""];
//    return ss;
//}
//
//- (DDDeviceRotateOrientation)ddSupportOrientations{
//    DDDeviceRotateOrientation orientations = [objc_getAssociatedObject(self, &ExtensionKey_SupportOrientations) integerValue];
//    return orientations > 0 ? orientations : DDDeviceRotateOrientationPortrait;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return [self getInterfaceMaskFromRotateOrientation:self.ddSupportOrientations];
//}
//
//- (BOOL)shouldAutorotate{
//    return YES;
//}
//
//#pragma mark - ......::::::: Private :::::::......
///** 根据设置的方向计算可支持的页面方向*/
//- (UIInterfaceOrientationMask)getInterfaceMaskFromRotateOrientation: (DDDeviceRotateOrientation)rotateation{
//    NSMutableArray *flags = [NSMutableArray array];
//    if ((rotateation & DDDeviceRotateOrientationPortrait) == DDDeviceRotateOrientationPortrait) {
//        [flags addObject:@(UIInterfaceOrientationMaskPortrait)];
//    }
//    if ((rotateation & DDDeviceRotateOrientationLandscapeLeft) == DDDeviceRotateOrientationLandscapeLeft) {
//        [flags addObject:@(UIInterfaceOrientationMaskLandscapeRight)];
//    }
//    if ((rotateation & DDDeviceRotateOrientationLandscapeRight) == DDDeviceRotateOrientationLandscapeRight) {
//        [flags addObject:@(UIInterfaceOrientationMaskLandscapeLeft)];
//    }
//    if ((rotateation & DDDeviceRotateOrientationPortraitUpsideDown) == DDDeviceRotateOrientationPortraitUpsideDown) {
//        [flags addObject:@(UIInterfaceOrientationMaskPortraitUpsideDown)];
//    }
//    if ((rotateation & DDDeviceRotateOrientationLandscape) == DDDeviceRotateOrientationLandscape) {
//        [flags addObject:@(UIInterfaceOrientationMaskLandscapeLeft)];
//        [flags addObject:@(UIInterfaceOrientationMaskLandscapeRight)];
//    }
//    if ((rotateation & DDDeviceRotateOrientationAll) == DDDeviceRotateOrientationAll) {
//        [flags addObject:@(UIInterfaceOrientationMaskPortrait)];
//        [flags addObject:@(UIInterfaceOrientationMaskLandscapeRight)];
//        [flags addObject:@(UIInterfaceOrientationMaskLandscapeLeft)];
//        [flags addObject:@(UIInterfaceOrientationMaskPortraitUpsideDown)];
//    }
//    if ((rotateation & DDDeviceRotateOrientationAllButUpsideDown) == DDDeviceRotateOrientationAllButUpsideDown) {
//        [flags addObject:@(UIInterfaceOrientationMaskPortrait)];
//        [flags addObject:@(UIInterfaceOrientationMaskLandscapeRight)];
//        [flags addObject:@(UIInterfaceOrientationMaskLandscapeLeft)];
//    }
//    /** 去重以及按照正常逻辑排序*/
//    NSArray *distinctArray = [[NSSet setWithArray:flags] allObjects];
//    NSArray *orderArray = [distinctArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//        return  [obj1 integerValue] > [obj2 integerValue];
//    }];
//    
//    NSInteger bitResult = 0;
//    for(int i = 0; i < orderArray.count; i++){
//        bitResult |=  [orderArray[i] integerValue];
//    }
//    return bitResult;
//}
//
//@end
//
//#pragma mark - ......::::::: UINavigationController :::::::......
//@implementation UINavigationController (Rotate)
//
//- (BOOL)shouldAutorotate{
//    return self.visibleViewController.shouldAutorotate;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return self.visibleViewController.supportedInterfaceOrientations;
//}
//
//@end
//
//#pragma mark - ......::::::: UITabBarController :::::::......
//@implementation UITabBarController (Rotate)
//
//- (BOOL)shouldAutorotate{
//    if ([self.selectedViewController isKindOfClass:[UINavigationController class]]) {
//        return ((UINavigationController *)self.selectedViewController).visibleViewController.shouldAutorotate;
//    }
//    return self.selectedViewController.shouldAutorotate;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    if ([self.selectedViewController isKindOfClass:[UINavigationController class]]) {
//        return ((UINavigationController *)self.selectedViewController).visibleViewController.supportedInterfaceOrientations;
//    }
//    return self.selectedViewController.supportedInterfaceOrientations;
//}
//
//@end
////