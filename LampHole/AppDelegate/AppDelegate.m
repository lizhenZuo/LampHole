//
//  AppDelegate.m
//  LampHole
//
//  Created by dingdong on 2019/12/18.
//  Copyright © 2019 dingdong. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Window.h"
#import "HomeTabbarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //设置主屏
    self.window = [DDAppWindow shareAppWindow];
    self.window.backgroundColor = [UIColor whiteColor];
    [self startRootViewController:self.window];
//    [self startHomeViewController:self.window];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
