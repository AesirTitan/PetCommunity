//
//  SettingViewController.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-30.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableView.h"

@interface SettingViewController ()

// table view
@property (strong, nonatomic) SettingTableView *tableView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigationBar];
    [self setupTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// setup navigationBar
- (void)setupNavigationBar{
    self.navigationItem.title = @"设置";
}

- (void)setupTableView{
    
    self.tableView = [[SettingTableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    
    
}

    



@end
