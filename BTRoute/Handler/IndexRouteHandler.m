//
//  IndexRouteHandler.m
//  BTRouteDemo
//
//  Created by Brooks on 2018/8/1.
//  Copyright © 2018年 Brooks. All rights reserved.
//

#import "IndexRouteHandler.h"
#import "IndexVC.h"

@implementation IndexRouteHandler
- (BOOL)preferToTargetViewControllerInNavigationController {
    return YES;
}

- (UIViewController <DPLTargetViewController> *)targetViewController {
    IndexVC *targetViewController = [[IndexVC alloc] init];
    
    return targetViewController;
}
@end
