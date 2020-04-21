//
//  SSLUserListView.m
//  LampHole
//
//  Created by dingdong on 2020/1/5.
//  Copyright © 2020 dingdong. All rights reserved.
//

#import "SSLUserListView.h"
#import "LPSettingTableViewCell.h"

@interface SSLUserListView() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *arrayUser;

@end

@implementation SSLUserListView

+ (SSLUserListView *)shareView
{
    SSLUserListView *view = [[[NSBundle mainBundle] loadNibNamed:[self.class nibName] owner:nil options:nil] firstObject];

    [view initData];
    [view initTableView];
    return view;
}

- (void)showUserListView:(UIView *)view
{
    CGFloat x = (view.width - 200) / 2;
    CGRect frame = CGRectMake(x, kDDNavigationBarHeight, 200, 150);
    [self setFrame:frame];
    [view addSubview:self];
}

- (void)initData
{
    self.arrayUser = [[NSMutableArray alloc] init];
    NSArray<LHUserModel *> *arrayUser = [[DDUserDBManager shareInstance] getUserArray];
    self.arrayUser = [NSMutableArray arrayWithArray:arrayUser];
    
    LHUserModel *cancelModel = [[LHUserModel alloc] init];
    cancelModel.user_name = @"取消";
    [self.arrayUser addObject:cancelModel];
}

- (void)initTableView
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - UITableView Source methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayUser.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LPSettingTableViewCell *cell = [LPSettingTableViewCell cellWithTableView:tableView];
    LHUserModel *model = [self.arrayUser objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - UITableView Delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LHUserModel *model = [self.arrayUser objectAtIndex:indexPath.row];
    if (![model.user_name isEqualToString:@"取消"]) {
        //切换账号
        [[DDUserDBManager shareInstance] logout];
        model.isLogin = YES;
        [[DDUserDBManager shareInstance] saveLoginUser:model];
    }
    [self removeFromSuperview];
}

@end
