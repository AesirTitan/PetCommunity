//
//  UserTableView.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-01.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

@interface UserTableView : UIView

// table view
@property (strong, nonatomic) UITableView *tableView;

// list
@property (strong, nonatomic) NSMutableArray<UserSource *> *dataList;

// scroll
@property (copy, nonatomic) void (^scrollViewWillBeginDragging)();

+ (instancetype)tableViewWithFrame:(CGRect)frame URL:(NSString *)url parameter:(void (^)(NSMutableDictionary *dictWithDefaultUser))parameter;


- (void)loadNewData;
- (void)loadMoreData;
- (void)scrollToTop;


@end
