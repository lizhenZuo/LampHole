//
//  UIView+Round.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/6.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Round)

@property (nonatomic,assign,readonly) BOOL isRound;

-(void)roundCorner:(UIRectCorner)corner radio:(CGFloat)radio;

@end
