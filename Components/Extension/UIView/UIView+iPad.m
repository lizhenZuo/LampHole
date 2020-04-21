//
//  UIView+iPad.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/10/23.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "UIView+iPad.h"

@implementation UIView (iPad)

+(NSString *)nibName{
    if (DDisiPad) {
        NSString *nibName = [NSString stringWithFormat:@"%@_iPad",self.className];
        NSString *nibPath = [[NSBundle mainBundle] pathForResource:nibName ofType:@"nib"];
        if (nibPath && nibPath.length>0) {
            return nibName;
        }
    }
    return self.className;
}

+(instancetype)nibView{
    return [[[NSBundle mainBundle] loadNibNamed:[self.class nibName] owner:nil options:nil] firstObject];
}

@end
