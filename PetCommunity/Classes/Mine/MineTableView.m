//
//  MineTableView.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-29.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "MineTableView.h"
#import "ATNetworkManager.h"
#import "UITableView+Creator.h"
#import "MineTableViewCell.h"
#import "MineModel.h"
#import "PushDetailVC.h"

#define modelPath [[NSBundle mainBundle] pathForResource:@"MineModel" ofType:@"plist"]
static NSString *reuseId = @"MineTableViewCell";
@interface MineTableView () <UITableViewDataSource, UITableViewDelegate>

// table view
@property (strong, nonatomic) UITableView *tableView;

// mine data list
@property (strong, nonatomic) NSMutableArray<NSArray<MineModel *> *> *dataList;

@end

@implementation MineTableView


+ (instancetype)tableViewWithFrame:(CGRect)frame {
    return [[self alloc] initWithFrame:frame];
}

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
    
    self.dataList = [MineModel mj_objectArrayWithFile:modelPath];
    
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
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    // do something
    cell.model = self.dataList[indexPath.section][indexPath.row];
    // return cell
    return cell;
}


#pragma mark table view delegate

// did select row
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // deselect row
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // do something
    [PushDetailVC mineVC:self.controller pushViewControllerWithIndexPath:indexPath];
}




@end
