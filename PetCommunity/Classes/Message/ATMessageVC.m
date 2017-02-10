//
//  ATMessageVC.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-19.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "ATMessageVC.h"
#import "MessageTableView.h"


@interface ATMessageVC ()

// table view
@property (strong, nonatomic) MessageTableView *tableView;

// timer
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation ATMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupTableView];
    [self setupNavigationBar];
    self.view.backgroundColor = atColor.background;
    
    [self setupTabBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reload];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.timer at_pause];
}


// setup table view
- (void)setupTableView{
    // init and add to superview
    [self.view addSubview:[UIView new]];
    self.tableView = [[MessageTableView alloc] initWithFrame:CGRectWithTopAndBottomMargin(64, 49)];
    [self.view addSubview:self.tableView];
    // style
    
}


// setup navigationBar
- (void)setupNavigationBar{
    
    self.atNavigationView = [ATNavigationView viewWithBarTintColor:atColor.theme height:64 title:@"消息"];
    [self.view addSubview:self.atNavigationView];
    
    [self.atNavigationView at_rightButtonWithImage:@"icon_notification" action:^{
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
            [self.timer at_pause];
        });
        if (self.timer.at_turnover) {
            [ATProgressHUD at_target:self.view showInfo:@"开始计时" duration:1];
        } else{
            [ATProgressHUD at_target:self.view showInfo:@"停止计时" duration:1];
        }
    }];
    
    
}


// setup tab bar
- (void)setupTabBar{
    
    [self at_tabBarButtonDoubleTapped:^{
        [self.tableView reload];
    }];
    
}

- (NSTimer *)timer{
    if (!_timer) {
        // create it
        _timer = [NSTimer at_timerWithTimeInterval:1 repeats:YES usingBlock:^(NSTimer * _Nonnull timer) {
            [self.tableView addRandomMessage];
        }];
        // do something...
        
    }
    return _timer;
}




@end
