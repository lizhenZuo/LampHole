//
//  OurUIPageControl.h
//  MenuKingHD
//
//  Created by Liu Jian on 12-11-1.
//  Copyright (c) 2012年 carrybean.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    OurUIPageControlInitType_None = 0,
    OurUIPageControlInitType_Image,
    OurUIPageControlInitType_Color
}OurUIPageControlInitType;

@interface OurUIPageControl : UIPageControl
{
    OurUIPageControlInitType _initType;
    
    UIImage *_activeImage;
    UIImage *_inactiveImage;
    
    UIColor *_activeColor;
    UIColor *_inactiveColor;
}

- (id)initWithFrame:(CGRect)frame activeImage:(UIImage *)activeImage inactiveImage:(UIImage *)inactiveImage;
- (id)initWithFrame:(CGRect)frame activeColor:(UIColor *)activeColor inactiveColor:(UIColor *)inactiveColor;

@end
