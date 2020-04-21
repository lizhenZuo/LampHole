//
//  SSLLoginViewController.m
//  LampHole
//
//  Created by dingdong on 2019/12/28.
//  Copyright © 2019 dingdong. All rights reserved.
//

#import "SSLLoginViewController.h"
#import "LPSettingTableViewCell.h"
#import "SSLDevSearchViewController.h"
#import "SSLDevAddSuccessViewController.h"

@interface SSLLoginViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UITextField *tfUserName;
@property (nonatomic, weak) IBOutlet UITextField *tfPassword;
@property (nonatomic, weak) IBOutlet UIButton *btnLogin;

//数据
@property (nonatomic, strong) NSMutableArray *arrayUserName;

@end

@implementation SSLLoginViewController

- (BOOL)dd_isHiddenNaviBar{
    if (self.loginType == LOGIN_TYPE_DEFAULT) {
        return YES;
    }
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self initUI];
}

- (void)initData
{
    self.arrayUserName = [[NSMutableArray alloc] init];
    
    NSArray<LHUserModel *> *arrayUser = [[DDUserDBManager shareInstance] getUserArray];
    self.arrayUserName = [NSMutableArray arrayWithArray:arrayUser];
    
    [self.tableView reloadData];
}

- (void)initUI
{
    [self.tfUserName addTarget:self action:@selector(textFieldChangeSender:) forControlEvents:UIControlEventEditingChanged];
    [self.tfPassword addTarget:self action:@selector(textFieldChangeSender:) forControlEvents:UIControlEventEditingChanged];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    
    if (self.loginType == LOGIN_TYPE_AddDev) {
        self.title = @"添加设备";
        [self.btnLogin setTitle:@"添加设备" forState:UIControlStateNormal];
        [self.lblDesc setHidden:NO];
    }
    else {
        [self.lblDesc setHidden:YES];
    }
}

#pragma mark - ......::::::: 输入框 :::::::......
-(void)textFieldChangeSender:(UITextField *)textField{
    
    [self.tableView setHidden:YES];
    
    [textField.undoManager removeAllActions];
    if(textField == _tfUserName){
        NSString *value = textField.text.stringByTrim;
        if (textField.markedTextRange == nil && value.length > kMaxAccountLenght) {
            NSString *subValue = [value substringWithRange:NSMakeRange(0, kMaxAccountLenght)];
            [textField setText:subValue];
            return;
        }
    }else if (textField == _tfPassword){
        //密码
        NSString *value = textField.text.stringByTrim;
        if (textField.markedTextRange == nil && value.length > kMaxPasswordLenght) {
            NSString *subValue = [value substringWithRange:NSMakeRange(0, kMaxPasswordLenght)];
            [textField setText:subValue];
            return;
        }
    }
    [self updateCommitButtonUI];
}

/** 密码是否正确 */
-(BOOL)isCorrectPwd{
    NSString *pwdStr = _tfPassword.text.stringByTrim;
    return pwdStr.length>=kMinPasswordLenght && pwdStr.length <= kMaxPasswordLenght;
}

/** 账户是否正确 */
-(BOOL)isCorrectAccount{
    NSString *accountStr = _tfUserName.text.trim;
//    return accountStr.length == kMaxAccountLenght;
    return accountStr.length >= kMinAccountLenght && accountStr.length <= kMaxAccountLenght;
}

/** 更新提交按钮的UI */
-(void)updateCommitButtonUI{
    if ([self isCorrectAccount] && [self isCorrectPwd]) {
        [_btnLogin setUserInteractionEnabled:YES];
        UIColor *color = DDColorHex(kDDColor_FF8667);
        [_btnLogin setBackgroundColor:color];
        
        [_btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        [_btnLogin setUserInteractionEnabled:NO];
        UIColor *color = DDColorHex(kDDColor_E6EEF2);
        [_btnLogin setBackgroundColor:color];
        
        UIColor *tittleColor = DDColorHex(kDDColor_999999);
        [_btnLogin setTitleColor:tittleColor forState:UIControlStateNormal];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayUserName.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LPSettingTableViewCell *cell = [LPSettingTableViewCell cellWithTableView:tableView];
    LHUserModel *model = [self.arrayUserName objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

#pragma mark - UITableView DataSource methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LHUserModel *model = [self.arrayUserName objectAtIndex:indexPath.row];
    [self.tfUserName setText:model.user_name];
    [self.tfPassword setText:model.password];
    [self updateCommitButtonUI];
    
    [self.tableView setHidden:YES];
    [self.tfPassword resignFirstResponder];
    [self.tfUserName resignFirstResponder];
}

#pragma mark - IBOutlet methods
- (IBAction)handleBtnAccountList:(id)sender
{
    [self.tableView setHidden:NO];
}

- (IBAction)handleBtnClear:(id)sender
{
    
}

- (IBAction)handleBtnSearchDev:(id)sender
{
    SSLDevSearchViewController *vc = [[SSLDevSearchViewController alloc] init];
    vc.title = @"搜索设备";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)handleBtnLogin:(id)sender
{
    [self.tfUserName resignFirstResponder];
    [self.tfPassword resignFirstResponder];
    
    NSString *userName = self.tfUserName.text.trim;
    BOOL isExistUser = NO;
    for (LHUserModel *model in self.arrayUserName)
    {
        if ([model.user_name isEqualToString:userName]) {
            isExistUser = YES;
            model.isLogin = YES;
            [[DDUserDBManager shareInstance] saveLoginUser:model];
            break;
        }
    }
    if (!isExistUser) {
        //需要生成账号
        LHUserModel *userModel = [[LHUserModel alloc] init];
        userModel.user_name = userName;
        NSString *psw = self.tfPassword.text.trim;
        userModel.password = psw;
        NSString *userID = [NSString stringWithFormat:@"%@", @([DDTimeUtils getNowTimeStamp])];
        userModel.user_id = userID;
        userModel.isLogin = YES;
        
        [[DDUserDBManager shareInstance] saveLoginUser:userModel];
    }
    
//    [self showLoading];
    
    /**
     登录成功，然后开始搜索当前设备
     */
    
    // .....
    
    if (self.loginType == LOGIN_TYPE_DEFAULT) {
        [[AppDelegate sharedAppDelegate] startHomeViewController:kDDApplicationWindow];
    }
    else {
        SSLDevAddSuccessViewController *vc = [[SSLDevAddSuccessViewController alloc] init];
        vc.title = @"添加设备";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
