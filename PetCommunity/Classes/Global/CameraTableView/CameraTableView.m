//
//  CameraTableView.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-29.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "CameraTableView.h"
#import "ATNetworkManager.h"
#import "ATRealmManager.h"
#import "CamerFrameModel.h"
#import "SelectionHeader.h"
#import "CameraTableViewCell.h"


@interface CameraTableView ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

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

// followed
@property (assign, nonatomic) BOOL isFollowed;

@end

@implementation CameraTableView



+ (instancetype)tableViewWithFrame:(CGRect)frame isFollowed:(BOOL)followed {
    return [[self alloc] initWithFrame:frame isFollowed:followed];
}

- (instancetype)initWithFrame:(CGRect)frame isFollowed:(BOOL)followed {
    if (self = [super initWithFrame:frame]) {
        self.isFollowed = followed;
        self.page = 0;
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
        self.page = 0;
        [self.dataList removeAllObjects];
        [self.cachedData removeAllObjects];
        [self loadDataFromBundle];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self loadDataFromBundle];
    }];
    [self loadDataFromBundle];
    
}


- (void)loadDataFromBundle{
    
    if (self.isFollowed) {
        [self.dataList addObjectsFromArray:[ATRealmManager hotCamerasWithRange:NSMakeRange(10*self.page, 10)]];
    } else{
        [self.dataList addObjectsFromArray:[ATRealmManager hotCamerasWithRange:NSMakeRange(10*self.page, 10)]];
    }
    
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
}

/*
- (void)loadDataFromJson{
    ///Users/Aesir/Aesir\ Titan/Titan\ Studio/Project\ PetCommunity/APIs/LocalData/Hot/1.json
    [self.cachedData removeAllObjects];
    [self.tableView.mj_header endRefreshing];
    for (int i=1; i<=6; i++) {
        NSString *path = [NSString stringWithFormat:@"/Users/Aesir/Aesir Titan/Titan Studio/Project PetCommunity/APIs/LocalData/Hot/%d.json",i];
        NSDictionary *tag = path.readJson[@"tag"];
        NSArray *sources = tag[@"source"];
        
        self.dataList = [CameraSource mj_objectArrayWithKeyValuesArray:sources];
        
        // save cache
        [self.cachedData addObjectsFromArray:sources];
        cachePath.savePlist(self.cachedData);
        // main thread main queue update UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }
    
}
*/

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

- (NSMutableArray *)cachedData{
    if (!_cachedData) {
        // create it
        _cachedData = [NSMutableArray array];
        // do something...
        
    }
    return _cachedData;
}

- (NSMutableArray<CameraSource *> *)dataList{
    if (!_dataList) {
        // create it
        _dataList = [NSMutableArray array];
        
        // load data
//        NSArray *response = self.path.mainBundlePath.readArray;
//        [_dataList addObjectsFromArray:[CameraSource mj_objectArrayWithKeyValuesArray:response]];
//        [ATRealmManager cacheHotCameras:_dataList];
    }
    return _dataList;
}

- (NSMutableArray<CamerFrameModel *> *)frameDataList{
    if (!_frameDataList) {
        // create it
        _frameDataList = [NSMutableArray array];
        // do something...
        
    }
    if (self.dataList.count != _frameDataList.count) {
        [_frameDataList removeAllObjects];
        for (CameraSource *model in self.dataList) {
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
    return self.dataList.count;
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
