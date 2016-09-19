//
//  CameraTableView.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-29.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraModel.h"


@interface CameraTableView : UIView

// table view
@property (strong, nonatomic) UITableView *tableView;

// list
@property (strong, nonatomic) NSMutableArray<CameraSource *> *dataList;

// scroll
@property (copy, nonatomic) void (^scrollViewWillBeginDragging)();

+ (instancetype)tableViewWithFrame:(CGRect)frame URL:(NSString *)url parameter:(void (^)(NSMutableDictionary *dictWithDefaultUser))parameter;

+ (instancetype)tableViewWithFrame:(CGRect)frame URL:(NSString *)URL;


- (void)loadNewData;
- (void)loadMoreData;
- (void)scrollToTop;


@end
