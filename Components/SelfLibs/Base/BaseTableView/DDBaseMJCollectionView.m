//
//  DDBaseMJCollectionView.m
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/7.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import "DDBaseMJCollectionView.h"
#import "DDRefreshTextHeader.h"

@interface DDBaseMJCollectionView()

@property (nonatomic,assign)DDCollectionRefreshType refreshHeaderType;

@end
@implementation DDBaseMJCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self _initRefreshView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initRefreshView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _initRefreshView];
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self _initRefreshView];
}

-(void)_initRefreshView {
    self.currentPageNo = 1;
    //1.初始化header
    [self setupRefreshHeaderType:DDCollectionRefreshTypeGIF];
}

/**
 注册header 刷新视图
 */
-(void)registeRefreshHeaderType:(DDCollectionRefreshType)refreshHeaderType{
    [self setupRefreshHeaderType:refreshHeaderType];
}

/**
 设置生效header
 */
-(void)setupRefreshHeaderType:(DDCollectionRefreshType)refreshHeaderType{
    self.refreshHeaderType = refreshHeaderType;
    switch (refreshHeaderType) {
        case DDCollectionRefreshTypeNormal:{
            [self stateHeaderNormal];
            break;
        }
        case DDCollectionRefreshTypeGIF:{
            [self stateHeaderGIF];
            break;
        }
        default:
            break;
    }

}

/**
 正常文本Header
 */
-(void)stateHeaderNormal{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    MJRefreshNormalHeader *stateHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    stateHeader.automaticallyChangeAlpha = YES;
    // 隐藏时间
    stateHeader.lastUpdatedTimeLabel.hidden = YES;
    // 设置文字
    [stateHeader setTitle:DDHeaderMJRefreshStateIdle forState:MJRefreshStateIdle];
    [stateHeader setTitle:DDHeaderMJRefreshStatePulling forState:MJRefreshStatePulling];
    [stateHeader setTitle:DDHeaderMJRefreshStateRefreshing forState:MJRefreshStateRefreshing];
    self.mj_header = stateHeader;
    //
    self.mj_footer = [self stateFooter];
}

/**
 Gif Header
 */
-(void)stateHeaderGIF{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    DDBaseRefreshGifHeader *stateHeader = [DDBaseRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    self.mj_header = stateHeader;
    //
    self.mj_footer = [self stateFooter];

}

-(MJRefreshFooter *)stateFooter{
    MJRefreshAutoStateFooter *stateFooter = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    [stateFooter setTitle:DDFooterMJRefreshStateIdle forState:MJRefreshStateIdle];
    [stateFooter setTitle:DDFooterMJRefreshStatePulling forState:MJRefreshStatePulling];
    [stateFooter setTitle:DDFooterMJRefreshStateRefreshing forState:MJRefreshStateRefreshing];
    [stateFooter setTitle:DDFooterMJRefreshStateNoMoreData forState:MJRefreshStateNoMoreData];
    stateFooter.onlyRefreshPerDrag = YES;
    stateFooter.hidden = YES;
    return stateFooter;
}

/**
 *  获取是否可以下拉刷新
 */
- (BOOL)headerViewEnable{
    return !self.mj_header.hidden;
}

/**
 *  设置是否可以下拉刷新
 */
- (void)setHeaderViewEnable:(BOOL)headerEnable {
    if(!headerEnable){
        [self setMj_header:nil];
    }
    self.mj_header.hidden = !headerEnable;
}

/**
 *  获取是否可以上拉刷新
 */
- (BOOL)footerViewEnable{
    return !self.mj_footer.hidden;
}

/**
 *  设置是否可以上拉刷新
 */
- (void)setFooterViewEnable:(BOOL)footerEnable{
    self.mj_footer.hidden = !footerEnable;
}


/**
 *  是否正在下拉刷新
 */
- (BOOL)isHeaderRefreshing{
    return self.mj_header.isRefreshing;
}

/**
 *  是否正在上拉刷新
 */
- (BOOL) isFooterRefreshing{
    return self.mj_footer.isRefreshing;
}

// pullDown
-(void)headerRereshing{
    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self);
        if([self.refreshDelegate respondsToSelector:@selector(pullDown:collectionView:)]){
            self.currentPageNo = 1;
            [self.refreshDelegate pullDown:self.currentPageNo collectionView:self];
        }
    });
}

//pullUp
-(void)footerRereshing{
    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self);
        if([self.refreshDelegate respondsToSelector:@selector(pullUp:collectionView:)]){
            self.currentPageNo += 1;
            [self.refreshDelegate pullUp:self.currentPageNo collectionView:self];
            self.mj_footer.automaticallyChangeAlpha = YES;
        }
    });
}

/**
 *  下拉刷新
 */
-(void)beginRefreshingHeader{
    [self.mj_header beginRefreshing];
}

/**
 *  上拉刷新
 */
-(void)beginRefreshingFooter{
    [self.mj_footer beginRefreshing];
}

/**
 *  下拉停止刷新
 */
-(void)endRefreshingHeader{
    [self.mj_header endRefreshing];
}

/**
 *  上拉停止刷新
 */
-(void)endRefreshingFooter{
    [self.mj_footer endRefreshing];
}

@end
