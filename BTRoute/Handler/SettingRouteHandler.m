//
//  SettingRouteHandler.m
//  BTRouteDemo
//
//  Created by Brooks on 2018/8/1.
//  Copyright © 2018年 Brooks. All rights reserved.
//
#import "SettingRouteHandler.h"
#import "SettingVC.h"


@implementation SettingRouteHandler

- (UIViewController <DPLTargetViewController> *)targetViewController {
    SettingVC *targetViewController = [[SettingVC alloc] init];

    return targetViewController;
}

@end
