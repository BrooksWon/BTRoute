//
//  UIWindow+PazLabs.m
//  RenRenChe
//
//  Created by codingman on 15/6/3.
//  Copyright (c) 2015年 RenRenChe Inc. All rights reserved.
//

#import "UIWindow+PazLabs.h"


@implementation UIWindow (PazLabs)

- (UIViewController *)visibleViewController {
    UIViewController *rootViewController = self.rootViewController;
    return [UIWindow getVisibleViewControllerFrom:rootViewController];
}

+ (UIViewController *)getVisibleViewControllerFrom:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [UIWindow getVisibleViewControllerFrom:[((UINavigationController *) vc) topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [UIWindow getVisibleViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    } else {
        return vc;
    }
}

@end
