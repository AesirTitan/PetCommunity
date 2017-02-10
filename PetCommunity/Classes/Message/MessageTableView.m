//
//  MessageTableView.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-05.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "MessageTableView.h"
#import "UITableView+Creator.h"
#import "MessageTableViewCell.h"
#import "MessageModel.h"
#import "ATNetworkManager.h"

static NSString *kMessageTableViewCell = @"MessageTableViewCell";

@interface MessageTableView () <UITableViewDataSource, UITableViewDelegate>

// table view
@property (strong, nonatomic) UITableView *tableView;

// message list
@property (strong, nonatomic) NSMutableArray<ChatModel *> *messageList;

@end

@implementation MessageTableView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupTableView];
    }
    return self;
}


// setup table view
- (void)setupTableView{
    // init and add to superview
    self.tableView = [UITableView at_tableViewWithView:self frame:self.bounds style:UITableViewStylePlain registerNibForCellReuseIdentifier:kMessageTableViewCell];
    // style
    self.tableView.rowHeight = 65;
    
}



- (NSMutableArray<ChatModel *> *)messageList{
    if (!_messageList) {
        // create it
        _messageList = [NSMutableArray array];
        // do something...
        
        [self loadMessages];
        
    }
    return _messageList;
}

- (void)addRandomMessage {
    
    if (self.messageList.count) {
        // get chat model
        NSUInteger index = (NSUInteger)arc4random_uniform((int)self.messageList.count);
        [RLMUser transactionWithBlock:^{
            ChatModel *model = self.messageList[index];
            // add new messages
            [model addMessage];
        }];
        // reload
        [self at_delay:0.2 performInMainQueue:^(id  _Nonnull obj) {
            [self reload];
        }];
    }
    
    
}

- (void)reload{
    [self.messageList removeAllObjects];
    [self loadMessages];
    [self.tableView reloadData];
    [self updateBadge];
}


- (void)loadMessages{
    self.messageList = [ATRealmManager messagesList];
}

- (void)updateBadge{
    NSUInteger count = 0;
    for (ChatModel *chat in self.messageList) {
        count += chat.unreadCount;
    }
    if (count) {
        self.controller.tabBarItem.badgeValue = NSStringFromNSUInteger(count);
    } else {
        self.controller.tabBarItem.badgeValue = nil;
    }
}

#pragma mark - table view data source

// number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

// number of rows in section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messageList.count;
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // dequeue reusable cell with reuse identifier
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMessageTableViewCell];
    // do something
    cell.model = self.messageList[indexPath.row];
    // return cell
    return cell;
}

// commit editing style
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    // will delete
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // remove cache
        [ATRealmManager deleteChat:self.messageList[indexPath.row]];
        // NSMutableArray remove object at index
        [self.messageList removeObjectAtIndex:indexPath.row];
        // table view delete rows at index path
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self reload];
    }
}


#pragma mark table view delegate

// did select row
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // deselect row
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // do something
    
}





@end
