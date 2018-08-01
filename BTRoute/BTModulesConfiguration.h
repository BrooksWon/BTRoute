//
//  BTModulesConfiguration.h
//  BTRouteDemo
//
//  模块配置类
//  Created by Brooks on 2018/8/1.
//  Copyright © 2018年 Brooks. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol BTModule;


@interface BTModulesConfiguration : JSONModel

@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSArray <BTModule> *modules;

@end
