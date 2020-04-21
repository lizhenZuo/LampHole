//
//  UIButton+DDEnlargeEdge.h
//  AiTeacheriPhone
//
//  Created by coderqh on 2019/3/16.
//  Copyright © 2019 ddkt365. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (DDEnlargeEdge)

/**
 扩大按钮响应区域
 
 @param inset  top, left, bottom, right
 */
- (void)addExtensionInset:(UIEdgeInsets)inset;

@end

