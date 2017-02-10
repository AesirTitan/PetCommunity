//
//  ATBaseTabBarController.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-16.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "ATBaseTabBarController.h"
#import "ATNetworkManager.h"
#import "ChatModel.h"
// base
#import "UITabBarController+BaseVC.h"
// tabbar
#import "ATTabBar.h"
// child
#import "ATSelectionVC.h"
#import "ATAttentionVC.h"
#import "ATMessageVC.h"
#import "ATMineVC.h"

#import "UploadPickerView.h"

@interface ATBaseTabBarController ()

// tabbar
@property (strong, nonatomic) ATTabBar *atTabBar;

// ATSelectionVC
@property (strong, nonatomic) ATSelectionVC *selectionVC;
// ATAttentionVC
@property (strong, nonatomic) ATAttentionVC *attentionVC;
// ATRecommendVC
@property (strong, nonatomic) ATMessageVC *messageVC;
// ATMineVC
@property (strong, nonatomic) ATMineVC *mineVC;


// center button
@property (strong, nonatomic) UIButton *centerButton;

// upload view
@property (strong, nonatomic) UploadPickerView *uploadView;

@end

@implementation ATBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self at_setupBarStyle:ATBarStyleWhiteOpaque tintColor:atColor.theme];
    
    [self setupControllers];
    
    [self at_setupTabBar:self.atTabBar];
    
    [self setupNotification];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

// setup controllers
- (void)setupControllers{
    
    self.selectionVC = [[ATSelectionVC alloc] init];
    self.attentionVC = [[ATAttentionVC alloc] init];
    self.messageVC = [[ATMessageVC alloc] init];
    self.mineVC = [[ATMineVC alloc] init];
    
    
    [self at_setupChlidController:self.selectionVC title:@"精选" image:@"tabbar_selection" selectedImage:@"tabbar_selection_HL"];
    [self at_setupChlidController:self.attentionVC title:@"关注" image:@"tabbar_attention" selectedImage:@"tabbar_attention_HL"];
    [self at_setupChlidController:self.messageVC title:@"消息" image:@"tabbar_message" selectedImage:@"tabbar_message_HL"];
    [self at_setupChlidController:self.mineVC title:@"我的" image:@"tabbar_mine" selectedImage:@"tabbar_mine_HL"];
    
}

- (ATTabBar *)atTabBar{
    if (!_atTabBar) {
        // create it
        _atTabBar = [ATTabBar barWithAnimationMode:ATTabBarAnimationModeReversal centerButton:self.centerButton action:^{
            [self showUploadView];
            
        }];
    }
    
    return _atTabBar;
}

- (UIButton *)centerButton{
    if (!_centerButton) {
        // create it
        _centerButton = [[UIButton alloc] init];
        // do something...
        [_centerButton setImage:[UIImage imageNamed:@"icon_plus"] forState:UIControlStateNormal];
        [_centerButton setImage:[UIImage imageNamed:@"icon_plus"] forState:UIControlStateHighlighted];
        
    }
    return _centerButton;
}

- (void)showUploadView{
    
    // upload view
    UploadPickerView *view = [[NSBundle mainBundle] loadNibNamed:@"UploadPickerView" owner:nil options:nil][0];
    view.top = kScreenH - view.height;
    [self.view addSubview:view];
    self.uploadView = view;
    
    [view tappedCancel:^{
        
    }];
    
    [view tappedAlbumView:^{
        
    }];
    
    [view tappedPhotoView:^{
        
    }];
    
    [view tappedVideoView:^{
        
    }];
    
    
}

// setup notification
- (void)setupNotification{
    // init and add to superview
//    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kNotiReceiveMessage object:nil] subscribeNext:^(id x) {
//        NSArray<NSString *> *messagePaths = @"Message".cachePath.subpaths(@"plist");
//        NSUInteger count = 0;
//        for (NSString *path in messagePaths) {
//            ChatModel *chat = path.readArchivedPlist;
//            if (!chat.user.nickname.length) {
//                chat.user.nickname = @"未知用户";
//            }
//            chat.messages = chat.messages;
//            if (!chat.messages) {
//                chat.messages = [NSMutableArray array];
//                [chat.messages insertObject:[MessageModel randomTextMessageToMe] atIndex:0];
//            }
//            count += chat.unreadCount;
//        }
//        if (count) {
//            self.messageVC.tabBarItem.badgeValue = NSStringFromNSUInteger(count);
//        }
//    }];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:kNotiReceiveMessage object:nil];
    
}

@end
