//
//  UIViewController+TabBarButton.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-18.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "UIViewController+TabBarButton.h"
#import "ATTabBar.h"

static NSMutableArray *tabBarButtons;

@implementation UIViewController (TabBarButton) 


- (void)at_tabBarButtonDoubleTapped:(void (^)())action{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tabBarButtons = self.tabBarController.tabBar.subviews.mutableCopy;
        for (UIView *tmp in tabBarButtons) {
            if (tmp.class != NSClassFromString(@"UITabBarButton")){
                [tabBarButtons removeObject:tmp];
            }
        }
    });
    
    NSUInteger selectedIndex = self.tabBarController.selectedIndex;
    if (selectedIndex >= tabBarButtons.count) {
        selectedIndex = 0;
    }
    
    
    ATTabBar *tabbar = (ATTabBar *)self.tabBarController.tabBar;
    NSArray<UIViewController *> *viewControllers = self.tabBarController.viewControllers;
    NSUInteger controllerIndex = [viewControllers indexOfObject:self];
    
    
    [tabbar.didDoubleTapped subscribeNext:^(id x) {
        if ([x integerValue]-1 == controllerIndex) {
            if (action) {
                action();
            }
        }

    }];
    
}


@end
