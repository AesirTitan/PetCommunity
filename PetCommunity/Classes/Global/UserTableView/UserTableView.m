//
//  UserTableView.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-01.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "UserTableView.h"
#import "ATNetworkManager.h"
#import "UserTableViewCell.h"


#define cachePath self.url.lastPathComponent.cachePath

@interface UserTableView ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

// url
@property (copy, nonatomic) NSString *url;
// param
@property (strong, nonatomic) NSMutableDictionary *parameter;

// cached data
@property (strong, nonatomic) NSMutableArray *cachedData;

// page
@property (assign, nonatomic) NSUInteger page;

@end


@implementation UserTableView


+ (instancetype)tableViewWithFrame:(CGRect)frame URL:(NSString *)url parameter:(void (^)(NSMutableDictionary *dictWithDefaultUser))parameter {
    return [[self alloc] initWithFrame:frame URL:url parameter:parameter];
}

- (instancetype)initWithFrame:(CGRect)frame URL:(NSString *)url parameter:(void (^)(NSMutableDictionary *dictWithDefaultUser))parameter {
    if (self = [super initWithFrame:frame]) {
        self.url = URLWith(url);
        self.parameter = paramWithDefaultUser();
        parameter(self.parameter);
        self.page = 1;
        [self setupTableView];
    }
    return self;
}




- (void)loadNewData{
    [self.tableView.mj_header beginRefreshing];
}
- (void)loadMoreData{
    [self.tableView.mj_footer beginRefreshing];
}
- (void)scrollToTop{
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark - private methods

// setup table view
- (void)setupTableView{
    // init and add to superview
    [self addSubview:[[UIView alloc] init]];
    self.tableView = [UITableView at_tableViewWithView:self frame:self.bounds style:UITableViewStyleGrouped registerNibForCellReuseIdentifier:@"UserTableViewCell"];
    
    // style
    self.tableView.sectionHeaderHeight = 4;
    self.tableView.sectionFooterHeight = 4;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.rowHeight = 66;
    self.tableView.allowsSelection = NO;
    
    self.dataList = [UserSource mj_objectArrayWithKeyValuesArray:cachePath.readArray];
    
    [self loadData];
    
}

- (void)loadData{
    
    // load data and stop refresh
    self.parameter.appendPage(self.page);
    [HYBNetworking postWithUrl:self.url params:self.parameter success:^(id response) {
        
        if ([response[@"code"] integerValue] == 200) {
            // data
            NSDictionary *responseDict = response;
            NSDictionary *tag = responseDict[@"tag"];
            NSArray *sources = tag[@"source"];
            // load data and stop refresh
            if (self.page == 1) {
                self.dataList = [UserSource mj_objectArrayWithKeyValuesArray:sources];
                [self.cachedData removeAllObjects];
                [self.tableView.mj_header endRefreshing];
            } else{
                if (sources.count) {
                    [self.dataList addObjectsFromArray:[UserSource mj_objectArrayWithKeyValuesArray:sources]];
                    [self.tableView.mj_footer endRefreshing];
                }else{
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
            
            // save cache
            [self.cachedData addObjectsFromArray:sources];
            cachePath.savePlist(self.cachedData);
            // main thread main queue update UI
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
            
        } else{
            ATLogOBJ(response);
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
        
    } fail:^(NSError *error) {
        ATLogError(error);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}


- (NSMutableArray<UserSource *> *)dataList{
    if (!_dataList) {
        // create it
        _dataList = [NSMutableArray array];
        // do something...
    }
    return _dataList;
}

- (NSMutableArray *)cachedData{
    if (!_cachedData) {
        // create it
        _cachedData = [NSMutableArray array];
        // do something...
        
    }
    return _cachedData;
}

#pragma mark - table view data source

// number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}

// number of rows in section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // dequeue reusable cell with reuse identifier
    
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserTableViewCell"];
    // do something
    cell.model = self.dataList[indexPath.section];
    
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


#pragma mark - scroll view delegate

// will begin dragging
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.scrollViewWillBeginDragging) {
        self.scrollViewWillBeginDragging();
    }
}


@end
