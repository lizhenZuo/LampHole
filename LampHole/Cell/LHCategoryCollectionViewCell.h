//
//  LHCategoryCollectionViewCell.h
//  LampHole
//
//  Created by dingdong on 2019/12/28.
//  Copyright © 2019 dingdong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHCategoryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LHCategoryCollectionViewCell : UICollectionViewCell

+ (void)registerNibForCollectionView:(UICollectionView *)collectionView;
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong) LHCategoryModel *model;

@end

NS_ASSUME_NONNULL_END
