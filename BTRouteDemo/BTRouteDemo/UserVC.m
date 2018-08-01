//
//  UserVC.m
//  BTRouteDemo
//
//  Created by Brooks on 2018/8/1.
//  Copyright © 2018年 Brooks. All rights reserved.
//

#import "UserVC.h"

@interface UserVC ()

@property (nonatomic, copy) NSString *content;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation UserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户页面";
    self.contentLabel.text = self.content;
}

#pragma delegate

- (void)configureWithDeepLink:(DPLDeepLink *)deepLink {

    if (deepLink) {
        self.content = [NSString stringWithFormat:@"name:%@ age:%@", deepLink[@"name"], deepLink[@"age"]];
    }
}

@end
