//
//  ATBaseViewController.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-16.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
// navigation view
#import "ATNavigationView.h"
// tabbar button
#import "UIViewController+TabBarButton.h"


@interface ATBaseViewController : UIViewController

// navigation view
@property (strong, nonatomic) ATNavigationView *atNavigationView;


- (UIImageView *)setupPlaceholder;


@end
