//
//  DDDialogWindow.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2019/2/26.
//  Copyright © 2019 ddkt365. All rights reserved.
//

#import "DDAppWindow.h"

@interface DDAppWindow()
@end

@implementation DDAppWindow

+ (instancetype)shareAppWindow{
    static id _this = nil;
    static dispatch_once_t onceTokenInit;
    dispatch_once(&onceTokenInit, ^{
        _this = [[self.class alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    return _this;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

/**
 添加弹窗
 @param dialog DDBaseDialog
 */
-(void)addDialog:(DDBaseDialog *)dialog{
    NSMutableArray<DDBaseDialog *> *array = [NSMutableArray new];
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:DDBaseDialog.class]){
            [array addObject:obj];
        }
    }];
    
    NSUInteger level = dialog.dialogLevel;;
    //是否插入了视图
    __block BOOL insertDialog = NO;
    @weakify(self);
    [array enumerateObjectsUsingBlock:^(DDBaseDialog  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        if (level >= obj.dialogLevel) {
            NSUInteger nextIndex = idx+1;
            if (nextIndex < array.count) {
                DDBaseDialog *nextDialog = [array objectAtIndex:nextIndex];
                if (level < nextDialog.dialogLevel) {
                    [self insertSubview:dialog aboveSubview:obj];
                    *stop = insertDialog = YES;
                }
            }
        }else{
            [self insertSubview:dialog belowSubview:obj];
            *stop = insertDialog = YES;
        }
    }];
    //如果为插入视图
    if (!insertDialog) {
        [self addSubview:dialog];
    }
}


@end
