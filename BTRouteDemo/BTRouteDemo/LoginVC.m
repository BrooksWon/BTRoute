//
//  LoginVC.m
//  BTRouteDemo
//
//  Created by Brooks on 2018/8/1.
//  Copyright © 2018年 Brooks. All rights reserved.
//

#import "LoginVC.h"
#import "ConstRoute.h"
#import "BTURLRouter.h"
#import "BTModuleManager.h"
#import "UserData.h"

@interface LoginVC ()

@property (nonatomic, copy) NSString *callbackURLString;
@property (nonatomic, strong) NSDictionary *callbackParameters;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"登陆";
}
- (IBAction)loginButtonAction:(id)sender {
    // 模拟登陆
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:^{
            if (self.callbackURLString) {
//                [BTURLRouter handleUrl:[NSURL URLWithString:self.callbackURLString]];
                [UserData savaLoginToken:@"token"];
                NSURL *url = [NSURL URLWithString:self.callbackURLString];
                [[BTModuleManager sharedInstance] navigateToModule:url.host withParameters:@{@"name":@"Brooks", @"age":@"18"}];
            }
        }];
    });
}

- (void)configureWithDeepLink:(DPLDeepLink *)deepLink {
    if (deepLink) {
        self.callbackURLString = deepLink[kRouteKeyCallbackURL];
        self.callbackParameters = deepLink[kRouteKeyCallbackParameters];
    }
}

@end
