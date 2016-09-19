//
//  ATBaseViewController.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-16.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "ATBaseViewController.h"
// base
#import "UIViewController+BaseVC.h"


@interface ATBaseViewController ()

@end

@implementation ATBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = atColor.background;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.navigationItem.backBarButtonItem.title = @"返回";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self at_autoEnableGeature];
    
    [self at_autoHideNavigationBar];
    
    [self clearTitle];
    
}


- (UIImageView *)setupPlaceholder{
    // placeholder
    UIImageView *placeholder = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image_noPet"]];
    placeholder.height = 120;
    placeholder.width = 120;
    placeholder.centerX = kScreenCenterX;
    placeholder.centerY = kScreenCenterY;
    [self.view addSubview:placeholder];
    return placeholder;
}


- (void)clearTitle{
    NSUInteger count = self.navigationController.viewControllers.count;
    if (count>=2) {
        if ([self.navigationController.viewControllers[count-2].navigationItem.title isEqualToString:self.navigationItem.title]) {
            self.navigationItem.title = @"";
        }
    }
    
}

@end
