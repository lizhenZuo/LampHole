//
//  DDPhotoBrowserManager.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/22.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//多张
typedef void(^DDPhotoBrowserMutil)(NSArray<NSURL *> *imageURLArray);
//单张
typedef void(^DDPhotoBrowserSingle)(NSURL *imageURL);

@interface DDPhotoBrowserManager : NSObject


+ (instancetype)manager:(UIViewController *)vc;

/**
 拍照
 
 @param block 回调Block
 @return bool
 */
- (BOOL)takeCamera:(DDPhotoBrowserSingle)block;

/**
 第三方多选
 
 @param maxNum 最大图片数
 @param block 回调Block
 @return bool
 */
- (BOOL)takePhotoLibraryWithMaxNum:(int)maxNum
                             block:(DDPhotoBrowserMutil)block;

/**
 选取相册单张
 
 @param block 回调Block
 @return bool
 */
- (BOOL)takePhotoLibrary:(DDPhotoBrowserSingle)block;


@end

NS_ASSUME_NONNULL_END

