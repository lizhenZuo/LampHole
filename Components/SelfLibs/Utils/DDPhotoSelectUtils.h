//
//  DDPhotoSelectUtils.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/22.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DDPhotoSelectBlock)(NSArray<NSURL *> * _Nonnull imageURLArray);

NS_ASSUME_NONNULL_BEGIN

@interface DDPhotoSelectUtils : NSObject

+ (instancetype)photoSelectFromVc:(UIViewController *)vc;

/**
 获取单张照片
 
 @param selectedCompleteBlock 回调block
 */
-(void)showSingleImagePick:(DDPhotoSelectBlock)selectedCompleteBlock;

/**
 获取用户指定个数照片（拍照只有一个）
 
 @param maxPhotoNum 选取图片个数
 @param selectedCompleteBlock 回调block
 */
-(void)showMutilImagePick:(int)maxPhotoNum selectedComplete:(DDPhotoSelectBlock)selectedCompleteBlock;


@end

NS_ASSUME_NONNULL_END
