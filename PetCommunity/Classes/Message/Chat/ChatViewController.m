//
//  ChatViewController.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-05.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "ChatViewController.h"
#import "ATInputBar.h"
#import "ChatTableViewCell.h"
#import "UITableView+Creator.h"
#import "MessageModel.h"
#import "ATNetworkManager.h"
#import "ATBaseTabBarController.h"
#import "AFNetworking.h"

static NSString *kChatTableViewCell = @"ChatTableViewCell";

@interface ChatViewController () <UITableViewDataSource, UITableViewDelegate>

// table view
@property (strong, nonatomic) UITableView *tableView;

// message list
@property (strong, nonatomic) NSMutableArray<MessageModel *> *messages;

// input bar
@property (strong, nonatomic) ATInputBar *inputBar;


@end

@implementation ChatViewController


- (instancetype)initWithChatModel:(ChatModel *)model {
    if (self = [super init]) {
        self.model = model;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigationBar];
    [self setupTableView];
    [self setupInputBar];
    [self setupMediaMessage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // main thread main queue update UI
    dispatch_async(dispatch_get_main_queue(), ^{
        // scroll to bottom
        [self.tableView scrollRectToVisible:self.tableView.tableFooterView.frame animated:YES];
    });
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    chatCachePath(self.model.user.nickname).saveArchivedPlist(self.model);
//    self.tableView = nil;
//    self.messages = nil;
//    self.inputBar = nil;
}

// setup navigationBar
- (void)setupNavigationBar{
    self.navigationItem.title = self.model.user.nickname;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem at_itemWithImage:[UIImage imageNamed:@"icon_more"] style:UIBarButtonItemStylePlain action:^(id  _Nonnull sender) {
        [self addRandomMessage];
        
    }];
    
}


// setup table view
- (void)setupTableView{
    // init and add to superview
    self.tableView = [UITableView at_tableViewWithTarget:self frame:CGRectWithTopAndBottomMargin(0, 49) style:UITableViewStyleGrouped registerNibForCellReuseIdentifier:kChatTableViewCell];
    self.tableView.backgroundColor = atColor.groupTableViewBackground;
    // style
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.tableHeaderView = UIViewWithHeight(16);
    self.tableView.tableFooterView = UIViewWithHeight(16);
    self.tableView.sectionHeaderHeight = 8;
    self.tableView.sectionFooterHeight = 0;
    
    [self.tableView scrollRectToVisible:self.tableView.tableFooterView.frame animated:YES];
    
}


// setup comment bar
- (void)setupInputBar{
    // init and add to superview
    self.inputBar = [[ATInputBar alloc] initWithFrame:CGRectMake(0, kScreenH-49, kScreenW, 49)];
    [self.view addSubview:self.inputBar];
    // action
    [self.inputBar inputEmoticonAction:^{
        
    }];
    [self.inputBar inputDoneAction:^(NSString *text){
        [self sendMessage:text];
    }];
    
    // resign
    [self.view at_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
        [self _endEditing];
    }];
    
    [self.inputBar adjustView:self.view];
    
}

// setup media message
- (void)setupMediaMessage{
    [self.inputBar didFinishPickAudio:^(NSURL *audio) {
        
    }];
    [self.inputBar didFinishPickImage:^(UIImage *image) {
        [self sendImage:image];
    }];
    [self.inputBar didFinishPickPhoto:^(UIImage *photo) {
        
        
    }];
    [self.inputBar didFinishPickVideo:^(NSURL *video) {
        
        
    }];
    
}




- (void)sendMessage:(NSString *)msg{
    [self.inputBar submitComment];
    MessageModel *item = [MessageModel randomTextMessageFromMe];
    item.content = msg;
    [self.messages addObject:item];
    
    [self.tableView reloadData];
    [self at_delay:0.1 performInMainQueue:^(id  _Nonnull obj) {
        [self.tableView scrollRectToVisible:self.tableView.tableFooterView.frame animated:YES];
    }];
    [self loadDataWith:msg];
}



- (void)sendImage:(UIImage *)image{
    
    // set model
    MessageModel *item = [MessageModel randomTextMessageFromMe];
    item.messageType = MessageTypeImage;
    // get image url
    // send image url
    item.image = image;
    item.content = @"[图片]";
    [self.messages addObject:item];
    
    // main thread main queue update UI
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self at_delay:0.1 performInMainQueue:^(id  _Nonnull obj) {
            // hide media picker
            [self.inputBar hideMediaPicker];
            // scroll to bottom
            [self.tableView scrollRectToVisible:self.tableView.tableFooterView.frame animated:YES];
        }];
    });
    
}


- (void)_endEditing{
    [self.inputBar.inputView resignFirstResponder];
}

- (void)receiveMessage:(NSString *)msg{
    MessageModel *message = [MessageModel randomTextMessageToMe];
    message.messageType = MessageTypeText;
    message.content = msg;
    [self.messages addObject:message];
    [self.tableView reloadData];
    [self at_delay:0.1 performInMainQueue:^(id  _Nonnull obj) {
        [self.tableView scrollRectToVisible:self.tableView.tableFooterView.frame animated:YES];
    }];
}

- (void)addRandomMessage {
    
    [self.messages addObject:[MessageModel randomTextMessageToMe]];
     
    [self.tableView reloadData];
    [self at_delay:0.1 performInMainQueue:^(id  _Nonnull obj) {
        [self.tableView scrollRectToVisible:self.tableView.tableFooterView.frame animated:YES];
    }];
    
}

- (ChatModel *)model{
    if (!_model) {
        // create it
//        _model = chatCachePath(_model.user.nickname).readArchivedPlist;
        // do something...
        if (!_model) {
            _model = [ChatModel new];
        }
    }
    return _model;
}

- (NSMutableArray<MessageModel *> *)messages{
    if (!_messages) {
        // create it
        _messages = self.model.messages;
        // do something...
        if (!_messages) {
            _messages = [NSMutableArray array];
        }
    }
    return _messages;
}


- (void)loadDataWith:(NSString *)text{
    
    
//    [HYBNetworking configCommonHttpHeaders:@{@"appkey":@"cbe2ab54a3ad6498044b7a21eb415a8e"}];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"info"] = text;
    param[@"key"] = kRobotKey;
    param[@"userid"] = kUserId;
    
    
    [HYBNetworking getWithUrl:kRobotURL params:param success:^(id response) {
        NSString *anwser = response[@"text"];
        if (anwser.length) {
            [self receiveMessage:anwser];
        }
        
    } fail:^(NSError *error) {
        ATLogError(error);
    }];
}


#pragma mark - table view data source

// number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.messages.count;
}

// number of rows in section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // dequeue reusable cell with reuse identifier
    ChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kChatTableViewCell];
    // do something
    [cell setupUser:self.model.user message:self.messages[indexPath.section]];
    // return cell
    return cell;
}

#pragma mark table view delegate

// did select row
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // deselect row
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // do something
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self _endEditing];
}


@end
