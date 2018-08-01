//
//  BTModule.h
//  BTRouteDemo
//
//  模块组件
//  Created by Brooks on 2018/8/1.
//  Copyright © 2018年 Brooks. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol BTModule
@end

@interface BTModule : JSONModel <BTModule>

/**
 * 模块 ID
 */
@property (nonatomic, copy) NSString *id;

/**
 * 模块名称
 */
@property (nonatomic, copy) NSString *name;

/**
 * 模块支持的路由列表
 */
@property (nonatomic, strong) NSArray <Optional> *routes;

/**
 * 模块路由处理器名称
 */
@property (nonatomic, copy) NSString <Optional> *routeHandlerClassName;

/**
 * 判断模块定义的 routes 和应用内路由是否能处理传入的 URL
 */
- (BOOL)canHandleURL:(NSURL *)url;

/**
 * 获取 routeHandler 类, 前置处理 route 路由, 指定 target 和 展现方式
 */
- (Class)routeHandlerClazz;

/**
 * 获取应用内路由, 直接采用 bt://:id 方式, 区分大小写
 * 应用内路由, 不设置 Path Components, 传入参数均通过 queryParameters 传递
 * 参数获取方面, 均通过 `deepLink[@"param"]` 方式获取
 */
- (NSString *)inAppRoute;

@end
