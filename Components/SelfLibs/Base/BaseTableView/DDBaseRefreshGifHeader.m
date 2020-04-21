//
//  DDBaseRefreshGifHeader.m
//  EasyLife
//
//  Created by occ on 2016/12/5.
//  Copyright © 2016年 CCJ. All rights reserved.
//

#import "DDBaseRefreshGifHeader.h"

@implementation DDBaseRefreshGifHeader

- (void)prepare{
    [super prepare];
    //设置 giftView坐标
    //时间 更新状态
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
    // 设置普通状态的动画图片
    NSMutableArray<UIImage *> *idleImages = [NSMutableArray new];
    for (int index = 0; index < 20; index++) {
        NSString *imagename = [NSString stringWithFormat:@"icon_gif_loading_%d",index];
        UIImage *image = [UIImage imageNamed:imagename];
        if (image) {
            [idleImages addObject:image];
        }else{
            break;
        }
    }
    if (idleImages == nil || idleImages.count == 0) {
        NSAssert(false, @"首页的GIF不能空..");
    }
    self.size = CGSizeMake(kScreenWidth, idleImages.firstObject.size.height+20);
    CGFloat duration = idleImages.count*0.08;
    [self setImages:idleImages duration:duration forState:MJRefreshStateIdle];
    [self setImages:idleImages duration:duration forState:MJRefreshStatePulling];
    [self setImages:idleImages duration:duration forState:MJRefreshStateRefreshing];
    // 初始化文字
    [self setTitle:@"" forState:MJRefreshStateIdle];
    [self setTitle:@"" forState:MJRefreshStatePulling];
    [self setTitle:@"" forState:MJRefreshStateRefreshing];
}

@end
