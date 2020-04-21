//
//  SSLSettingView.h
//  LampHole
//
//  Created by dingdong on 2020/1/5.
//  Copyright © 2020 dingdong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSLSettingView : UIView

+ (SSLSettingView *)shareSettingView;

- (void)showSettingView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
