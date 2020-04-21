//
//  SSLDevEditNameViewController.m
//  LampHole
//
//  Created by dingdong on 2020/1/5.
//  Copyright © 2020 dingdong. All rights reserved.
//

#import "SSLDevEditNameViewController.h"

@interface SSLDevEditNameViewController ()

@property (nonatomic, weak) IBOutlet UITextField *tfName;
@property (nonatomic, weak) IBOutlet UIButton *btnSave;

@end

@implementation SSLDevEditNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tfName addTarget:self action:@selector(textFieldChangeSender:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - ......::::::: 输入框 :::::::......
-(void)textFieldChangeSender:(UITextField *)textField{
    [textField.undoManager removeAllActions];
    if (textField == _tfName){
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

/** 更新提交按钮的UI */
-(void)updateCommitButtonUI{
    if ([self isCorrectScene]) {
        [_btnSave setUserInteractionEnabled:YES];
        UIColor *color = DDColorHex(kDDColor_FF8667);
        [_btnSave setBackgroundColor:color];
        
        [_btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        [_btnSave setUserInteractionEnabled:NO];
        UIColor *color = DDColorHex(kDDColor_E6EEF2);
        [_btnSave setBackgroundColor:color];
        
        UIColor *tittleColor = DDColorHex(kDDColor_999999);
        [_btnSave setTitleColor:tittleColor forState:UIControlStateNormal];
    }
}

- (BOOL)isCorrectScene
{
    NSString *sceneName = self.tfName.text.trim;
    if (sceneName.length > 0 && ![sceneName isEqualToString:self.devModel.device_name]) {
        return YES;
    }
    return NO;
}

#pragma mark - IBOutlet methods
- (IBAction)handleBtnClear:(id)sender
{
    
}

- (IBAction)handleBtnSave:(id)sender
{
    
}

@end
