//
//  ATRootController.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-16.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "ATRootController.h"
// drawer view controller gesture
#import <ATKit/ATDrawerController.h>
// child
#import "ATBaseNavigationController.h"
#import "ATBaseTabBarController.h"
#import "ATLeftViewController.h"

@interface ATRootController ()

@property (strong, nonatomic) ATBaseTabBarController *tabbarVC;
// nav
@property (strong, nonatomic) ATBaseNavigationController *mainVC;
// left
@property (strong, nonatomic) ATLeftViewController *drawerVC;

@end

@implementation ATRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupControllers];
    
    [self at_setupMainVC:self.mainVC drawerVC:self.drawerVC enable:NO];
    
    [self setupNotificationCenter];
    
    [self setupLaunch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

// setup controllers
- (void)setupControllers{
    // init and add to superview
    self.tabbarVC = [[ATBaseTabBarController alloc] init];
    self.mainVC = [[ATBaseNavigationController alloc] initWithRootViewController:self.tabbarVC];
    self.drawerVC = [[ATLeftViewController alloc] init];
    
}


// setup launch
- (void)setupLaunch{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIImageView *launch = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        launch.image = [UIImage imageNamed:@"image_launch"];
        launch.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:launch];
        UIView *mask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        mask.centerX = kScreenCenterX;
        mask.centerY = 180;
        mask.layer.at_maskToCircle();
        mask.backgroundColor = atColor.white;
        self.view.maskView = mask;
        [UIView animateWithDuration:2.4 delay:0.1 usingSpringWithDamping:1 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            launch.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(0, 80), 2, 2);
            launch.alpha = 0;
            mask.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(0, -240), 9, 9);
        } completion:^(BOOL finished) {
            [launch removeFromSuperview];
            [self.view.maskView removeFromSuperview];
            self.view.maskView = nil;
        }];
        
    });
}


// setup notification center
- (void)setupNotificationCenter{
    // init and add to superview
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"upload" object:nil] subscribeNext:^(NSNotification *x) {
        
        [ATProgressHUD at_target:self.view showInfo:[NSString stringWithFormat:@"%@",x.object] duration:1];
    }];
    // style
    
}



@end
