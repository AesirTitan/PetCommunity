//
//  SelectionHeader.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-16.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "SelectionHeader.h"
#import "ATCarouselView+Creator.h"

#import "HYBNetworking.h"
#import <MJExtension/MJExtension.h>

#import "WebViewController.h"
#import "HeaderModel.h"

#define cachePath @"headerCache".cachePath

@interface SelectionHeader ()

// banner
@property (strong, nonatomic) ATCarouselView *carousel;

// model
@property (strong, nonatomic) NSArray *datas;

// urls
@property (strong, nonatomic) NSMutableArray<NSString *> *URLs;

// titles
@property (strong, nonatomic) NSMutableArray<NSString *> *titles;

// contents
@property (strong, nonatomic) NSMutableArray<NSString *> *contents;

@end

@implementation SelectionHeader


+ (instancetype)headerWithHeight:(CGFloat)height {
    return [[self alloc] initWithHeight:height];
}

- (instancetype)initWithHeight:(CGFloat)height {
    if (self = [super initWithFrame:CGRectMake(0, 0, kScreenW, height)]) {
        [self loadData];
    }
    return self;
}


- (void)loadData{
    NSString *url = @"http://api.momoangel.com/v1/focus";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"data"] = @"";
    param[@"seqnum"] = @"GMCAMERAIOS01471330161686384";
    param[@"uid"] = @"0";
    param[@"token"] = @"";
    param[@"ver"] = @"1.0";
    
    // load cache data
    [self loadDataWith:cachePath.readArray];
    
    [HYBNetworking postWithUrl:url params:param success:^(id response) {
        // data
        NSDictionary *responseDict = response;
        NSArray *data = responseDict[@"data"];
        self.datas = data;
        
        // load data
        [self loadDataWith:data];
        
        // save cache
        cachePath.savePlist(data);
        
        
    } fail:^(NSError *error) {
        ATLogError(error);
    }];
    
    
}

- (void)loadDataWith:(NSArray *)data{
    [self.URLs removeAllObjects];
    [self.titles removeAllObjects];
    [self.contents removeAllObjects];
    for (NSDictionary *dict in data) {
        [self.URLs addObject:dict[@"image"]];
        [self.titles addObject:dict[@"title"]];
        [self.contents addObject:dict[@"info"][@"content_id"]];
    }
    // main thread main queue update UI
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setupBanner];
    });
}


// setup banner
- (void)setupBanner{
    if (self.URLs.count) {
        if (self.carousel) {
            [self.carousel removeFromSuperview];
        }
        // init and add to superview
        self.carousel = [ATCarouselView carouselWithView:self imageURLs:self.URLs titles:self.titles action:^(NSUInteger index) {
            WebViewController *vc = [WebViewController webViewWithURLString:self.contents[index]];
            [self.controller.navigationController pushViewController:vc animated:YES];
        }];
    }
    
}


- (NSMutableArray<NSString *> *)URLs{
    if (!_URLs) {
        // create it
        _URLs = [NSMutableArray array];
        // do something...
        
    }
    return _URLs;
}

- (NSMutableArray<NSString *> *)titles{
    if (!_titles) {
        // create it
        _titles = [NSMutableArray array];
        // do something...
        
    }
    return _titles;
}

- (NSMutableArray<NSString *> *)contents{
    if (!_contents) {
        // create it
        _contents = [NSMutableArray array];
        // do something...
        
    }
    return _contents;
}


@end
