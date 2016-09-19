//
//  FeedbackViewController.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-30.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "FeedbackViewController.h"
#import "TableFooterButton.h"


@interface FeedbackViewController () 

// scroll view
@property (strong, nonatomic) UIScrollView *scrollView;
// text view
@property (strong, nonatomic) UITextField *content;

@end

@implementation FeedbackViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = atColor.background;
    [self setupNavigationBar];
    [self setupScorllView];
    [self setupTextView];
    [self setupSubmitButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// setup navigationBar
- (void)setupNavigationBar{
    self.navigationItem.title = @"意见反馈";
}



// setup scroll view
- (void)setupScorllView{
    [self.view addSubview:[[UIView alloc]init]];
    // init and add to superview
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];
    // style
    self.scrollView.contentSize = CGSizeMake(0, kScreenH);
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
}

// setup text view
- (void)setupTextView{
    // init and add to superview
    self.content = [[UITextField alloc] initWithFrame:CGRectMake(8, 64+8, kScreenW - 16, 120)];
    [self.scrollView addSubview:self.content];
    self.content.font = [UIFont systemFontOfSize:14];
    self.content.placeholder = @"亲爱的用户，欢迎来吐槽！";
    [self.content at_addEditingEndOnExitHandler:^(UITextField * _Nonnull sender) {
        [self submitFeedback];
    }];
    
}

// setup submit button
- (void)setupSubmitButton{
    // init and add to superview
    TableFooterButton *button = [TableFooterButton buttonViewTintColor:atColor.theme title:@"提交" action:^(UIButton *sender) {
        [self submitFeedback];
    }];
    button.top = self.content.bottom + 8;
    [self.scrollView addSubview:button];
    
}

- (void)submitFeedback{
    [self.view endEditing:YES];
    self.content.text = @"";
    [ATProgressHUD at_target:self.view showInfo:@"感谢您的提供的反馈！\n我们会继续努力的！" duration:3];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}


@end
