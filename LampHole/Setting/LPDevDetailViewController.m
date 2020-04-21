//
//  LPDevDetailViewController.m
//  LampHole
//
//  Created by dingdong on 2019/12/26.
//  Copyright © 2019 dingdong. All rights reserved.
//

#import "LPDevDetailViewController.h"
#import "SSLDevEditNameViewController.h"
#import "SSLSetingViewTableViewCell.h"

@interface LPDevDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *arrayItem;

@end

@implementation LPDevDetailViewController

static NSString *const kItemName_DevName = @"名称";
static NSString *const kItemName_DevLogo = @"图案";
static NSString *const kItemName_DevStatus = @"状态";
static NSString *const kItemName_DevVersion = @"版本";
static NSString *const kItemName_DevSerialNum = @"序列号";
static NSString *const kItemName_DevReser = @"预约";
static NSString *const kItemName_DevReset = @"恢复出厂设置";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self initUI];
}

- (void)initData
{
    self.arrayItem = [[NSMutableArray alloc] init];
    
    SSLSettingModel *model = [[SSLSettingModel alloc] init];
    model.title = kItemName_DevName;
    model.isCanEdit = YES;
    model.subTitle = self.devModel.device_name;
    [self.arrayItem addObject:model];
    
    model = [[SSLSettingModel alloc] init];
    model.title = kItemName_DevLogo;
    model.isCanEdit = YES;
    model.subTitle = self.devModel.device_icon;
    [self.arrayItem addObject:model];
    
    model = [[SSLSettingModel alloc] init];
    model.title = kItemName_DevStatus;
    model.isCanEdit = NO;
    model.subTitle = @"连接";
    [self.arrayItem addObject:model];
    
    model = [[SSLSettingModel alloc] init];
    model.title = kItemName_DevVersion;
    model.isCanEdit = NO;
    model.subTitle = self.devModel.device_version;
    [self.arrayItem addObject:model];
    
    model = [[SSLSettingModel alloc] init];
    model.title = kItemName_DevSerialNum;
    model.isCanEdit = NO;
    model.subTitle = self.devModel.device_serial_number;
    [self.arrayItem addObject:model];
    
    model = [[SSLSettingModel alloc] init];
    model.title = kItemName_DevReser;
    model.isCanEdit = YES;
    [self.arrayItem addObject:model];
    
    model = [[SSLSettingModel alloc] init];
    model.title = kItemName_DevReset;
    model.isCanEdit = YES;
    [self.arrayItem addObject:model];
}

- (void)initUI
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - UITableView Source methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSLSetingViewTableViewCell *cell = [SSLSetingViewTableViewCell cellWithTableView:tableView];
    SSLSettingModel *model = [self.arrayItem objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

#pragma mark - UITableView Delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SSLSettingModel *model = [self.arrayItem objectAtIndex:indexPath.row];
    if ([model.title isEqualToString:kItemName_DevName]) {
        //昵称修改页
        SSLDevEditNameViewController *vc = [[SSLDevEditNameViewController alloc] init];
        [self dd_pushViewController:vc animated:YES];
    }
    else if ([model.title isEqualToString:kItemName_DevLogo]) {
        //修改设备头像
    }
    else if ([model.title isEqualToString:kItemName_DevReser]) {
        //预约
    }
    else if ([model.title isEqualToString:kItemName_DevReset]) {
        //重置设备
        DDOKCancelDialog *dialog = [DDOKCancelDialog alertWithTitle:@"提示" subTitle:@"确定要恢复出厂设置吗？" leftlTitle:@"取消" rightlTitle:@"确定"];
        [dialog showDialog:^{
            
        } leftBlock:^{
            
        }];
    }
}

@end
