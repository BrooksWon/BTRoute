//
//  WebViewRouteHandler.m
//  BTRouteDemo
//
//  Created by Brooks on 2018/8/1.
//  Copyright © 2018年 Brooks. All rights reserved.
//

#import "WebViewRouteHandler.h"
#import "ConstRoute.h"
#import "WebVC.h"

@implementation WebViewRouteHandler

- (BOOL)shouldHandleDeepLink:(DPLDeepLink *)deepLink {
    if ([super shouldHandleDeepLink:deepLink]) {
        NSString *url = deepLink[kRouteKeyURL];

        return url && url.length > 0;
    }

    return NO;
}

- (UIViewController <DPLTargetViewController> *)targetViewController {
    WebVC *targetViewController = [[WebVC alloc] init];

    return targetViewController;
}

@end
