//
//  BTURLRouter.h
//  BTRouteDemo
//
//  路由管理器
//
//  Created by Brooks on 2018/8/1.
//  Copyright © 2018年 Brooks. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * URL 格式规范:
 * <scheme>://<host>/<path-component>?[key1=value1&key2=value2]
 * 具体实现参考:
 * wiki
 */

@interface BTURLRouter : NSObject

/**
 * 根据路由规则 route 参数, 注册对应的路由处理器 routeHandler
 */
+ (void)registerHandler:(Class)routeHandler forRoute:(NSString *)route;

/**
 * 外部路由分发, 用于 Push 和 浏览器调用
 */
+ (BOOL)handleRemoteUrl:(NSURL *)url;

/**
 * 内部路由分发
 */
+ (BOOL)handleUrl:(NSURL *)url;

@end

