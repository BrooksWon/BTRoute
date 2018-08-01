//
//  BTModuleManager.h
//  BTRouteDemo
//
//  模块管理器
//  Created by Brooks on 2018/8/1.
//  Copyright © 2018年 Brooks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTModuleManager.h"

@class DPLDeepLink;
@class BTModule;

@interface BTModuleManager : NSObject

+ (instancetype)sharedInstance;

- (BOOL)registerModulesFromConfigurations;

- (BTModule *)moduleForModuleId:(NSString *)moduleId;

- (BOOL)navigateToModule:(NSString *)moduleId;

- (BOOL)navigateToModule:(NSString *)moduleId withParameters:(NSDictionary *)parameters;

@end
