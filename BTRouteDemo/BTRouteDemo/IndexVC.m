//
//  IndexVC.m
//  BTRouteDemo
//
//  Created by Brooks on 2018/8/1.
//  Copyright © 2018年 Brooks. All rights reserved.
//

#import "IndexVC.h"
#import "BTModuleManager.h"
#import "ConstModule.h"
#import "ConstRoute.h"
#import "BTURLRouter.h"

@interface IndexVC ()

@end

@implementation IndexVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
}
- (IBAction)btnAction:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            [[BTModuleManager sharedInstance] navigateToModule:kModuleUser];
            break;
        case 2:
        {
             //方式1
//            [[BTModuleManager sharedInstance] navigateToModule:kModuleWeb withParameters:@{kRouteKeyTitle:@"世界上最大的同性恋网站", kRouteKeyURL:@"https://github.com/"}];

            //方式2, 只是这种方式没办法设置title
            [BTURLRouter handleUrl:[NSURL URLWithString:@"https://github.com/"]];
            
            break;
        }
        case 3:
            [[BTModuleManager sharedInstance] navigateToModule:kModuleSetting];
            break;
        default:
            break;
    }
}

- (void)configureWithDeepLink:(DPLDeepLink *)deepLink {
    
}

@end
