//
//  ATBaseNavigationController.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-16.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "ATBaseNavigationController.h"
// base
#import "UINavigationController+BaseVC.h"
// bar
#import "ATNavigationBar.h"

@interface ATBaseNavigationController ()
// navigation bar
@property (strong, nonatomic) ATNavigationBar *atNavigationBar;

@end

@implementation ATBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self at_setupBarStyle:ATBarStyleTintOpaque tintColor:atColor.theme];
    self.atNavigationBar = [ATNavigationBar barWithBarTintColor:atColor.theme];
    [self at_setupNavigationBar:self.atNavigationBar];
    
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.shadowRadius = 3.0f;
    self.view.layer.shadowOffset = CGSizeMake(0, 0);
    self.view.layer.shadowOpacity = 0.7f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
