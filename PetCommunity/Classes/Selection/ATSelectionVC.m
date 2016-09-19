//
//  ATSelectionVC.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-16.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "ATSelectionVC.h"
#import "ATNetworkManager.h"
#import "CameraTableView.h"
#import "SelectionHeader.h"
#import "SearchViewController.h"


@interface ATSelectionVC () 

// table view
@property (strong, nonatomic) CameraTableView *tableView;


@end

@implementation ATSelectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupTableView];
    [self setupNavigationBar];
    [self setupTabBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// setup navigationBar
- (void)setupNavigationBar{
    
    self.atNavigationView = [ATNavigationView viewWithBarTintColor:atColor.theme height:64 title:@"精选"];
    [self.view addSubview:self.atNavigationView];
    
    // right
    [self.atNavigationView at_rightButtonWithImage:@"icon_search" action:^{
        SearchViewController *vc =[[SearchViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.atNavigationView at_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
        [self.tableView scrollToTop];
    }];
    
}

// setup tab bar
- (void)setupTabBar{
    
    [self at_tabBarButtonDoubleTapped:^{
        [self.tableView loadNewData];
    }];
    
}

- (void)setupTableView{
   
    self.tableView = [CameraTableView tableViewWithFrame:CGRectWithTopAndBottomMargin(64, 49) URL:kURLHotCamera];
    [self.tableView.tableView registerNib:[UINib nibWithNibName:@"SectionHeader" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"SectionHeader"];
    self.tableView.tableView.tableHeaderView = [SelectionHeader headerWithHeight:180];
    [self.view addSubview:self.tableView];
    
    
}


@end
