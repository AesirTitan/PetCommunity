//
//  SettingTableView.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-30.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "SettingTableView.h"

#import "SettingTableViewCell.h"
#import "SettingFooter.h"
#import "TableFooterButton.h"

#import "PushDetailVC.h"

static NSString *reuseId = @"SettingTableViewCell";

@interface SettingTableView () <UITableViewDataSource, UITableViewDelegate>

// table view
@property (strong, nonatomic) UITableView *tableView;

// data list
@property (strong, nonatomic) NSArray<NSArray<NSString *> *> *dataList;

@end

@implementation SettingTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = atColor.groupTableViewBackground;
        
        [self setupTableView];
    }
    return self;
}



// setup table view
- (void)setupTableView{
    // init and add to superview
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
    [self addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    // style
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 16)];
    self.tableView.sectionHeaderHeight = 8;
    self.tableView.sectionFooterHeight = 8;
    self.tableView.rowHeight = 46;
    
    
    self.tableView.tableFooterView = [TableFooterButton buttonViewTintColor:[UIColor md_red] title:@"退出登录" action:^(UIButton *sender) {
        atMarkSelf;
    }];
    
}





- (NSArray<NSArray<NSString *> *> *)dataList{
    if (!_dataList) {
        // create it
        _dataList = @[@[@"黑名单",@"意见反馈",@"修改密码"],@[@"版本信息",@"服务协议",@"关于"]];
        // do something...
        
    }
    return _dataList;
}



#pragma mark - table view data source

// number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}

// number of rows in section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList[section].count;
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // dequeue reusable cell with reuse identifier
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[SettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    // do something
    cell.textLabel.text = self.dataList[indexPath.section][indexPath.row];
    // return cell
    return cell;
}

#pragma mark table view delegate

// did select row
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // deselect row
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // do something
    [PushDetailVC settingVC:self.controller pushViewControllerWithIndexPath:indexPath];
}


@end
