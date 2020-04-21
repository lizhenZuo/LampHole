//
//  LHDevSingleColorSetViewController.m
//  LampHole
//
//  Created by dingdong on 2019/12/28.
//  Copyright © 2019 dingdong. All rights reserved.
//

#import "LHDevSingleColorSetViewController.h"
#import "LPDevDetailViewController.h"
#import "LPSettingTableViewCell.h"

@interface LHDevSingleColorSetViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UIView *staticView;
@property (nonatomic, weak) IBOutlet UISlider *slider;

@property (nonatomic, weak) IBOutlet UIView *dynamicView;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayDynamicItem;

@property (nonatomic, weak) IBOutlet UIButton *btnStaticAjust;
@property (nonatomic, weak) IBOutlet UIButton *btnDynamicAjsut;

@end

@implementation LHDevSingleColorSetViewController

- (BOOL)dd_isHiddenNaviBar
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *title = self.devModel.device_name;
    DDNavigationBarView *navBarView = [self addCustomNavigationBar:title];
    @weakify(self);
    [navBarView addBackSender:^{
        @strongify(self);
        [self dd_popViewControllerAnimated:YES];
    }];
    [navBarView addRightSender:^{
        @strongify(self);
        [self handleDevDetail];
    }];
    
    [self initData];
    [self initUI];
}

- (void)initData
{
    self.arrayDynamicItem = [[NSMutableArray alloc] init];
}

- (void)initUI
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
}

#pragma mark - Private methods
- (void)handleDevDetail
{
    LPDevDetailViewController *vc = [[LPDevDetailViewController alloc] init];
    vc.title = @"设备设置";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableView DataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayDynamicItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LPSettingTableViewCell *cell = [LPSettingTableViewCell cellWithTableView:tableView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

#pragma mark - UITableView DataSource methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - IBOutlet methods
- (IBAction)handleBtnStaticAjust:(id)sender
{
    [self.staticView setHidden:NO];
    [self.btnStaticAjust setBackgroundColor:kGetColor(250, 110, 80)];
    [self.btnStaticAjust setTitleColor:kGetColor(255, 255, 255) forState:UIControlStateNormal];
    
    [self.dynamicView setHidden:YES];
    [self.btnDynamicAjsut setBackgroundColor:kGetColor(102, 102, 102)];
    [self.btnDynamicAjsut setTitleColor:kGetColor(51, 51, 51) forState:UIControlStateNormal];
}

- (IBAction)handleBtnDynamicAjust:(id)sender
{
    [self.staticView setHidden:YES];
    [self.btnStaticAjust setBackgroundColor:kGetColor(102, 102, 102)];
    [self.btnStaticAjust setTitleColor:kGetColor(51, 51, 51) forState:UIControlStateNormal];
    
    [self.dynamicView setHidden:NO];
    [self.btnDynamicAjsut setBackgroundColor:kGetColor(250, 110, 80)];
    [self.btnDynamicAjsut setTitleColor:kGetColor(255, 255, 255) forState:UIControlStateNormal];
}

@end
