//
//  UserRouteHandler.m
//  BTRouteDemo
//
//  Created by Brooks on 2018/8/1.
//  Copyright © 2018年 Brooks. All rights reserved.
//

#import "UserRouteHandler.h"
#import "UserVC.h"

@implementation UserRouteHandler

- (UIViewController <DPLTargetViewController> *)targetViewController {
    UserVC *targetViewController = [[UserVC alloc] init];
    
    return targetViewController;
}

@end
