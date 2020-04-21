//
//  SSLUserListView.h
//  LampHole
//
//  Created by dingdong on 2020/1/5.
//  Copyright © 2020 dingdong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSLUserListView : UIView

+ (SSLUserListView *)shareView;

- (void)showUserListView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
