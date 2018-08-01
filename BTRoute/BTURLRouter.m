//
//  BTURLRouter.m
//  BTRouteDemo
//
//  Created by Brooks on 2018/8/1.
//  Copyright © 2018年 Brooks. All rights reserved.
//

#import <DeepLinkKit/DeepLinkKit.h>
#import "BTURLRouter.h"
#import "BTModuleManager.h"
#import "ConstRoute.h"
#import "ConstModule.h"

@interface BTURLRouter ()

@property (nonatomic, strong) DPLDeepLinkRouter *dplRouter;

@end

@implementation BTURLRouter

+ (BTURLRouter *)sharedInstance {
    static dispatch_once_t once;
    static BTURLRouter *shareInstance;
    dispatch_once(&once, ^{
        shareInstance = [[self alloc] init];
        shareInstance.dplRouter = [[DPLDeepLinkRouter alloc] init];
    });
    
    return shareInstance;
}

+ (BOOL)handleRemoteUrl:(NSURL *)url {
    return [self handleUrl:url];
}

// 这个方法处理的情况包含 Safari 打开 URL, 推送 URL, 以及内部路由跳转
+ (BOOL)handleUrl:(NSURL *)url {
    if (!url)
        return NO;
    
    // 对于 Web 链接特殊处理
    if ([url.scheme isEqualToString:@"http"] || [url.scheme isEqualToString:@"https"]) {
        return [[BTModuleManager sharedInstance] navigateToModule:kModuleWeb withParameters:@{
                                                                                               kRouteKeyURL : [url.absoluteString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] ?: @"",
                                                                                               }];
    }
    
    // 对于 tel 链接特殊处理
    if ([url.scheme isEqualToString:@"tel"]) {
        return [[UIApplication sharedApplication] openURL:url];
    }
    
    // 内部链接跳转对应模块
    BOOL canHandle = [[BTURLRouter sharedInstance].dplRouter handleURL:url withCompletion:^(BOOL handled, NSError *error) {
        if (handled && ![url.host isEqualToString:@"credential"]) { // 忽略 credential 后台路由跳转
            //通过Router跳转时，用于立即隐藏或不显示闪屏页。比如推送消息，内部Router跳转，但除去bt://credential
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationHandleURLCompleted" object:url];
        }
    }];
    
    return canHandle;
}

+ (void)registerHandler:(Class)routeHandler forRoute:(NSString *)route {
    if (!route || route.length == 0 || !routeHandler)
        return;
    
    [BTURLRouter sharedInstance].dplRouter[route] = routeHandler;
}

@end

