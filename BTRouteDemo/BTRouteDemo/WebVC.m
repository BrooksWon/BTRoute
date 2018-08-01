//
//  WebVC.m
//  BTRouteDemo
//
//  Created by Brooks on 2018/8/1.
//  Copyright © 2018年 Brooks. All rights reserved.
//

#import "WebVC.h"
#import "ConstRoute.h"
#import <DeepLinkKit/NSString+DPLQuery.h>

@interface WebVC ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonnull, nonatomic, copy) NSString *url;
@end

@implementation WebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}


#pragma delegate 

- (void)configureWithDeepLink:(DPLDeepLink *)deepLink {
    
    if (deepLink) {
        NSString *url = deepLink[kRouteKeyURL];
        NSString *title = deepLink[kRouteKeyTitle];
      
        // url中包含内部url，传入时需要encode，使用时必须decode
        NSString *decodedURLString = [url DPL_stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        self.url = decodedURLString;
        self.title = title;
    }
}

@end
