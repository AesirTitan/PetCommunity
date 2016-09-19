//
//  AlbumTableView.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-30.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "AlbumTableView.h"
#import "UITableView+Creator.h"
#import "AlbumTableViewCell.h"

#define NIB_ALBUM @"AlbumTableViewCell"

@interface AlbumTableView () <UITableViewDataSource, UITableViewDelegate>


// pet list
@property (strong, nonatomic) NSMutableArray *cameraList;

@end


@implementation AlbumTableView



- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = atColor.groupTableViewBackground;
        [self setupTableView];
    }
    return self;
}

// setup table view
- (void)setupTableView{
    // init and add to superview
    self.tableView = [UITableView at_tableViewWithView:self frame:self.bounds style:UITableViewStylePlain registerNibForCellReuseIdentifier:NIB_ALBUM];
    
    if (self.cameraList.count) {
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 16)];
    } else{
        self.tableView.tableHeaderView = [self placeholder];
    }
    
    [self addSubview:self.tableView];
    
}


- (UIView *)placeholder{
    // placeholder
    UIImageView *placeholder = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image_noPet"]];
    placeholder.top = 20;
    placeholder.height = 120;
    placeholder.width = 120;
    placeholder.centerX = self.centerX;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 160)];
    [view addSubview:placeholder];
    return view;
}

- (NSMutableArray *)cameraList{
    if (!_cameraList) {
        // create it
        _cameraList = [NSMutableArray array];
        // do something...
        
    }
    return _cameraList;
}

#pragma mark - table view data source

// number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

// number of rows in section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cameraList.count;
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // dequeue reusable cell with reuse identifier
    AlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NIB_ALBUM];
    // do something
    //    cell.model = self.<#modelList#>[indexPath.<#row#>];
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


@end
