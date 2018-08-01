//
//  UserData.m
//  BTRouteDemo
//
//  Created by Brooks on 2018/8/1.
//  Copyright © 2018年 Brooks. All rights reserved.
//

#import "UserData.h"

@implementation UserData
+ (NSString *)loginToken {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"loginToken"];
}

+ (void)savaLoginToken:(NSString*)token {
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"loginToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
