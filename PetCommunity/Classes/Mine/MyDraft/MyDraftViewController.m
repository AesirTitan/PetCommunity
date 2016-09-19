//
//  MyDraftViewController.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-30.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "MyDraftViewController.h"

@interface MyDraftViewController ()

@end

@implementation MyDraftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = atColor.background;
    [self setupNavigationBar];
    [self setupPlaceholder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// setup navigationBar
- (void)setupNavigationBar{
    self.navigationItem.title = @"草稿";
}


@end
