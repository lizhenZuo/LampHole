//
//  DDNavigationBarView.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/8/28.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDNavigationBarView : UIView

+(instancetype)navigationBarView:(NSString *)title;

//初始化（特定条件下使用，目前只有设备检测页用到）
+(instancetype)navigationBarView:(NSString *)title
                      titleColor:(UIColor *)titleColor
                       backImage:(UIImage * _Nullable)backImage;

/**
 添加返回按钮事件
 */
-(void)addBackSender:(DDNoParamsBlock)completeBlock;

/**
 添加右边按钮事件（特定条件下使用,目前只有设备检测页用到）
 */
- (void)addRightSender:(DDNoParamsBlock)completeBlock;

/**
 添加title按钮事件
 */
-(void)addTitleSender:(DDNoParamsBlock)titleBlock;

/**
 更新title
 */
-(void)updateTitle:(NSString *)title;

/**
 更新右边按钮状态
 */
-(void)updateRightBtnStatus:(BOOL)isShow;

/**
 更新标题宽度(默认为300)

 @param width 宽度
 */
-(void)updateNaviTitleToPortrait:(CGFloat)width;

/**
 更新title右侧的图标，显示
 */
-(void)showTitleRightImage:(UIImage *)image;

/**
 更新title透明度
 @param alpha 值
 */
-(void)updateTitleAlpha:(CGFloat)alpha;

/**
 添加右侧按钮

 @param title 按钮标题
 @param handleBlock 按钮点击回调
 */
-(UIButton *)addRightButton:(NSString *)title handle:(DDNoParamsBlock)handleBlock;

/**
 设置返回按钮的图片
 @param imageName 返回按键图片名称
 */
-(void)setBackImageName:(NSString *)imageName;

@end
NS_ASSUME_NONNULL_END
