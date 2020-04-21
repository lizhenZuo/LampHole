//
//  SSLSettingView.m
//  LampHole
//
//  Created by dingdong on 2020/1/5.
//  Copyright © 2020 dingdong. All rights reserved.
//

#import "SSLSettingView.h"
#import "SSLSetingViewTableViewCell.h"

@interface SSLSettingView() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UIImageView *iconLogo;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<NSArray *> *arrayItems;

@end

@implementation SSLSettingView

static NSString *const kItemName_Account = @"账号）";
static NSString *const kItemName_AddDev = @"增加新设备";
static NSString *const kItemName_HideDev = @"添加隐藏设备";
static NSString *const kItemName_MeshOta = @"MESH OTA";
static NSString *const kItemName_AppVersion = @"APP版本";
static NSString *const kItemName_Logout = @"退出登录";

- (void)initTableView
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)initData
{
    self.arrayItems = [[NSMutableArray alloc] init];
    SSLSettingModel *model = [[SSLSettingModel alloc] init];
    model.title = kItemName_Account;
    model.subTitle = [DDUserDBManager shareInstance].getLoginUser.user_name;
    NSArray *array1 = [NSArray arrayWithObject:model];
    [self.arrayItems addObject:array1];
    
    NSMutableArray *array2 = [[NSMutableArray alloc] init];
    model = [[SSLSettingModel alloc] init];
    model.title = kItemName_AddDev;
    [array2 addObject:model];
    
    model = [[SSLSettingModel alloc] init];
    model.title = kItemName_HideDev;
    [array2 addObject:model];
    
    model = [[SSLSettingModel alloc] init];
    model.title = kItemName_MeshOta;
    [array2 addObject:model];
    
    model = [[SSLSettingModel alloc] init];
    model.title = kItemName_AppVersion;
    [array2 addObject:model];
    [self.arrayItems addObject:array2];
    
    model = [[SSLSettingModel alloc] init];
    model.title = kItemName_Logout;
    NSArray *array3 = [NSArray arrayWithObject:model];
    [self.arrayItems addObject:array3];
}

+ (SSLSettingView *)shareSettingView
{
    SSLSettingView *view = [[[NSBundle mainBundle] loadNibNamed:[self.class nibName] owner:nil options:nil] firstObject];
//    [view setupWithVc:homeVc];
    [view initData];
    [view initTableView];
    return view;
}

- (void)showSettingView:(UIView *)view
{
    CGRect frame = CGRectMake(20, 0, 200, 350);
    [self setFrame:frame];
    [view addSubview:self];
}

#pragma mark - UITableView Source methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [self.arrayItems objectAtIndex:section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSLSetingViewTableViewCell *cell = [SSLSetingViewTableViewCell cellWithTableView:tableView];
    NSArray *array = [self.arrayItems objectAtIndex:indexPath.section];
    SSLSettingModel *model = [array objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 15)];
        return footerView;
    }
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat heigth = 0;
    if (section == 0 || section == 1) {
        heigth = 15;
    }
    return heigth;
}

#pragma mark - UITableView Delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *array = [self.arrayItems objectAtIndex:indexPath.section];
    SSLSettingModel *model = [array objectAtIndex:indexPath.row];
    if ([model.title isEqualToString:kItemName_Logout]) {
        //退出登录
        [[DDUserDBManager shareInstance] logout];
        [[AppDelegate sharedAppDelegate] startRootViewController:kDDApplicationWindow];
    }
    else
    {
        [self removeFromSuperview];
    }
}

@end
