//
//  BTModuleManager.m
//  BTRouteDemo
//
//  Created by Brooks on 2018/8/1.
//  Copyright © 2018年 Brooks. All rights reserved.
//


#import <DeepLinkKit/DPLMutableDeepLink.h>
#import "BTModuleManager.h"
#import "BTModule.h"
#import "BTModulesConfiguration.h"
#import "BTURLRouter.h"


@interface BTModuleManager ()

@property (nonatomic, strong) BTModulesConfiguration *modulesConfiguration;

@end

@implementation BTModuleManager

static NSString *const configuration = @"modules";

+ (BTModuleManager *)sharedInstance {
    static dispatch_once_t once;
    static BTModuleManager *sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (BOOL)registerModulesFromConfigurations {
    if (!self.modulesConfiguration) {
        return NO;
    }
    
    for (BTModule *module in self.modulesConfiguration.modules) {
        // 注册自定义路由
        for (NSString *route in module.routes) {
            [BTURLRouter registerHandler:module.routeHandlerClazz forRoute:route];
            
            // 注册防干扰路由
            if ([route hasPrefix:@"bt"]) {
                NSString *anotherRoute = [route stringByReplacingOccurrencesOfString:@"bt" withString:@"abc"];
                [BTURLRouter registerHandler:module.routeHandlerClazz forRoute:anotherRoute];
            }
        }
        
        // 注册应用内路由
        [BTURLRouter registerHandler:module.routeHandlerClazz forRoute:module.inAppRoute];
    }
    
    return YES;
}

- (BTModule *)moduleForModuleId:(NSString *)moduleId {
    if (!moduleId || moduleId.length == 0) return nil;
    
    if (!self.modulesConfiguration || !self.modulesConfiguration.modules) return nil;
    
    for (BTModule *module in self.modulesConfiguration.modules) {
        if ([moduleId isEqualToString:module.id]) {
            return module;
        }
    }
    
    return nil;
}

- (BOOL)navigateToModule:(NSString *)moduleId {
    return [self navigateToModule:moduleId withParameters:nil];
}

- (BOOL)navigateToModule:(NSString *)moduleId withParameters:(NSDictionary *)parameters {
    if (!moduleId || moduleId.length == 0) {
        return NO;
    }
    
    BTModule *module = [self moduleForModuleId:moduleId];
    
    if (!module || !module.inAppRoute) {
        return NO;
    }
    
    DPLMutableDeepLink *deepLink = [[DPLMutableDeepLink alloc] initWithString:module.inAppRoute];
    [deepLink.queryParameters addEntriesFromDictionary:parameters];
    
    return [BTURLRouter handleUrl:deepLink.URL];
}

#pragma mark - private methods

- (BTModulesConfiguration *)modulesConfiguration {
    if (!_modulesConfiguration) {
        _modulesConfiguration = [self readModulesConfigurationFromJSON];
    }
    
    return _modulesConfiguration;
}

- (BTModulesConfiguration *)readModulesConfigurationFromJSON {
    BTModulesConfiguration *modulesConfiguration;
    NSError *error = nil;
    
#ifdef DEBUG
    NSString *path = [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent:@"modules.json"];
#else
    NSString *path = [[NSBundle mainBundle] pathForResource:configuration ofType:@"json"];
#endif
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    modulesConfiguration = [[BTModulesConfiguration alloc] initWithData:data error:&error];
    
#ifdef DEBUG
    NSAssert(modulesConfiguration, @"modules configuration cannot loaded.");
#endif
    
    if (error || !modulesConfiguration) {
        NSLog(@"Module error: %@", error);
    }
    
    return modulesConfiguration;
}

@end

