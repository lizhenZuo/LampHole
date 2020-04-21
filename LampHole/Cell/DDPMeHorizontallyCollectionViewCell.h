//
//  DDPMeHorizontallyCollectionViewCell.h
//  AiTeacheriPhone
//
//  Created by dingdong on 2019/10/16.
//  Copyright © 2019 ddkt365. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LHDeviceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDPMeHorizontallyCollectionViewCell : UICollectionViewCell

+ (void)registerNibForCollectionView:(UICollectionView *)collectionView;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong) LHDeviceModel *model;

@end

NS_ASSUME_NONNULL_END
