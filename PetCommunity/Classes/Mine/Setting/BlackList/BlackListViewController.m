//
//  BlackListViewController.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-30.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "BlackListViewController.h"

@interface BlackListViewController ()

@end

@implementation BlackListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setupNavigationBar];
    [self setupPlaceholder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// setup navigationBar
- (void)setupNavigationBar{
    self.navigationItem.title = @"黑名单";
}


@end
