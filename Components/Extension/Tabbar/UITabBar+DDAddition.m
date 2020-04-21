//
//  UITabBar+DDAddition.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2019/10/19.
//  Copyright © 2019 ddkt365. All rights reserved.
//

#import "UITabBar+DDAddition.h"

static CGFloat const kDDBadgeViewTag = 200; // 红点起始tag值
static CGFloat const kDDBadgeWidthiPhone = 7; // 红点宽高
static CGFloat const kDDBadgeWidthiPad = 10; // 红点宽高

@implementation UITabBar (DDAddition)

//显示小红点
- (void)showBadgeOnItemIndex:(NSInteger)index{
    [self removeBadgeOnItemIndex:index];
    
    CGFloat redWidth = DDisiPad?kDDBadgeWidthiPad:kDDBadgeWidthiPhone;
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = kDDBadgeViewTag + index;
    badgeView.layer.cornerRadius = redWidth / 2;
    badgeView.backgroundColor = DDColorHex(@"#FF6E50");
    [self addSubview:badgeView];
     // 设置小红点的位置
     int i = 0;
     for (UIView* subView in self.subviews){
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]){
             // 找到需要加小红点的view，根据frame设置小红点的位置
            if (i == index) {
                CGFloat xPoint = 0;
                CGFloat yPoint = 0;
                if(DDisiPad){
                    //iPad
                    yPoint = 6;
                    if (@available(iOS 11.0, *)) {
                        xPoint = subView.frame.origin.x + subView.frame.size.width/2 - 10;
                    }else{
                        xPoint = subView.frame.origin.x + subView.frame.size.width/2 + 10;
                    }
                }else{
                    //iPhone
                    yPoint = 3;
                    xPoint = subView.frame.origin.x + subView.frame.size.width/2 + 10;
                }
                //异常判断
                if (yPoint!=0 && xPoint!=0) {
                    badgeView.frame = CGRectMake(xPoint, yPoint, redWidth, redWidth);
                }else{
                    [badgeView removeFromSuperview];
                }
                break;
            }
            i++;
        }
    }
}

// 隐藏小红点
- (void)hideBadgeOnItemIndex:(NSInteger)index{
    [self removeBadgeOnItemIndex:index];
}

// 移除小红点
- (void)removeBadgeOnItemIndex:(NSInteger)index{
// 根据tag的值移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == kDDBadgeViewTag + index) {
            [subView removeFromSuperview];
        }
    }
}

@end
