//
//  UserProfileViewController.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-31.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UserHeader.h"
#import "PetTableView.h"
#import "AlbumTableView.h"
#import "ATNetworkManager.h"
#import "ATMaterialButton+Creator.h"
#import "ChatViewController.h"
#import "ChatModel.h"

@interface UserProfileViewController () <UIScrollViewDelegate>

// scorll view
@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIView *tableView;
// header
@property (strong, nonatomic) UserHeader *header;
// pet
@property (strong, nonatomic) PetTableView *petView;
// album
@property (strong, nonatomic) AlbumTableView *albumView;
// follow
@property (strong, nonatomic) ATMaterialButton *follow;
// chat
@property (strong, nonatomic) ATMaterialButton *chat;

@end

@implementation UserProfileViewController


- (instancetype)initWithCameraUser:(CameraUser *)cameraUser {
    if (self = [super init]) {
        self.cameraUser = cameraUser;
        
    }
    return self;
}

- (instancetype)initWithUser:(UserSource *)user {
    if (self = [super init]) {
        self.user = user;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self _initUI];
    [self loadPetTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (![self.user.nickname isEqualToString:loginUser.nickname]) {
//        userCachePath(self.user.nickname).saveArchivedPlist(self.user);
    }
}



// init UI
- (void)_initUI{
    
    // title
    if (self.user.nickname){
        self.navigationItem.title = self.user.nickname;
    } else{
        self.navigationItem.title = @"用户详情";
    }
    [self.scrollView addSubview:self.header];
    [self.scrollView addSubview:self.tableView];
    // button
    if (![loginUser.nickname isEqualToString:self.user.nickname]) {
        [self setupButton];
    }
    // segmented
    [self.header.segmented addTarget:self action:@selector(tab:) forControlEvents:UIControlEventValueChanged];
    
}



// setup table view
- (void)loadPetTableView{
//    self.tableView = self.petView;
    [self.albumView removeFromSuperview];
    [self.tableView addSubview: self.petView];
    
    [self.petView.tableView reloadData];
    
}
// setup table view
- (void)loadAlbumTableView{
//    self.tableView = self.albumView;
    [self.petView removeFromSuperview];
    [self.tableView addSubview: self.albumView];
    
    [self.albumView.tableView reloadData];
    
}

- (UserSource *)user{
    if (!_user) {
        // create it
        _user = [ATRealmManager userWithName:self.cameraUser.nickname];
        // do something...
        if (!_user) {
            _user = [UserSource randomUser];
            _user.nickname = self.cameraUser.nickname;
            _user.image = self.cameraUser.image;
            _user.is_follow = NSStringFromNSUInteger(self.cameraUser.is_follow);
            [ATRealmManager cacheUser:_user];
        }
    }
    return _user;
}

- (void)setCameraUser:(CameraUser *)cameraUser{
    _cameraUser = cameraUser;
    self.header.cameraUser = cameraUser;
    [self.header updateUI];
}

- (PetTableView *)petView{
    if (!_petView) {
        // create it
        _petView = [[PetTableView alloc] initWithFrame:self.tableView.bounds];
        // do something...
        
    }
    return _petView;
}

- (AlbumTableView *)albumView{
    if (!_albumView) {
        // create it
        _albumView = [[AlbumTableView alloc] initWithFrame:self.tableView.bounds];
        // do something...

    }
    return _albumView;
}

- (UserHeader *)header{
    if (!_header) {
        // create it
        _header = [[NSBundle mainBundle] loadNibNamed:@"UserHeader" owner:nil options:nil][0];
        // do something...
        _header.top = 64;
        _header.user = self.user;
    }
    return _header;
}

- (UIView *)tableView{
    if (!_tableView) {
        // create it
        _tableView = [[UIView alloc] initWithFrame:CGRectMake(0, self.header.bottom, self.view.width, self.view.bottom - self.header.bottom)];
        // do something...
        
    }
    return _tableView;
}

- (void)tab:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        [self loadPetTableView];
    } else if (sender.selectedSegmentIndex == 1){
        [self loadAlbumTableView];
    }
    
}


// setup button
- (void)setupButton{
    // init and add to superview
    [self.view addSubview:self.follow];
    [self.view addSubview:self.chat];
    self.follow.clipsToBounds = YES;
    self.chat.clipsToBounds = YES;
    self.follow.width = self.chat.width = 0.5 * kScreenW - 0.4;
    self.follow.height = self.chat.height = 40;
    self.follow.bottom = self.chat.bottom = self.view.height;
    self.follow.left = 0;
    self.chat.right = self.view.width;
    
    // followed
    if (self.user.is_follow.integerValue == 1) {
        self.follow.selected = YES;
    }
    // unfollowed
    else{
        self.follow.selected = NO;
    }
    
    
}

- (ATMaterialButton *)follow{
    if (!_follow) {
        // create it
        _follow = [ATMaterialButton buttonWithImage:@"icon_follow" title:@"关注" action:^(UIButton *sender) {
            _follow.selected = !_follow.selected;
            [ATRealmManager user:self.user setFollow:_follow.selected];
        }];
        [_follow setTitle:@"已关注" forState:UIControlStateSelected];
        [_follow setImage:[UIImage imageNamed:@"icon_followed"] forState:UIControlStateSelected];
    }
    return _follow;
}

- (ATMaterialButton *)chat{
    if (!_chat) {
        // create it
        _chat = [ATMaterialButton buttonWithImage:@"icon_chat" title:@"私信" action:^(UIButton *sender) {
            NSUInteger count = self.navigationController.viewControllers.count;
            if ([self.navigationController.viewControllers[count-2] isKindOfClass:[ChatViewController class]]) {
                [self.navigationController popViewControllerAnimated:YES];
            } else{
                ChatModel *chat = [ATRealmManager chatWithUser:self.user];
                if (!chat) {
                    chat = [ChatModel new];
                    chat.user = self.user;
                    [ATRealmManager addNewChat:chat];
                }
                ChatViewController *vc = [[ChatViewController alloc] initWithChatModel:chat];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }];
    }
    return _chat;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        // create it
        [self.view addSubview:[[UIView alloc] init]];
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview: _scrollView];
        // style
        self.scrollView.delegate = self;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.contentSize = CGSizeMake(0, kScreenH + 250);
        self.scrollView.scrollEnabled = YES;
    }
    return _scrollView;
}





@end
