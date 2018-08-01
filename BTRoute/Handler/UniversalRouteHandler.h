//
//  UniversalRouteHandler.h
//  BTRouteDemo
//
//  Created by Brooks on 2018/8/1.
//  Copyright © 2018年 Brooks. All rights reserved.
//



#import <DeepLinkKit/DPLRouteHandler.h>


@interface UniversalRouteHandler : DPLRouteHandler

@property (nonatomic, strong) DPLDeepLink *deepLink;

/**
 * 当 preferModalPresentation = NO 时
 * 优先取 UINavigationController.viewControllers 已包含的 targetViewController 相同类型的 UIViewController 实例
 * 如果存在，则 Pop 到获取到的 targetViewController
 * 如果不存在，则调用 targetViewController 方法创建新实例，直接 Push
 */
@property (nonatomic, assign) BOOL preferToTargetViewControllerInNavigationController;

/**
 * 在 Push targetViewController 之前
 * 移除 UINavigationController.viewControllers 已包含的 targetViewController 相同类型的 UIViewController 实例
 */
@property (nonatomic, assign) BOOL preferToReplaceTargetViewControllerInNavigationController;


/**
 * 增加 present 接收回调接口
 */
- (void)willPresentTargetViewController:(UIViewController <DPLTargetViewController> *)targetViewController
                      inViewController:(UIViewController *)presentingViewController;

/**
 * 增加 present 接收回调接口
 */
- (void)didPresentTargetViewController:(UIViewController <DPLTargetViewController> *)targetViewController
                       inViewController:(UIViewController *)presentingViewController;

@end
