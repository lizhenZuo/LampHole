//
//  DDTextListDialogTableViewCell.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/21.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "DDTextListDialogTableViewCell.h"

@interface DDTextListDialogTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *lbName;

@end

@implementation DDTextListDialogTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellIdentifier = @"DDTextListDialogTableViewCell";
    DDTextListDialogTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil){
        cell=[[[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil] firstObject];
    }
    return cell;
}

+(CGFloat)cellHeight:(NSString *)model{
    if (DDisiPad) {
        return 76.f;
    }
    return 50.f;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
}

-(void)initUI{
    if (DDisiPad) {
      [_lbName setFont:[UIFont systemFontOfSize:21.f]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setModel:(NSString *)model{
    _model = model;
    [_lbName setText:model];
    UIColor *textColor = DDColorHex(kDDColor_333333);
    if (self.isLast) {
        textColor = DDColorHex(kDDColor_999999);
    }
    [_lbName setTextColor:textColor];
}

@end
