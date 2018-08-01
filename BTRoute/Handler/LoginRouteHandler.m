//
//  LoginRouteHandler.m
//  BTRouteDemo
//
//  Created by Brooks on 2018/8/1.
//  Copyright © 2018年 Brooks. All rights reserved.
//

#import "LoginRouteHandler.h"
#import "LoginVC.h"

@implementation LoginRouteHandler
- (BOOL)preferModalPresentation {
    return YES;
}
- (UIViewController <DPLTargetViewController> *)targetViewController {
    LoginVC *targetViewController = [[LoginVC alloc] init];
    
    
    return targetViewController;
}


@end
