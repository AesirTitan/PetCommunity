//
//  AttentionTableView.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-27.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "AttentionTableView.h"
#import "ATNetworkManager.h"
#import "CameraModel.h"

#define cachePath @"attention".cachePath

@interface AttentionTableView ()

// table view
@property (strong, nonatomic) UITableView *tableView;

// list
@property (strong, nonatomic) NSMutableArray<CameraSource *> *dataList;

// page
@property (assign, nonatomic) NSUInteger page;


@end

@implementation AttentionTableView


- (void)loadData{
    
    NSString *url = @"http://chongzaiquan.jingchang.tv/jpet/api.php/Camera/getCameraForCameraList/";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"channel_id"] = @"";
    param[@"guid"] = @"DA5372A9-5089-4343-8174-B713DFEC984A";
    param[@"pi"] = [NSString stringWithFormat:@"%ld",self.page];
    param[@"token_cipher"] = @"43801e4420f70fe98f3260b712a94be21cb79e5927ad55abfb0dcf6398b277e1e388c0adf3af0c84d1d94bc8c88e1afbec3b90f029ae3abe16ce92a7bbc2a18c";
    param[@"type"] = @"hot";
    param[@"user_id"] = @"307935";
    
    [self loadDataWith:cachePath.readArray];
    
    [HYBNetworking postWithUrl:url params:param success:^(id response) {
        // data
        NSDictionary *responseDict = response;
        NSDictionary *tag = responseDict[@"tag"];
        NSArray *sources = tag[@"source"];
        if (self.page == 1) {
            [self.dataList removeAllObjects];
        }
        
        // load data
        [self loadDataWith:sources];
        // save cache
        cachePath.savePlist(sources);
        
        // end refresh
        if (sources.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        
        
    } fail:^(NSError *error) {
        ATLogError(error);
    }];
    
    
}

- (void)loadDataWith:(NSArray *)data{
    [self.dataList removeAllObjects];
    for (NSDictionary *dict in data) {
        CameraSource *source = [CameraSource mj_objectWithKeyValues:dict];
        [self.dataList addObject:source];
    }
    // main thread main queue update UI
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}


@end
