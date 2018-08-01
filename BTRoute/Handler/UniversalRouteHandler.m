//
//  UniversalRouteHandler.m
//  BTRouteDemo
//
//  Created by Brooks on 2018/8/1.
//  Copyright © 2018年 Brooks. All rights reserved.
//

#import "UniversalRouteHandler.h"
#import "UIWindow+PazLabs.h"

@implementation UniversalRouteHandler

- (BOOL)shouldHandleDeepLink:(DPLDeepLink *)deepLink {
    return YES;
}

- (BOOL)preferToTargetViewControllerInNavigationController {
    return NO;
}

- (BOOL)preferToReplaceTargetViewControllerInNavigationController {
    return NO;
}

// 返回当前 ViewController 所处的 navigationController, 通过 pushViewController 方式实现页面跳转
- (UIViewController *)viewControllerForPresentingDeepLink:(DPLDeepLink *)deepLink {
    return [[UIApplication sharedApplication].keyWindow visibleViewController].navigationController;
}

- (void)presentTargetViewController:(UIViewController <DPLTargetViewController> *)targetViewController
                   inViewController:(UIViewController *)presentingViewController {

    // 重用堆栈里已有的同类型 ViewController 实例
    if (self.preferToTargetViewControllerInNavigationController && [presentingViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *) presentingViewController;
        for (UIViewController *viewController in navigationController.viewControllers) {
            if ([viewController isMemberOfClass:[targetViewController class]]) {
                targetViewController = (UIViewController <DPLTargetViewController> *)viewController;
                [targetViewController configureWithDeepLink:self.deepLink];
                break;
            }
        }
    }

    [self willPresentTargetViewController:targetViewController inViewController:presentingViewController];

    if ([self preferModalPresentation] || ![presentingViewController isKindOfClass:[UINavigationController class]]) {

        [presentingViewController presentViewController:targetViewController animated:YES completion:^{
            [self didPresentTargetViewController:targetViewController inViewController:presentingViewController];
        }];
    } else if ([presentingViewController isKindOfClass:[UINavigationController class]]) {

        [self placeTargetViewController:targetViewController inNavigationController:(UINavigationController *) presentingViewController];

        [self didPresentTargetViewController:targetViewController inViewController:presentingViewController];
    }
}

- (void)willPresentTargetViewController:(UIViewController <DPLTargetViewController> *)targetViewController
                      inViewController:(UIViewController *)presentingViewController {

    // 如果上一次是 present 方式展现的 ViewController, 则提前 dismiss 当前的 ViewController #895
    if (presentingViewController.presentedViewController) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 200 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
            [presentingViewController.presentedViewController dismissViewControllerAnimated:NO completion:nil];
        });
    }

    return;
}

- (void)didPresentTargetViewController:(UIViewController <DPLTargetViewController> *)targetViewController
                      inViewController:(UIViewController *)presentingViewController {
    return;
}


#pragma mark - Private

- (void)placeTargetViewController:(UIViewController *)targetViewController
           inNavigationController:(UINavigationController *)navigationController {

    if ([navigationController.viewControllers containsObject:targetViewController]) {
        [navigationController popToViewController:targetViewController animated:YES];
    } else {
        // 替换当前堆栈里已有的同类型的 ViewController 实例
        if (self.preferToReplaceTargetViewControllerInNavigationController) {
            NSMutableArray *stackViewControllers = [[NSMutableArray alloc] init];

            for (UIViewController *controller in navigationController.viewControllers) {
                if (![controller isMemberOfClass:[targetViewController class]]) {
                    [stackViewControllers addObject:controller];
                }
            }

            if ([stackViewControllers count] != [navigationController.viewControllers count]) {
                [navigationController setViewControllers:stackViewControllers animated:NO];
            }
        }

        if (![navigationController.topViewController isEqual:targetViewController]) {
            [navigationController pushViewController:targetViewController animated:YES];
        }
    }
}

@end
