//
//  CommentDetailVC.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-16.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "CommentDetailVC.h"
#import "UITableView+Creator.h"

#import "CameraTableViewCell.h"
#import "CommentCell.h"
#import "CommentBar.h"
#import "ATNetworkManager.h"
#import "UserModel.h"
#import "UserProfileViewController.h"

@interface CommentDetailVC () <UITableViewDataSource, UITableViewDelegate>

// table view
@property (strong, nonatomic) UITableView *tableView;

// comment
@property (strong, nonatomic) NSMutableArray<CameraSocial_Discuz *> *comment;

// header
@property (strong, nonatomic) CameraTableViewCell *header;

// comment bar
@property (strong, nonatomic) CommentBar *commentBar;

@end

@implementation CommentDetailVC

- (instancetype)initWithFrameModel:(CamerFrameModel *)frameModel {
    if (self = [super init]) {
        self.frameModel = frameModel;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _initUI];
    
    [self setupTableView];
    
    [self setupCommentBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// init UI
- (void)_initUI{
    self.navigationItem.title = @"详情";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem at_itemWithImage:[UIImage imageNamed:@"icon_more"] style:UIBarButtonItemStylePlain action:^(id  _Nonnull sender) {
        UserProfileViewController *vc = [[UserProfileViewController alloc] initWithCameraUser:self.frameModel.model.camera.user];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self _endEditing];
}

// setup table view
- (void)setupTableView{
    // init and add to superview
    self.tableView = [UITableView at_tableViewWithTarget:self frame:CGRectWithTopAndBottomMargin(0, 40) style:UITableViewStylePlain registerNibForCellReuseIdentifier:@"CommentCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SectionHeader" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"SectionHeader"];
    // style
    self.tableView.backgroundColor = atColor.groupTableViewBackground;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.header = [CameraTableViewCell reusableCellWithTableView:self.tableView];
    self.header.frameModel = self.frameModel;
    self.header.height = self.header.frameModel.cellHeight;
    self.tableView.tableHeaderView = self.header;
    
    self.comment = [NSMutableArray arrayWithArray:self.frameModel.model.social_discuz];
    
    
}


// setup comment bar
- (void)setupCommentBar{
    // init and add to superview
    self.commentBar = [[CommentBar alloc] initWithFrame:CGRectMake(0, kScreenH-40, kScreenW, 40)];
    [self.view addSubview:self.commentBar];
    // action
    [self.commentBar inputEmoticonAction:^{
        
    }];
    [self.commentBar inputDoneAction:^(NSString *text){
        [self submitComment:text];
    }];
    
    // resign
    [self.view at_addTapGestureHandler:^(UITapGestureRecognizer * _Nonnull sender) {
        [self _endEditing];
    }];
    
    [self.commentBar adjustView:self.view];
    
}

- (void)submitComment:(NSString *)text{
    CameraSocial_Discuz *item = [CameraSocial_Discuz newItemWithUser:loginUser content:text];
    [self.comment addObject:item];
    [self.tableView reloadData];
    [ATProgressHUD at_target:self.view showInfo:@"评论成功！" duration:1];
    [self.commentBar submitComment];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.comment.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)_endEditing{
    [self.commentBar.inputView resignFirstResponder];
}

#pragma mark - table view data source

// number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

// number of rows in section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.comment.count;
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // dequeue reusable cell with reuse identifier
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    // do something
    cell.model = self.comment[indexPath.row];
    UserSource *user = userCachePath(cell.model.user_nickname).readArchivedPlist;
    if (!user) {
        user = [UserSource randomUser];
        user.nickname = cell.model.user_nickname;
        user.image = cell.model.user_image;
        userCachePath(cell.model.user_nickname).saveArchivedPlist(user);
    }
    cell.user = user;
    [cell tappedCell:^(NSString *nickname) {
        [self.commentBar replyWithName:nickname];
    }];
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

// header for section
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.header;
}





#pragma mark - scroll view delegate

// will begin dragging
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self _endEditing];
}





@end
