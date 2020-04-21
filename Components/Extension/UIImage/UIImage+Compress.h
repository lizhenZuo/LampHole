//
//  UIImage+Compress.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/22.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Compress)

//调整方位
- (UIImage *)fixOrientations;

/**  默认最大为500kb压缩 */
- (NSData *)imageDataCompress;

/**
 压缩至最接近的最大值
 @param maxLength 最大值
 */
- (NSData *)compressImageQualityToByte:(NSInteger)maxLength;

/** 重新绘制图片 */
- (UIImage *)drawContextImage;


@end

NS_ASSUME_NONNULL_END
