//
//  UILabel+ChangeSpace.h
//  AiTeacheriPhone
//
//  Created by dingdong on 2019/2/25.
//  Copyright © 2019年 ddkt365. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ChangeSpace)

/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

@end
