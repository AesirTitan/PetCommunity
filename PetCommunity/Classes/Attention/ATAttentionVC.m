//
//  ATAttentionVC.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-16.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "ATAttentionVC.h"
#import "CameraTableView.h"
#import "ATNetworkManager.h"
#import "SearchViewController.h"
#import "ATNetworkManager.h"


@interface ATAttentionVC ()
// table view
@property (strong, nonatomic) CameraTableView *tableView;


@end

@implementation ATAttentionVC

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
    
    self.atNavigationView = [ATNavigationView viewWithBarTintColor:atColor.theme height:64 title:@"关注"];
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
    
    self.tableView = [CameraTableView tableViewWithFrame:CGRectWithTopAndBottomMargin(64, 49) isFollowed:YES];
    [self.view addSubview:self.tableView];
    
}

@end
