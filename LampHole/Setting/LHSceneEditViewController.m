//
//  LHSceneEditViewController.m
//  LampHole
//
//  Created by dingdong on 2019/12/28.
//  Copyright © 2019 dingdong. All rights reserved.
//

#import "LHSceneEditViewController.h"

@interface LHSceneEditViewController ()

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *topMargin;
//情景模式 名称 编辑部分
@property (nonatomic, weak) IBOutlet DDTapView *iconTapView;
@property (nonatomic, weak) IBOutlet UIImageView *iconScene;
@property (nonatomic, strong) DDPhotoSelectUtils *photoSelectUtils;

@property (nonatomic, weak) IBOutlet UITextField *tfScene;
@property (nonatomic, weak) IBOutlet UIButton *btnChange;

//单灯设置部分
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation LHSceneEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tfScene setText:self.curSceneModel.sceneName];
    
    [self initUI];
}

- (void)initUI
{
    [self.tfScene addTarget:self action:@selector(textFieldChangeSender:) forControlEvents:UIControlEventEditingChanged];
    
    @weakify(self);
    [self.iconTapView addSender:^{
        @strongify(self);
//        [self handleSceneImageEdit];
    }];
    
    [self.topMargin setConstant:kDDNavigationBarHeight];
}

- (void)handleSceneImageEdit
{
    self.photoSelectUtils = [DDPhotoSelectUtils photoSelectFromVc:self];
    @weakify(self);
    [self.photoSelectUtils showSingleImagePick:^(NSArray<NSURL *> *imageURLArray) {
        @strongify(self);
        NSURL *url = imageURLArray.firstObject;
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        [self.iconScene setImage:[UIImage imageWithData:imageData]];
        self.curSceneModel.iconSceneData = imageData;
        [self saveSceneInfo];
//        [DDUserImageView postUserLogoNotification:url];
//        if (url && imageData) {
//            [self uploadImageData:imageData];
//        }
    }];
}

- (void)saveSceneInfo
{
    //存储信息
    [[LHSceneDBManager shareInstance] saveScene:self.curSceneModel];
}

#pragma mark - ......::::::: 输入框 :::::::......
-(void)textFieldChangeSender:(UITextField *)textField{
    [textField.undoManager removeAllActions];
    if (textField == _tfScene){
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
        [_btnChange setUserInteractionEnabled:YES];
        UIColor *color = DDColorHex(kDDColor_FF8667);
        [_btnChange setBackgroundColor:color];
        
        [_btnChange setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        [_btnChange setUserInteractionEnabled:NO];
        UIColor *color = DDColorHex(kDDColor_E6EEF2);
        [_btnChange setBackgroundColor:color];
        
        UIColor *tittleColor = DDColorHex(kDDColor_999999);
        [_btnChange setTitleColor:tittleColor forState:UIControlStateNormal];
    }
}

- (BOOL)isCorrectScene
{
    NSString *sceneName = self.tfScene.text.trim;
    if (sceneName.length > 0 && ![sceneName isEqualToString:self.curSceneModel.sceneName]) {
        return YES;
    }
    return NO;
}

#pragma mark - IBOutlet methods
- (IBAction)handleBtnChange:(id)sender
{
    NSString *sceneName = self.tfScene.text.trim;
    self.curSceneModel.sceneName = sceneName;
    [self saveSceneInfo];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
