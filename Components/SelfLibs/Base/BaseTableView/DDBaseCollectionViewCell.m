//
//  DDBaseCollectionViewCell.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2019/10/17.
//  Copyright © 2019 ddkt365. All rights reserved.
//

#import "DDBaseCollectionViewCell.h"

@implementation DDBaseCollectionViewCell

/// 注册
/// @param collectionView UICollectionView
+ (void)registerNibForCollectionView:(UICollectionView *)collectionView{
    UINib *nib = [UINib nibWithNibName:self.nibName bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:self.className];
}

/// 从缓存中获取
/// @param collectionView UICollectionView
/// @param indexPath forIndexPath
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.className forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:self.nibName owner:self options:nil] firstObject];
    }
    return cell;
}

/// 获取cell的计算size
/// @param model NSObject
+(CGSize)cellSize:(id)model{
    return CGSizeMake(0, 0);
}

@end
