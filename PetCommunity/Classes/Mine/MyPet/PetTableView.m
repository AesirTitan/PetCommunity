//
//  PetTableView.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-30.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "PetTableView.h"
#import "UITableView+Creator.h"
#import "PetTableViewCell.h"


#define NIB_PET @"PetTableViewCell"

@interface PetTableView () <UITableViewDataSource, UITableViewDelegate>



// pet list
@property (strong, nonatomic) NSMutableArray *petList;

@end

@implementation PetTableView

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
    self.tableView = [UITableView at_tableViewWithView:self frame:self.bounds style:UITableViewStylePlain registerNibForCellReuseIdentifier:NIB_PET];
    
    if (self.petList.count) {
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

- (NSMutableArray *)petList{
    if (!_petList) {
        // create it
        _petList = [NSMutableArray array];
        // do something...
        
    }
    return _petList;
}



#pragma mark - table view data source

// number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

// number of rows in section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.petList.count;
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // dequeue reusable cell with reuse identifier
    PetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NIB_PET];
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
