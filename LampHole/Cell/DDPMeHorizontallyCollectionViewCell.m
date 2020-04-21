//
//  DDPMeHorizontallyCollectionViewCell.m
//  AiTeacheriPhone
//
//  Created by dingdong on 2019/10/16.
//  Copyright © 2019 ddkt365. All rights reserved.
//

#import "DDPMeHorizontallyCollectionViewCell.h"

@interface DDPMeHorizontallyCollectionViewCell()
@property (nonatomic, weak) IBOutlet UIImageView *icon;
@property (nonatomic, weak) IBOutlet UILabel *lblName;
@end

@implementation DDPMeHorizontallyCollectionViewCell

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

-(void)setModel:(LHDeviceModel *)model
{
    [self.lblName setText:model.device_name];
    model.device_icon = @"http://resource.ddkt365.com/image/201911/0ca5798867d8f473d8b32d921df7a794.png";
    [[DDImageLoader sharedInstance] loadImageWithURL:model.device_icon imageView:self.icon phImage:nil];
}

@end
