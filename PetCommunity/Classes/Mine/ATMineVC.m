//
//  ATMineVC.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-16.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "ATMineVC.h"
#import "ATNetworkManager.h"
#import "UserModel.h"
#import "SearchViewController.h"
#import "MineHeader.h"
#import "MineTableView.h"



static CGFloat height_header = 120;

@interface ATMineVC ()

// header
@property (strong, nonatomic) MineHeader *header;
// talbe view
@property (strong, nonatomic) MineTableView *tableView;

@end

@implementation ATMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setupTableView];
    [self setupHeaderView];
    [self setupNavigationBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self loadUserData];
}

// setup navigationBar
- (void)setupNavigationBar{
    
    self.atNavigationView = [ATNavigationView viewWithBarTintColor:atColor.theme height:64 title:@"我的"];
    self.atNavigationView.layer.shadowOpacity = 0;
    [self.view addSubview:self.atNavigationView];
    
}

- (void)setupHeaderView{
    
    self.header = [[NSBundle mainBundle] loadNibNamed:@"MineHeader" owner:nil options:nil][0];
    self.header.frame = CGRectMake(0, 64, kScreenW, height_header);
    [self.view addSubview:self.header];
    self.header.user = loginUser;
    
}

- (void)setupTableView{
    
    self.tableView = [MineTableView tableViewWithFrame:CGRectMake(0, 64+height_header, kScreenW, kScreenH - self.header.bottom)];
    [self.view addSubview:[[UIView alloc] init]];
    [self.view addSubview:self.tableView];
    
}


/*
- (void)loadUserData{
    // load data and stop refresh
    
    NSMutableDictionary *param = paramWithDefaultUser()
    .appendGuid(@"0D37FCAA-3DD4-4CEA-B8AA-D3292C500E04")
    .append(@"targetuser_id",kLoginUser)
    .appendTokenCipher(@"a4a8c77ed17ce269d4b8069dd169ea4ad7577384ad86d40dcce4d2383ec81d871eddb402ad81d27984d3214f2f82fa9fd92cd2b3c9b4c5288ffdcbb012cb3002");
    
    [HYBNetworking postWithUrl:URLWith(kURLUserDetail) params:param success:^(id response) {
        
        if ([response[@"code"] integerValue] == 200) {
            // data
            NSDictionary *responseDict = response;
            NSDictionary *tag = responseDict[@"tag"];
            NSDictionary *source = tag[@"source"];
            self.user = [UserSource mj_objectWithKeyValues:source];
            
            // save cache
            cachePath.savePlist(source);
            // main thread main queue update UI
            dispatch_async(dispatch_get_main_queue(), ^{
                self.header.user = self.user;
            });
            
            
        } else{
            ATLogOBJ(response);
        }
        
    } fail:^(NSError *error) {
        ATLogResultErrorInfo(error);
    }];

}
*/


@end
