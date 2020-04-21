//
//  SSLSetingViewTableViewCell.m
//  LampHole
//
//  Created by dingdong on 2020/1/5.
//  Copyright © 2020 dingdong. All rights reserved.
//

#import "SSLSetingViewTableViewCell.h"

@interface SSLSetingViewTableViewCell()
@property (nonatomic, weak) IBOutlet UILabel *lblTitle;
@property (nonatomic, weak) IBOutlet UILabel *lblSubTitle;
@end

@implementation SSLSetingViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellIdentifier = @"SSLSetingViewTableViewCell";
    SSLSetingViewTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
    if(cell==nil){
        cell=[[[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

- (void)setModel:(SSLSettingModel *)model
{
    [self.lblTitle setText:model.title];
    [self.lblSubTitle setText:model.subTitle];
}

@end
