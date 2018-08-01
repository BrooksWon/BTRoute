//
//  AuthenticationRouteHandler.m
//  BTRouteDemo
//
//  Created by Brooks on 2018/8/1.
//  Copyright © 2018年 Brooks. All rights reserved.
//

#import <DeepLinkKit/DeepLinkKit.h>
#import "AuthenticationRouteHandler.h"
#import "UserData.h"
#import "BTModuleManager.h"
#import "ConstRoute.h"
#import "ConstModule.h"


@implementation AuthenticationRouteHandler

- (BOOL)shouldHandleDeepLink:(DPLDeepLink *)deepLink {
    if ([UserData loginToken].length > 0) {
        return [super shouldHandleDeepLink:deepLink];
    }

    // 验证未成功, 跳转到登录页面
    // 登录成功之后, 通过 bt_callback_url 和 bt_callback_parameters 参数跳回来
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[kRouteKeyCallbackURL] = [deepLink.URL absoluteString];

    [[BTModuleManager sharedInstance] navigateToModule:kModuleLogin withParameters:parameters];

    return NO;
}

@end
