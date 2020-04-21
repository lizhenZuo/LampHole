//
//  DDTapView.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/8/28.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "DDTapView.h"

@implementation DDTapView

-(void)addSender:(DDNoParamsBlock)block{
    [self setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        if (block) {
            block();
        }
    }];
    [self addGestureRecognizer:tapgesture];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.alpha = 0.7;
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   self.alpha = 1;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.alpha = 1;
}


@end
