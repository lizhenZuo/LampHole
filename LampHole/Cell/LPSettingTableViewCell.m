//
//  LPSettingTableViewCell.m
//  LampHole
//
//  Created by dingdong on 2019/12/26.
//  Copyright © 2019 dingdong. All rights reserved.
//

#import "LPSettingTableViewCell.h"

@interface LPSettingTableViewCell()

@property (nonatomic, weak) IBOutlet UILabel *lblTitle;

@end

@implementation LPSettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellIdentifier = @"LPSettingTableViewCell";
    LPSettingTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
    if(cell==nil){
        cell=[[[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

- (void)setModel:(LHUserModel *)model
{
    [self.lblTitle setText:model.user_name];
}

@end
