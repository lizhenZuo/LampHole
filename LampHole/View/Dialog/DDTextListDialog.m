//
//  DDTextListDialog.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/5.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "DDTextListDialog.h"
#import "DDTextListDialogTableViewCell.h"

@interface DDTextListDialog()<UITableViewDelegate,UITableViewDataSource>
//黑色背景
@property (weak, nonatomic) IBOutlet UIView *blackBgView;
//aertView
@property (weak, nonatomic) IBOutlet UIView *dialogView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutDialogHeight;

@property (nonatomic,copy)DDTextListDialogBlock genderBlock;
@property (nonatomic,strong)NSMutableArray<NSString *> *dataArray;
//单按钮
- (IBAction)handleActionSender:(id)sender;

@end

@implementation DDTextListDialog

+(instancetype)shareView:(NSArray<NSString *> *)list{
//    NSAssert(list&&list.count>0, @"不能传入空数据...");
    __block DDTextListDialog *dialog;
    dispatch_sync_on_main_queue(^{
        dialog = [self loadFromSelfNibName];
        //初始化UI
        [dialog setupUI:list];
    });
    return dialog;
}

/** 初始化视图 */
-(void)setupUI:(NSArray<NSString *> *)list{
    self.dataArray = [[NSMutableArray alloc] initWithArray:list];
    [self.dataArray addObject:@"取消"];
    //设置圆角
    BOOL scrollEnabled = NO;
    self.dialogView.layer.cornerRadius = 10;
    [self.dialogView.layer setMasksToBounds:YES];
    if (self.dataArray && self.dataArray.count > 0) {
        CGFloat perHeight = [DDTextListDialogTableViewCell cellHeight:self.dataArray.firstObject];
        CGFloat totalHeight = self.dataArray.count * perHeight;
        CGFloat maxHeight = 250;
        if (DDisiPad) {
            maxHeight = 400;
        }
        if (totalHeight > maxHeight) {
            totalHeight = maxHeight;
            scrollEnabled = YES;
        }
        _layoutDialogHeight.constant = totalHeight;;
    }
    //设置滚动
    self.tableView.scrollEnabled = scrollEnabled;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

//单按钮点击确定
- (IBAction)handleActionSender:(id)sender {
    if (_genderBlock) {
        _genderBlock(@"",0);
    }
}

/**
 显示单按钮对话框
 @param block 确认回调
 */
-(void)showDialog:(DDTextListDialogBlock)block{
    _genderBlock = block;
    [self showDialog];
    
}

/** 显示弹窗  */
-(void)showDialog{
    [self showAnimation:self.dialogView];
}

/** 隐藏dialog */
-(void)dismissDialog{
    [self dismissAnimation:self.dialogView];
}


#pragma mark - ......:::::::  UITableViewDelegate,UITableViewDataSource :::::::......
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *model = [self.dataArray objectAtIndex:indexPath.row];
    DDTextListDialogTableViewCell *cell = [DDTextListDialogTableViewCell cellWithTableView:tableView];
    cell.isLast = [model isEqualToString:self.dataArray.lastObject];
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *model = [self.dataArray objectAtIndex:indexPath.row];
    return [DDTextListDialogTableViewCell cellHeight:model];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *model = [self.dataArray objectAtIndex:indexPath.row];
    if(indexPath.row == self.dataArray.count-1){
        //取消
        [self dismissDialog];
        return;
    }
    //回调
    if (self.genderBlock) {
        self.genderBlock(model,indexPath.row);
        [self dismissDialog];
    }
}

@end
