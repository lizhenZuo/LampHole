//
//  UIButton+DDEnlargeEdge.m
//  AiTeacheriPhone
//
//  Created by coderqh on 2019/3/16.
//  Copyright © 2019 ddkt365. All rights reserved.
//

#import "UIButton+DDEnlargeEdge.h"
#import <objc/runtime.h>

@implementation UIButton (DDEnlargeEdge)

- (void)addExtensionInset:(UIEdgeInsets)inset{
    objc_setAssociatedObject(self, _cmd, [NSValue valueWithUIEdgeInsets:inset], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    UIEdgeInsets insert = [objc_getAssociatedObject(self, @selector(addExtensionInset:)) UIEdgeInsetsValue];
    
    CGRect newFrame = CGRectMake(self.bounds.origin.x+insert.left, self.bounds.origin.y+insert.top, self.bounds.size.width-insert.left-insert.right, self.bounds.size.height-insert.top-insert.bottom);
    return CGRectContainsPoint(newFrame, point);
}



@end
