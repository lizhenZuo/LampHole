////
////  UIViewController+Rotate.h
////  AiTeacheriPhone
////
////  Created by eason yin on 2019/10/25.
////  Copyright © 2019 ddkt365. All rights reserved.
////
//
//#import <UIKit/UIKit.h>
//
///**
// 设备旋转支持的方向，为了更好的进行位运算，所以未采用系统设备方向枚举
// - DDDeviceRotateOrientationPortrait: 竖屏
// - DDDeviceRotateOrientationLandscapeLeft: 横屏，home键在右侧
// - DDDeviceRotateOrientationLandscapeRight: 横屏，home键做左侧
// - DDDeviceRotateOrientationLandscape: 横屏，包括DDDeviceRotateOrientationLandscapeLeft和DDDeviceRotateOrientationLandscapeRight
// - DDDeviceRotateOrientationPortraitUpsideDown: 倒立竖屏
// - DDDeviceRotateOrientationAll: 所有状态，两种横屏和两种竖屏的状态
// - DDDeviceRotateOrientationAllButUpsideDown: 除了倒立竖屏的其他所有方向
// */
//typedef NS_ENUM(NSUInteger, DDDeviceRotateOrientation) {
//    DDDeviceRotateOrientationPortrait             = (1 << 0),
//    DDDeviceRotateOrientationLandscapeLeft        = (1 << 1),
//    DDDeviceRotateOrientationLandscapeRight       = (1 << 2),
//    DDDeviceRotateOrientationLandscape            = (1 << 3),
//    DDDeviceRotateOrientationPortraitUpsideDown   = (1 << 4),
//    DDDeviceRotateOrientationAll                  = (1 << 5),
//    DDDeviceRotateOrientationAllButUpsideDown     = (1 << 6),
//};
//
//@interface UIViewController (Rotate)
//
///** 支持的方向，只有一个方向时即为强转。当有多个参数时，将以 竖屏-左转-右转-倒立竖屏 顺序来优先强转第一个方向*/
//@property (assign, nonatomic) DDDeviceRotateOrientation ddSupportOrientations;
//
//@end
//
//
//@interface UINavigationController (Rotate)
//
//@end
//
//@interface UITabBarController (Rotate)
//
//@end
