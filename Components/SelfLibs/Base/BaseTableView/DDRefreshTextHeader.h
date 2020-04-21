//
//  DDRefreshTextHeader.h
//  AiTeacheriPhone
//
//  Created by eason yin on 2018/9/18.
//  Copyright © 2018年 ddkt365. All rights reserved.
//

#ifndef DDRefreshTextHeader_h
#define DDRefreshTextHeader_h

/** header 文本*/
static NSString *const DDHeaderMJRefreshStateIdle = @"松开立即刷新";
static NSString *const DDHeaderMJRefreshStatePulling = @"下拉可以刷新";
static NSString *const DDHeaderMJRefreshStateRefreshing = @"正在刷新数据中...";

/** footer 文本*/
static NSString *const DDFooterMJRefreshStateIdle = @"";
static NSString *const DDFooterMJRefreshStatePulling = @"上拉加载更多";
static NSString *const DDFooterMJRefreshStateRefreshing = @"正在努力加载中...";
static NSString *const DDFooterMJRefreshStateNoMoreData = @"加载完毕，没有更多数据";


#endif /* DDRefreshTextHeader_h */
