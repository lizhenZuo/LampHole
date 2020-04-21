//
//  DDBaseCollectionViewCell.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2019/10/17.
//  Copyright © 2019 ddkt365. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DDBaseCollectionViewCellClassDelegate <NSObject>

/// 注册
/// @param collectionView UICollectionView
+ (void)registerNibForCollectionView:(UICollectionView *)collectionView;

/// 从缓存中获取
/// @param collectionView UICollectionView
/// @param indexPath forIndexPath
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

/// 获取cell的计算size
/// @param model NSObject
+(CGSize)cellSize:(id)model;

@end

@interface DDBaseCollectionViewCell : UICollectionViewCell<DDBaseCollectionViewCellClassDelegate>



@end

NS_ASSUME_NONNULL_END
