//
//  LHCategoryCollectionViewCell.m
//  LampHole
//
//  Created by dingdong on 2019/12/28.
//  Copyright © 2019 dingdong. All rights reserved.
//

#import "LHCategoryCollectionViewCell.h"

@interface LHCategoryCollectionViewCell()

@property (nonatomic, weak) IBOutlet UILabel *lblTitle;
@property (nonatomic, weak) IBOutlet UILabel *lblDesc;

@end

@implementation LHCategoryCollectionViewCell

static NSString * const cellIdentifier  = @"DDPMeHorizontallyCollectionViewCell";

+ (void)registerNibForCollectionView:(UICollectionView *)collectionView{
    [collectionView registerNib:[UINib nibWithNibName:[self nibName] bundle:nil]
     forCellWithReuseIdentifier:cellIdentifier];
}

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:[self nibName] owner:self options:nil] firstObject];
    }
    return cell;
}

-(void)setModel:(LHCategoryModel *)model
{
    [self.lblTitle setText:model.categoryName];
    if (model.nums > 0) {
        //可点击状态
    }
    else {
        //不可点击状态
        
    }
    NSString *desc = [NSString stringWithFormat:@"在线：%@", @(model.nums)];
    [self.lblDesc setText:desc];
}

@end
