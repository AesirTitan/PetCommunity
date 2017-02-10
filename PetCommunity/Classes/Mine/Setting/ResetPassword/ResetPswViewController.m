//
//  ResetPswViewController.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-30.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "ResetPswViewController.h"
#import "DPInputView.h"
#import "TableFooterButton.h"


@interface ResetPswViewController ()

// text field
@property (strong, nonatomic) DPInputView *psw_old;

// text field
@property (strong, nonatomic) DPInputView *psw_new;

// text field
@property (strong, nonatomic) DPInputView *psw_repeat;

@end

@implementation ResetPswViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = atColor.background;
    [self setupNavigationBar];
    [self setupInputView];
    [self setupSaveButton];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// setup navigationBar
- (void)setupNavigationBar{
    self.navigationItem.title = @"修改密码";
}



// setup input view
- (void)setupInputView{
    // init and add to superview
    self.psw_old = [DPInputView at_passwordViewWithPlaceholder:@"请输入原始密码" textChanged:^(NSString *text) {
        ATLogOBJ(text);
    }];
    
    self.psw_new = [DPInputView at_passwordViewWithPlaceholder:@"请输入6位以上新密码" textChanged:^(NSString *text) {
        ATLogOBJ(text);
    }];
    
    self.psw_repeat = [DPInputView at_passwordViewWithPlaceholder:@"请确认新密码" textChanged:^(NSString *text) {
        ATLogOBJ(text);
    }];
    
    [self.view addSubview:self.psw_old];
    [self.view addSubview:self.psw_new];
    [self.view addSubview:self.psw_repeat];
    self.psw_old.top = 64+8;
    self.psw_new.top = self.psw_old.bottom + 8;
    self.psw_repeat.top = self.psw_new.bottom + 8;
    
}


// setup save button
- (void)setupSaveButton{
    // init and add to superview
    TableFooterButton *button = [TableFooterButton buttonViewTintColor:atColor.theme title:@"保存" action:^(UIButton *sender) {
        [self submit];
    }];
    [self.view addSubview:button];
    button.top = self.psw_repeat.bottom + 8;
    // style
    
}


- (void)submit{
    [self.view endEditing:YES];
    [ATProgressHUD at_target:self.view showInfo:@"密码修改成功!" duration:3];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

@end
