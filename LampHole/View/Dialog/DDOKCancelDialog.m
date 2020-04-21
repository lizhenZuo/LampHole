//
//  DDOKCancelDialog.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/5.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "DDOKCancelDialog.h"

@interface DDOKCancelDialog()
//标题视图
@property (weak, nonatomic) IBOutlet UIView *titleView;
//顶部icon
@property (weak, nonatomic) IBOutlet UIImageView *dialogIcon;
//背景点击事件
@property (weak, nonatomic) IBOutlet UIButton *btnClickBg;
//标题提示图片
@property (weak, nonatomic) IBOutlet UIImageView *titleTipImgView;
//黑色背景
@property (weak, nonatomic) IBOutlet UIView *blackBgView;
//aertView
@property (weak, nonatomic) IBOutlet UIView *dialogView;
//标题栏
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
//内容体
@property (weak, nonatomic) IBOutlet UILabel *contentTv;
//取消按钮
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
//确定按钮
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
//双按钮
@property (weak, nonatomic) IBOutlet UIView *doubleBtnView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutContentTvHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutAlertViewWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutTitleViewHeight;

//内容高度
@property (assign, nonatomic) float contentTvHeight;
//兑换框宽度
@property (assign, nonatomic) float alertViewWidth;
//title高度
@property (assign, nonatomic) float titleViewHeight;

@property (assign, nonatomic) BOOL isCanClickBg;

//取消事件
- (IBAction)cancelSender:(id)sender;
//确认事件
- (IBAction)confimSender:(id)sender;

@property (nonatomic,copy) DDOKCancelDialogBlock rightBlock;//双按钮确定block
@property (nonatomic,copy) DDOKCancelDialogBlock leftBlock;//双按钮取消block

@property (copy, nonatomic)NSString *title;
@property (copy, nonatomic)NSString *subTitle;
@property (copy, nonatomic)NSString *cancelTitle;
@property (copy, nonatomic)NSString *confirmTitle;
@property (copy, nonatomic)NSString *titleImageName;
@property (copy, nonatomic)NSString *dialogIconName;

@end

@implementation DDOKCancelDialog
/**
 初始化alertView

 @param title 标题
 @param subTitle 副标题
 @param cancelTitle 取消按钮文本
 @param confirmTitle 确认按钮文本
 @return 当前对象
 */
+(instancetype)alertWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                  leftlTitle:(NSString *)cancelTitle
                 rightlTitle:(NSString *)confirmTitle{
    return [self.class alertWithTitle:title
                             subTitle:subTitle
                          leftlTitle:cancelTitle
                         rightlTitle:confirmTitle
                       titleImageName:nil];
}



/**
 初始化alertView

 @param title 标题
 @param subTitle 副标题
 @param cancelTitle 取消按钮文本
 @param confirmTitle 确认按钮文本
 @return 当前对象
 */
+(instancetype)alertWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                  leftlTitle:(NSString *)cancelTitle
                 rightlTitle:(NSString *)confirmTitle
               titleImageName:(NSString *)titleImageName{

    __block DDOKCancelDialog *dialog;
    dispatch_sync_on_main_queue(^{
        dialog = [self loadFromSelfNibName];
        dialog.title = title;
        dialog.subTitle = subTitle;
        dialog.cancelTitle = cancelTitle;
        dialog.confirmTitle = confirmTitle;
        dialog.titleImageName = titleImageName;
        [dialog setupDataUI];

    });
    return dialog;
}

/**
 初始化alertView
 
 @param title 标题
 @param subTitle 副标题
 @param cancelTitle 取消按钮文本
 @param confirmTitle 确认按钮文本
 @param dialogIconName dialog顶部图片
 @return 当前对象
 */
+(instancetype)alertWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                   leftlTitle:(NSString *)cancelTitle
                  rightlTitle:(NSString *)confirmTitle
                   dialogIcon:(NSString *)dialogIconName
                 isCanClickBg:(BOOL)isCanClickBg{
    
    __block DDOKCancelDialog *dialog;
    dispatch_sync_on_main_queue(^{
        dialog = [self loadFromSelfNibName];
        dialog.title = title;
        dialog.subTitle = subTitle;
        dialog.cancelTitle = cancelTitle;
        dialog.confirmTitle = confirmTitle;
        dialog.dialogIconName = dialogIconName;
        dialog.isCanClickBg = isCanClickBg;
        [dialog setupDataUI];
        
    });
    return dialog;
}

-(void)setupDataUI{
    //查找到图片
    UIImage *image = nil;
    if (self.titleImageName != nil && self.titleImageName.length != 0) {
        image = [UIImage imageNamed:self.titleImageName];
    }
    //初始化title
    [self setupDialogTitle:self.title image:image];
    //提示内容
    [self setupDialogContent:self.subTitle];
    //设置取消按键
    if (self.cancelTitle!=nil) {
        [self.cancelBtn setTitle:self.cancelTitle forState:UIControlStateNormal];
    }
    if (self.confirmTitle!=nil) {
        [self.confirmBtn setTitle:self.confirmTitle forState:UIControlStateNormal];
    }
    
    if (self.dialogIconName)
    {
        [self.dialogIcon setImage:[UIImage imageNamed:self.dialogIconName]];
        self.dialogIcon.hidden = NO;
    }
    else
    {
        self.dialogIcon.hidden = YES;
    }
    
    if (self.isCanClickBg)
    {
        self.btnClickBg.hidden = NO;
    }
    else
    {
        self.btnClickBg.hidden = YES;
    }
}

/**
 初始化标题
 @param title 标题
 @param image tips 图片
 */
-(void)setupDialogTitle:(NSString *)title
                  image:(UIImage *)image{
    //标题内容
    if(title == nil || title.length == 0){
        [self.titleView setHidden:YES];
        self.layoutTitleViewHeight.constant = DDisiPad?18:10;
    }else{
        [self.titleView setHidden:NO];
        self.layoutTitleViewHeight.constant = self.titleViewHeight;
    }
    
    if (!self.isHidden) {
        //设置tips image
        if (image != nil) {
            [self.titleTipImgView setImage:image];
            [self.titleTipImgView setHidden:NO];
        }else{
            [self.titleTipImgView setImage:image];
            [self.titleTipImgView setHidden:YES];
        }
        //设置title
        [self.titleLb setText:title];
    }
}

/**
 设置subTitle的内容
 @param subTitle 内容
 */
-(void)setupDialogContent:(NSString *)subTitle{

    [self.contentTv setNumberOfLines:0];
    static CGFloat const kLineSpacing = 4;
    CGSize subTitleSize = [subTitle sizeForFont:self.contentTv.font size:CGSizeMake(self.contentTv.width, MAXFLOAT) mode:NSLineBreakByWordWrapping];
    BOOL singleLine = NO;
    if (subTitleSize.height < 2 * self.contentTv.font.pointSize) {
        singleLine = YES;
    }else{
        singleLine = NO;
    }

    //调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:subTitle];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:kLineSpacing];
    if (singleLine) {
        [paragraphStyle setAlignment:NSTextAlignmentCenter];
    }else{
        if([subTitle containsString:@"\n"]){
            [paragraphStyle setAlignment:NSTextAlignmentCenter];
        }else{
         [paragraphStyle setAlignment:NSTextAlignmentCenter];
        }
    }

    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [subTitle length])];
    self.contentTv.attributedText = attributedString;

    //计算高度
    CGSize cSize = CGSizeMake(self.contentTv.width, MAXFLOAT);
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading;
    NSDictionary<NSString *, id> *attributes = @{NSParagraphStyleAttributeName:paragraphStyle,
                                                 NSFontAttributeName:self.contentTv.font};
    CGSize attSize = [subTitle boundingRectWithSize:cSize
                                            options:options
                                         attributes:attributes
                                            context:nil].size;
    //判断高度
    CGFloat maxHeight = kDDScreenHeight-120;
    CGFloat attHeight = attSize.height;
    CGFloat height = maxHeight<attHeight?maxHeight:attHeight;
    if (self.contentTvHeight < height) {
        self.layoutContentTvHeight.constant = height;
    }
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initUI];
}

/** 初始化视图 */
-(void)initUI{
    //赋值
    _alertViewWidth = _layoutAlertViewWidth.constant;
    //赋值
    _contentTvHeight = _layoutContentTvHeight.constant;
    //
    _titleViewHeight = _layoutTitleViewHeight.constant;
    //取消按钮
    _cancelBtn.layer.borderColor = DDColorHex(kDDColor_999999).CGColor;
    _cancelBtn.layer.borderWidth = 1.f;
    UIImage *imageCancel = [UIImage imageWithColor:[UIColor whiteColor]];
    [_cancelBtn setBackgroundImage:imageCancel forState:UIControlStateNormal];
    UIImage *imageCancelHigh = [UIImage imageWithColor:DDColorHex(kDDColor_F2F2F2)];
    [_cancelBtn setBackgroundImage:imageCancelHigh forState:UIControlStateHighlighted];
    //确定按钮
    UIImage *image = [UIImage imageWithColor:DDColorHex(kDDColor_system_FF6E50)];
    [_confirmBtn setBackgroundImage:image forState:UIControlStateNormal];
}


//取消事件
- (IBAction)cancelSender:(id)sender {
    if (_leftBlock) {
        _leftBlock();
    }
    [self dismissDialog];
}
//确认事件
- (IBAction)confimSender:(id)sender {
    if (_rightBlock) {
        _rightBlock();
    }
    [self dismissDialog];
}

- (IBAction)handleBtnClose:(id)sender{
    if (self.isCanClickBg) {
        [self dismissDialog];
    }
}

/**
 显示双按钮对话框

 @param rightBlock 确认回调
 @param leftBlock 取消回调
 */
-(void)showDialog:(DDOKCancelDialogBlock)rightBlock
               leftBlock:(DDOKCancelDialogBlock)leftBlock{
    _rightBlock = rightBlock;
    _leftBlock = leftBlock;
    [self showDialog];
}

/**
 显示双按钮对话框

 @param rightBlock 确认回调
 */
-(void)showDialog:(DDOKCancelDialogBlock)rightBlock{
    [self showDialog:rightBlock leftBlock:nil];
}

/** 显示弹窗  */
-(void)showDialog{
 [self showAnimation:self.dialogView];
}

/** 隐藏dialog */
-(void)dismissDialog{
    [self dismissAnimation:self.dialogView];
}


@end
