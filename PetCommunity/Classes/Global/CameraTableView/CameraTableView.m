//
//  CameraTableView.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-29.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "CameraTableView.h"
#import "ATNetworkManager.h"

#import "CamerFrameModel.h"
#import "SelectionHeader.h"
#import "CameraTableViewCell.h"

#define cachePath @"getCameraForCameraList.plist".cachePath

@interface CameraTableView ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

// url
@property (copy, nonatomic) NSString *url;
// param
@property (strong, nonatomic) NSMutableDictionary *parameter;

// cached data
@property (strong, nonatomic) NSMutableArray *cachedData;

// page
@property (assign, nonatomic) NSUInteger page;
// is show header
@property (assign, nonatomic) BOOL isShowHeader;

// path
@property (copy, nonatomic) NSString *path;

// list
@property (strong, nonatomic) NSMutableArray<CamerFrameModel *> *frameDataList;

@end

@implementation CameraTableView

+ (instancetype)tableViewWithFrame:(CGRect)frame URL:(NSString *)url parameter:(void (^)(NSMutableDictionary *dictWithDefaultUser))parameter {
    return [[self alloc] initWithFrame:frame URL:url parameter:parameter];
}

- (instancetype)initWithFrame:(CGRect)frame URL:(NSString *)url parameter:(void (^)(NSMutableDictionary *dictWithDefaultUser))parameter {
    if (self = [super initWithFrame:frame]) {
        self.url = url;
        self.parameter = paramWithDefaultUser();
        parameter(self.parameter);
        self.page = 1;
        [self setupTableView];
    }
    return self;
}

+ (instancetype)tableViewWithFrame:(CGRect)frame URL:(NSString *)URL{
    return [[self alloc] initWithFrame:frame URL:URL];
}

- (instancetype)initWithFrame:(CGRect)frame URL:(NSString *)URL{
    if (self = [super initWithFrame:frame]) {
        self.path = URL;
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
    self.tableView = [UITableView at_tableViewWithView:self frame:self.bounds style:UITableViewStyleGrouped registerNibForCellReuseIdentifier:nil];
    
    // style
    self.tableView.sectionHeaderHeight = 8;
    self.tableView.sectionFooterHeight = 8;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.estimatedRowHeight = 400;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.allowsSelection = NO;
    self.tableView.scrollsToTop = YES;
    
    // refresh
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self loadDataFromBundle];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self loadDataFromBundle];
    }];
    
    
    
}

- (void)loadDataFromBundle{
    
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    if (10*self.page > self.dataList.count) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    } else{
        [self.tableView.mj_footer endRefreshing];
    }
}

/*
- (void)loadData{
 
    // load data and stop refresh
    ATLogOBJ(URLWith(kURLCameraList));
    ATLogOBJ(self.parameter);
    NSArray *arr = cachePath.readArray;
    self.dataList = [CameraSource mj_objectArrayWithKeyValuesArray:arr];
    [HYBNetworking postWithUrl:URLWith(kURLCameraList) params:self.parameter success:^(id response) {
        
        if ([response[@"code"] integerValue] == 200) {
        // data
        NSDictionary *responseDict = response;
        NSDictionary *tag = responseDict[@"tag"];
            NSArray *sources = tag[@"source"];
            // load data and stop refresh
            if (self.page == 1) {
                self.dataList = [CameraSource mj_objectArrayWithKeyValuesArray:sources];
                [self.cachedData removeAllObjects];
                [self.tableView.mj_header endRefreshing];
            } else{
                if (sources.count) {
                    [self.dataList addObjectsFromArray:[CameraSource mj_objectArrayWithKeyValuesArray:sources]];
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
        ATLogResultErrorInfo(error);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}
*/


- (NSMutableArray<CameraSource *> *)dataList{
    if (!_dataList) {
        // create it
        _dataList = [NSMutableArray array];
        
        // load data
        NSArray *response = self.path.mainBundlePath.readArray;
        
        [_dataList addObjectsFromArray:[CameraSource mj_objectArrayWithKeyValuesArray:response]];
    }
    return _dataList;
}

- (NSMutableArray<CamerFrameModel *> *)frameDataList{
    if (!_frameDataList) {
        // create it
        _frameDataList = [NSMutableArray array];
        // do something...
        // load data
        NSArray *response = self.path.mainBundlePath.readArray;
        for (NSDictionary *dict in response) {
            CameraSource *model = [CameraSource mj_objectWithKeyValues:dict];
            CamerFrameModel *frameModel = [[CamerFrameModel alloc] init];
            frameModel.model = model;
            [_frameDataList addObject:frameModel];
        }
        
    }
    return _frameDataList;
}

#pragma mark - table view data source

// number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return fmin(self.dataList.count, self.page*10);
}

// number of rows in section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // dequeue reusable cell with reuse identifier
    CameraTableViewCell *cell = [CameraTableViewCell reusableCellWithTableView:tableView];
    cell.frameModel = self.frameDataList[indexPath.section];
    
    // return cell
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.frameDataList[indexPath.section].cellHeight;
}

#pragma mark - scroll view delegate

// will begin dragging
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.scrollViewWillBeginDragging) {
        self.scrollViewWillBeginDragging();
    }
}




@end
