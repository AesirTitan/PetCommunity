//
//  DPInputView.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-30.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "DPInputView.h"

@implementation DPInputView

+ (instancetype)at_passwordViewWithPlaceholder:(NSString *)placeholder textChanged:(void (^)(NSString *text))textChanged {
    return [[self alloc] initWithPlaceholder:placeholder textChanged:textChanged];
}


- (instancetype)initWithPlaceholder:(NSString *)placeholder textChanged:(void (^)(NSString *text))textChanged {
    if (self = [super initWithFrame:CGRectMake(8, 8, kScreenW - 16, 40)]) {
        self.borderStyle = UITextBorderStyleRoundedRect;
        [self setupLeftView];
        [self setupTextView];
        self.placeholder = placeholder;
        [self at_addEditingChangedHandler:^(UITextField * _Nonnull sender) {
            if (textChanged) {
                textChanged(self.text);
            }
        }];
    }
    return self;
}






// setup text field
- (void)setupLeftView{
    // init and add to superview
    self.leftViewMode = UITextFieldViewModeAlways;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    UIImageView *imgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_psw"]];
    imgv.widthAndHeightEqual(12);
    imgv.centerY = view.centerY;
    imgv.left = 12;
    [view addSubview:imgv];
    self.leftView = view;
    
//    [self.leftView addSubview:imgv];
    // style
    
}


// setup text
- (void)setupTextView{
    // init and add to superview
    self.tintColor = atColor.theme;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.font = [UIFont systemFontOfSize:13];
    // style
    self.secureTextEntry = YES;
    
}

@end
