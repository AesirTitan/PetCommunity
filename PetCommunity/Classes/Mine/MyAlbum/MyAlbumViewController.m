//
//  MyAlbumViewController.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-30.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "MyAlbumViewController.h"
#import "AlbumTableView.h"
#import "TableFooterButton.h"

@interface MyAlbumViewController ()

// table view
@property (strong, nonatomic) AlbumTableView *tableView;

@end

@implementation MyAlbumViewController

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
    self.navigationItem.title = @"我的日志";
}

// setup table view
- (void)setupTableView{
    // init and add to superview
    self.tableView = [[AlbumTableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    self.tableView.tableView.tableFooterView = [TableFooterButton buttonViewTintColor:atColor.theme title:@"写日志" action:^(UIButton *sender) {
        atMarkSelfView;
    }];
    
}


@end
