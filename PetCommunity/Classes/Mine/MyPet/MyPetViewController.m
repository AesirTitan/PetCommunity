//
//  MyPetViewController.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-30.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "MyPetViewController.h"
#import "PetTableView.h"
#import "TableFooterButton.h"

@interface MyPetViewController ()

// table view
@property (strong, nonatomic) PetTableView *tableView;

@end

@implementation MyPetViewController

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
    self.navigationItem.title = @"我的萌宠";
}

// setup table view
- (void)setupTableView{
    // init and add to superview
    self.tableView = [[PetTableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    self.tableView.tableView.tableFooterView = [TableFooterButton buttonViewTintColor:atColor.theme title:@"添加宠物" action:^(UIButton *sender) {
        atMarkSelfView;
    }];
}




@end
