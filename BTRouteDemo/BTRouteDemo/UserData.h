//
//  UserData.h
//  BTRouteDemo
//
//  Created by Brooks on 2018/8/1.
//  Copyright © 2018年 Brooks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject

/**
 获取用户登陆token
*/
+ (NSString *)loginToken;

/**
 保存用户登陆token
 */
+ (void)savaLoginToken:(NSString*)token;
@end
