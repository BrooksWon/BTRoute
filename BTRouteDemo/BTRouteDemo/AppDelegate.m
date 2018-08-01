//
//  AppDelegate.m
//  BTRouteDemo
//
//  Created by Brooks on 2018/8/1.
//  Copyright © 2018年 Brooks. All rights reserved.
//

#import "AppDelegate.h"
#import "BTModuleManager.h"
#import "IndexVC.h"
#import "UserVC.h"
#import "WebVC.h"
#import "SettingVC.h"
#import "BTURLRouter.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] init];
    
    [[BTModuleManager sharedInstance] registerModulesFromConfigurations];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController: [IndexVC new]];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [BTURLRouter handleRemoteUrl:url];
}




@end
