//
//  DDBaseMJTableView.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/7.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>

@class DDBaseMJTableView;
@protocol DDBaseMJTableViewDelegate<NSObject>

@optional
/**
 上拉刷新
 @param currentPageNo 当前页
 */
-(void)pullUp:(int)currentPageNo tableView:(DDBaseMJTableView *)tableView;


/**
 下拉刷新
 @param currentPageNo 当前页
 */
-(void)pullDown:(int)currentPageNo tableView:(DDBaseMJTableView *)tableView;
@end


typedef NS_ENUM(NSUInteger, DDTableRefreshType) {
    DDTableRefreshTypeNormal = 1,
    DDTableRefreshTypeGIF = 2,
};


@interface DDBaseMJTableView : UITableView
/**
 *  当前页数
 */
@property (nonatomic,assign) int currentPageNo;

/**
 *  设置是否可以下拉刷新
 */
@property (assign, nonatomic) BOOL headerViewEnable;

/**
 *  设置是否可以上拉刷新
 */
@property (assign, nonatomic) BOOL footerViewEnable;

/**
 *  是否正在下拉刷新
 */
@property (assign, nonatomic, readonly, getter=isHeaderRefreshing) BOOL headerRefreshing;

/**
 *  是否正在上拉刷新
 */
@property (assign, nonatomic, readonly, getter=isFooterRefreshing) BOOL footerRefreshing;

/**
 *  刷新代理
 */
@property (weak, nonatomic) id<DDBaseMJTableViewDelegate> refreshDelegate;

/**
 注册header 刷新视图
 */
-(void)registeRefreshHeaderType:(DDTableRefreshType)refreshHeaderType;

/**
 *  下拉刷新
 */
-(void)beginRefreshingHeader;

/**
 *  上拉刷新
 */
-(void)beginRefreshingFooter;

/**
 *  下拉停止刷新
 */
-(void)endRefreshingHeader;

/**
 *  上拉停止刷新
 */
-(void)endRefreshingFooter;
@end
