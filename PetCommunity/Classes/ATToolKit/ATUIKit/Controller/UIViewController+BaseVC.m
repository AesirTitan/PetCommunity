//
//  UIViewController+BaseVC.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-19.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "UIViewController+BaseVC.h"
#import <ATKit/ATDrawerController.h>

@implementation UIViewController (BaseVC)

- (void)at_autoEnableGeature{
    if (self.navigationController.viewControllers.count == 1) {
        // root view controller
        self.enableGesture = YES;
    } else{
        // not root view controller
        self.enableGesture = NO;
    }
}

// InTabBarControllerRootViewController
- (void)at_autoHideNavigationBar{
    if (self.navigationController.viewControllers.count == 1) {
        // root view controller
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    } else{
        // not root view controller
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}



@end
