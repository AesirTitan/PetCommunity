//
//  SearchViewController.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-31.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "SearchViewController.h"
#import "CameraModel.h"
#import "ATNetworkManager.h"
#import "UITableView+Creator.h"
#import "SearchCameraTableViewCell.h"
#define NIB_SEARCH @"SearchCameraTableViewCell"
#define sourcePath kURLHotCamera.mainBundlePath
@interface SearchViewController ()<UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate>

// search bar
@property (strong, nonatomic) UISearchBar *searchBar;
// table view
@property (strong, nonatomic) UITableView *tableView;

// source
@property (strong, nonatomic) NSMutableArray<CamerFrameModel *> *sources;
// data list
@property (strong, nonatomic) NSMutableArray<CamerFrameModel *> *results;

// placeholder
@property (strong, nonatomic) UIImageView *placeholder;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"搜索";
    [self setupTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.searchBar becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self _endEditing];
}

// setup table view
- (void)setupTableView{
    // init and add to superview
    self.tableView = [UITableView at_tableViewWithTarget:self frame:self.view.bounds style:UITableViewStylePlain registerNibForCellReuseIdentifier:NIB_SEARCH];
    self.tableView.backgroundColor = atColor.groupTableViewBackground;
    // style
    self.tableView.tableHeaderView = self.searchBar;
    self.tableView.rowHeight = 80;
    self.placeholder = [self setupPlaceholder];
    self.placeholder.top -= 80;
    [self.tableView.backgroundView addSubview:self.placeholder];
    
}

- (void)_endEditing{
    self.searchBar.showsCancelButton = NO;
    self.searchBar.text = nil;
    [self.searchBar resignFirstResponder];
}

- (UISearchBar *)searchBar{
    if (!_searchBar) {
        // create it
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 44)];
        _searchBar.delegate = self;
        // style
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar.tintColor = atColor.theme;
        _searchBar.barTintColor = atColor.theme;
        _searchBar.placeholder = @"请输入关键词";
        // do something...
        
    }
    return _searchBar;
}

- (NSMutableArray<CamerFrameModel *> *)sources{
    if (!_sources) {
        // create it
        _sources = [NSMutableArray array];
        // do something...
        // load data
        NSArray *response = kURLHotCamera.mainBundlePath.readArray;
        for (NSDictionary *dict in response) {
            CameraSource *model = [CameraSource mj_objectWithKeyValues:dict];
            CamerFrameModel *frameModel = [[CamerFrameModel alloc] init];
            frameModel.model = model;
            [_sources addObject:frameModel];
        }
    }
    return _sources;
}

- (NSMutableArray<CamerFrameModel *> *)results{
    if (!_results) {
        // create it
        _results = [NSMutableArray array];
        // do something...
        
    }
    return _results;
}

#pragma mark - search bar delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
    for(id cc in [searchBar subviews])
    {
        for (UIView *view in [cc subviews]) {
            if ([NSStringFromClass(view.class)                 isEqualToString:@"UINavigationButton"])
            {
                UIButton *btn = (UIButton *)view;
                [btn setTitle:@"取消" forState:UIControlStateNormal];
            }
        }
    }
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self _endEditing];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self _endEditing];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self filterContentForSearchText:searchText];
}


- (void)filterContentForSearchText:(NSString *)searchText{
    [self.results removeAllObjects];
    for (CamerFrameModel *tmp in self.sources) {
        NSString *content = tmp.model.camera.explain;
        NSRange storeRange = NSMakeRange(0, content.length);
        NSRange foundRange = [content rangeOfString:searchText options:NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch range:storeRange];
        if (foundRange.length) {
            [self.results addObject:tmp];
        }
    }
    [self.tableView reloadData];
}

#pragma mark - table view data source

// number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

// number of rows in section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.placeholder.hidden = self.results.count;
    return self.results.count;
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // dequeue reusable cell with reuse identifier
    SearchCameraTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NIB_SEARCH];
    // do something
    cell.frameModel = self.results[indexPath.row];
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

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self _endEditing];
}



@end
