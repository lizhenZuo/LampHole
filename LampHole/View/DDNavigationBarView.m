//
//  DDNavigationBarView.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/8/28.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "DDNavigationBarView.h"
#import "DDTapView.h"

@interface DDNavigationBarView()

@property (weak, nonatomic) IBOutlet DDTapView *backView;
@property (weak, nonatomic) IBOutlet DDTapView *titleView;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgTitleArrow;
@property (weak, nonatomic) IBOutlet UIImageView *imgBack;
@property (weak, nonatomic) IBOutlet UIButton *btnRight;

@property (copy, nonatomic) DDNoParamsBlock completeBlock;
@property (copy, nonatomic) DDNoParamsBlock rightHandlBlock;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) UIColor *titleColor;
@property (strong, nonatomic) UIImage *backImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutBackImgViewLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutTitleLabelWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutTitleArrowImageTrailing;

@end

@implementation DDNavigationBarView{
    CGFloat _imgTitleArrowTrailing;
}


+(instancetype)navigationBarView:(NSString *)title{
    DDNavigationBarView *view = [[[NSBundle mainBundle] loadNibNamed:[self nibName ] owner:nil options:nil] firstObject];
    view.title = title;
    [view initUI];
    return view;
}

//特定场景下使用
+(instancetype)navigationBarView:(NSString *)title titleColor:(UIColor *)titleColor backImage:(UIImage * _Nullable)backImage
{
    DDNavigationBarView *view = [[[NSBundle mainBundle] loadNibNamed:[self nibName ] owner:nil options:nil] firstObject];
    view.title = title;
    view.titleColor = titleColor;
    view.backImage = backImage;
    [view initUI];
    return view;
}

-(void)initUI{
    if(DDUtilities.isDeviceIphoneXSeries){
        _layoutBackImgViewLeading.constant = kLeadingIPhoneXValue;
    }
    //
//    self.backgroundColor = [UIColor clearColor];
    @weakify(self);
    [_backView addSender:^{
        @strongify(self);
        if (self.completeBlock) {
            self.completeBlock();
        }
    }];
    //
    [_titleView setUserInteractionEnabled:NO];
    [_lbTitle setText:_title];
    if (_titleColor)
    {
        [_lbTitle setTextColor:_titleColor];
    }
    if (_backImage)
    {
        [_imgBack setImage:_backImage];
    }
    
    //隐藏
    [self hiddenTitleRightImage];
}

-(void)updateRightBtnStatus:(BOOL)isShow
{
    self.btnRight.hidden = isShow;
}

/**
 添加返回按钮事件
 */
-(void)addBackSender:(DDNoParamsBlock)completeBlock{
    self.completeBlock = completeBlock;
}

/**
 添加右边按钮事件
 */
- (void)addRightSender:(DDNoParamsBlock)completeBlock{
    self.rightHandlBlock = completeBlock;
}

/**
 添加title按钮事件
 */
-(void)addTitleSender:(DDNoParamsBlock)titleBlock{
    [_imgTitleArrow setImage:nil];
    _layoutTitleArrowImageTrailing.constant = 0.f;
    [_titleView addSender:^{
        if (titleBlock) {
            titleBlock();
        }
    }];
}


/**
 更新title
 */
-(void)updateTitle:(NSString *)title{
    self.title = title;
    [self.lbTitle setText:title];
}

/**
 更新标题宽度(默认为300)
 
 @param width 宽度
 */
-(void)updateNaviTitleToPortrait:(CGFloat)width{
    _layoutTitleLabelWidth.constant = width;
    if(DDisiPad){
        [_lbTitle setFont:[UIFont systemFontOfSize:24.f]];
    }else{
        [_lbTitle setFont:[UIFont systemFontOfSize:16.f]];
    }
}

/**
 更新title右侧的图标，显示
 */
-(void)showTitleRightImage:(UIImage *)image{
    [self.imgTitleArrow setHidden:NO];
    [self.imgTitleArrow setImage:[UIImage imageNamed:@"navi_down_arrow"]];
    _layoutTitleArrowImageTrailing.constant = _imgTitleArrowTrailing;
    if (image) {
        [self.imgTitleArrow setImage:image];
    }
}


/** 隐藏右侧箭头*/
-(void)hiddenTitleRightImage{
    [self.imgTitleArrow setHidden:YES];
    [self.imgTitleArrow setImage:nil];
    _imgTitleArrowTrailing = _layoutTitleArrowImageTrailing.constant;
    _layoutTitleArrowImageTrailing.constant = 0;
}

/**
 更新title透明度
 @param alpha 值
 */
-(void)updateTitleAlpha:(CGFloat)alpha{
    self.titleView.alpha = alpha;
}

/**
 添加右侧按钮
 
 @param title 按钮标题
 @param handleBlock 按钮点击回调
 */
-(UIButton *)addRightButton:(NSString *)title handle:(DDNoParamsBlock)handleBlock{
    self.rightHandlBlock = handleBlock;
    CGFloat width = 60;
    CGFloat height = 40;
    CGFloat cornerRadius = height/2.f;
    CGFloat fontSize = 15.f;
    if (DDisiPad) {
        width = 130;
        height = 70;
        cornerRadius = height/2.f;
        fontSize = 24.f;
    }
    
    UIButton *btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSave setTitle:title forState:UIControlStateNormal];
    [btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnSave.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
    UIColor *disableColor = [UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.6];
    [btnSave setTitleColor:disableColor forState:UIControlStateDisabled];
    [btnSave setTitle:title forState:UIControlStateDisabled];
    UIColor *backgroundColor = [UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.25];
    [btnSave setBackgroundColor:backgroundColor];
    btnSave.layer.cornerRadius = cornerRadius;
    btnSave.clipsToBounds = YES;
    [self addSubview:btnSave];
    [btnSave addTarget:self action:@selector(handleCommitSender) forControlEvents:UIControlEventTouchUpInside];
    @weakify(self);
    [btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.right.equalTo(self).offset(-20);
        make.centerY.equalTo(self);
        make.height.equalTo(@(height));
        make.width.equalTo(@(width));
    }];
    return btnSave;
}

-(void)handleCommitSender{
    if (self.rightHandlBlock) {
        self.rightHandlBlock();
    }
}

- (IBAction)handleBtnRightBtn:(id)sender{
    if (self.rightHandlBlock) {
        self.rightHandlBlock();
    }
}

/**
 设置返回按钮的图片
 @param imageName 返回按键图片名称
 */
-(void)setBackImageName:(NSString *)imageName{
    [self.imgBack setImage:[UIImage imageNamed:imageName]];
}

@end
