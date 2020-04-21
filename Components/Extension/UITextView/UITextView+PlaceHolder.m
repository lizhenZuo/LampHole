//
//  UITextView+PlaceHolder.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/11.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "UITextView+PlaceHolder.h"
#import <objc/runtime.h>

static const void *kPlaceholderAssociateKey=&kPlaceholderAssociateKey;

@interface UITextView()

@property (nonatomic,readonly) UILabel *placeholderLabel;

@end

@implementation UITextView (PlaceHolder)

+(void)load{
    [super load];
    method_exchangeImplementations(class_getInstanceMethod(self.class,NSSelectorFromString(@"layoutSubviews")),
                                   class_getInstanceMethod(self.class,@selector(phSwizzlingLayoutSubViews)));
    method_exchangeImplementations(class_getInstanceMethod(self.class,NSSelectorFromString(@"dealloc")),
                                   class_getInstanceMethod(self.class,@selector(phSwizzlingDealloc)));
    method_exchangeImplementations(class_getInstanceMethod(self.class,NSSelectorFromString(@"setText:")),
                                   class_getInstanceMethod(self.class,@selector(phSwizzlingSetText:)));
    
}

#pragma mark swizzling method
-(void)phSwizzlingLayoutSubViews{
    if(self.placeholderLabel){
        UIEdgeInsets textContainerInset = self.textContainerInset;
        CGFloat lineFragmentPadding = self.textContainer.lineFragmentPadding;
        CGFloat layerBorderWidth = self.layer.borderWidth;
        CGFloat x = lineFragmentPadding + textContainerInset.left + layerBorderWidth;
        CGFloat y = textContainerInset.top + layerBorderWidth;
        CGFloat width = CGRectGetWidth(self.bounds) - x - textContainerInset.right - 2*layerBorderWidth;
        CGFloat height = [self.placeholderLabel sizeThatFits:CGSizeMake(width, 0)].height;
        self.placeholderLabel.frame = CGRectMake(x, y, width, height);
    }
    [self phSwizzlingLayoutSubViews];
}

-(void)phSwizzlingDealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self phSwizzlingDealloc];
    
}

-(void)phSwizzlingSetText:(NSString *)text{
    [self phSwizzlingSetText:text];
    if(self.placeholderLabel){
        [self updatePlaceHolder];
    }
}


#pragma -mark assocation field
-(UILabel *)placeholderLabel{
    UILabel *placeholderLB = objc_getAssociatedObject(self,@selector(placeholderLabel));
    if(!placeholderLB){
        placeholderLB = [[UILabel alloc] init];
        placeholderLB.numberOfLines = 0;
        placeholderLB.textColor = [UIColor lightGrayColor];
        objc_setAssociatedObject(self, @selector(placeholderLabel), placeholderLB, OBJC_ASSOCIATION_RETAIN);
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updatePlaceHolder)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:self];
    }
    return placeholderLB;
}

-(UIColor *)placeholderColor{
    return self.placeholderLabel.textColor;
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    self.placeholderLabel.textColor = placeholderColor;
}

-(NSString *)placeholder{
    return objc_getAssociatedObject(self, kPlaceholderAssociateKey);
}

-(void)setPlaceholder:(NSString *)placeholder{
    objc_setAssociatedObject(self, kPlaceholderAssociateKey, placeholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updatePlaceHolder];
}

#pragma -mark 更新
-(void)updatePlaceHolder{
    if(self.text.length){
        [self.placeholderLabel removeFromSuperview];
        return;
    }
    self.placeholderLabel.font = self.font?self.font:self.fontDefault;
    self.placeholderLabel.textAlignment = self.textAlignment;
    self.placeholderLabel.text = self.placeholder;
    [self insertSubview:self.placeholderLabel atIndex:0];
}

#pragma -mark 默认字体
- (UIFont *)fontDefault{
    static UIFont *font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UITextView *textview = [[UITextView alloc] init];
        textview.text = @" ";
        font = textview.font;
    });
    return font;
}

@end
