//
//  UITabBar+DDAddition.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2019/10/19.
//  Copyright © 2019 ddkt365. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (DDAddition)

/// 显示小红点
/// @param index vc索引
- (void)showBadgeOnItemIndex:(NSInteger)index;


/// 隐藏小红点
/// @param index vc索引
- (void)hideBadgeOnItemIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
