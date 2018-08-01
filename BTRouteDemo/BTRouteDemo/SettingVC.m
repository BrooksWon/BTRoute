//
//  SettingVC.m
//  BTRouteDemo
//
//  Created by Brooks on 2018/8/1.
//  Copyright © 2018年 Brooks. All rights reserved.
//

#import "SettingVC.h"
#import "BTModuleManager.h"
#import "ConstModule.h"
#import "BTURLRouter.h"


@interface SettingVC ()

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置";
}

- (IBAction)btnAction:(id)sender {
//    [[BTModuleManager sharedInstance] navigateToModule:kModuleIndex];
//    [BTURLRouter handleUrl:[NSURL URLWithString:@"bt://index"]];
    [BTURLRouter handleUrl:[NSURL URLWithString:@"bt://home"]];
}



- (void)configureWithDeepLink:(DPLDeepLink *)deepLink {
    
}

@end
