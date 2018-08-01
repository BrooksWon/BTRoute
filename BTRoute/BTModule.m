//
//  BTModule.m
//  BTRouteDemo
//
//  Created by Brooks on 2018/8/1.
//  Copyright © 2018年 Brooks. All rights reserved.
//

#import <DeepLinkKit/DPLDeepLink.h>
#import <DeepLinkKit/DPLRouteHandler.h>
#import <DeepLinkKit/DPLRouteMatcher.h>
#import "BTModule.h"


@implementation BTModule

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"routeHandlerClassName": @"handler"
                                                                  }];
}

- (BOOL)canHandleURL:(NSURL *)url {
    if (!url)
        return NO;
    
    DPLRouteMatcher *routeMatcher;
    
    routeMatcher = [DPLRouteMatcher matcherWithRoute:self.inAppRoute];
    if ([routeMatcher deepLinkWithURL:url]) {
        return YES;
    }
    
    for (NSString *route in self.routes) {
        routeMatcher = [DPLRouteMatcher matcherWithRoute:route];
        
        if ([routeMatcher deepLinkWithURL:url]) {
            return YES;
        }
        
        // 识别防干扰路由
        if ([url.scheme isEqualToString:@"abc"]) {
            NSString *anotherRoute = [route stringByReplacingOccurrencesOfString:@"bt" withString:@"abc"];
            routeMatcher = [DPLRouteMatcher matcherWithRoute:anotherRoute];
            
            if ([routeMatcher deepLinkWithURL:url]) {
                return YES;
            }
        }
    }
    
    return NO;
}

- (Class)routeHandlerClazz {
    if (self.routeHandlerClassName) {
        // 优先判断是否存在自定义 RouteHandler
        Class customRouteHandlerClazz = NSClassFromString(self.routeHandlerClassName);
        
        if (customRouteHandlerClazz && [customRouteHandlerClazz isSubclassOfClass:[DPLRouteHandler class]]) {
            return customRouteHandlerClazz;
        }
    }
    
    if (self.id) {
        Class routeHandlerClazz = NSClassFromString(self.id);
        if (routeHandlerClazz && [routeHandlerClazz isSubclassOfClass:[DPLRouteHandler class]]) {
            return routeHandlerClazz;
        }
    }
    
    return nil;
}

- (NSString *)inAppRoute {
    if (!self.id) {
        return nil;
    }
    
//    return [NSString stringWithFormat:@"bt://%@", [self.id lowercaseString]];
    return [NSString stringWithFormat:@"bt://%@", self.id];

}

@end
