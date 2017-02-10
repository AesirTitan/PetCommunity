//
//  CommentBar.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-04.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "CommentBar.h"

@interface CommentBar () <UITextViewDelegate>


// left button
@property (strong, nonatomic) UIButton *emoticonButton;

// input view
@property (strong, nonatomic) UITextView *inputView;

// right button
@property (strong, nonatomic) UIButton *sendButton;


// input done
@property (copy, nonatomic) void (^doneAction)(NSString *text);

// emoticon
@property (copy, nonatomic) void (^emoticonAction)();

// origin frame
@property (assign, nonatomic) CGRect selfFrame;
// input view frame
@property (assign, nonatomic) CGRect inputFrame;


@end

@implementation CommentBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.selfFrame = frame;
        self.backgroundColor = atColor.groupTableViewBackground;
        [self setupSubviews];
//        [self setupNotification];
        
    }
    return self;
}


// setup left
- (void)setupSubviews{
    // emoticon button
    self.emoticonButton = [self _customButtonWithImage:@"icon_emoticon" action:^(UIButton *sender) {
        if (self.emoticonAction) {
            self.emoticonAction();
        }
    }];
    self.emoticonButton.left = 0;
    
    // send button
    self.sendButton = [self _customButtonWithImage:@"icon_send" action:^(UIButton *sender) {
        if (self.doneAction) {
            self.doneAction(self.inputView.text);
        }
    }];
    self.sendButton.right = self.width;
    self.sendButton.enabled = NO;
    
    // input view
    self.inputView = [self _textView];
    
    
    
}

#pragma mark - action

- (void)inputDoneAction:(void(^)(NSString *text))action {
    self.doneAction = action;
}

- (void)inputEmoticonAction:(void(^)())action {
    self.emoticonAction = action;
}


- (void)submitComment {
    [self _enableSendButton:NO];
    self.inputView.text = @"";
    [self.inputView resignFirstResponder];
    
}

- (void)replyWithName:(NSString *)name {
    self.inputView.text = [NSString stringWithFormat:@"@%@：",name];
    [self.inputView becomeFirstResponder];
}

#pragma mark - private methods

- (UIButton *)_customButtonWithImage:(NSString *)image action:(void (^)(UIButton *sender))action{
    UIButton *button = [[UIButton alloc] init];
    [self addSubview:button];
    button.tintColor = atColor.lightGray;
    // style
    button.height = self.height;
    button.width = button.height;
    button.centerY = self.centerY;
    button.maskView = [UIView at_roundedViewWithFrame:button.bounds];
    
    UIImage *emoticon = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [button setImage:emoticon forState:UIControlStateNormal];
    [button setImage:emoticon forState:UIControlStateHighlighted];
    [button at_addTouchUpInsideHandler:action animatedScale:1.2 duration:1];
    
    return button;
}


- (UITextView *)_textView{
    UITextView *input = [[UITextView alloc] init];
    [self addSubview:input];
    input.delegate = self;
    // color
    input.backgroundColor = atColor.white;
    // frame
    input.left = self.emoticonButton.right;
    input.width = self.sendButton.left - input.left;
    input.height = self.height-16;
    input.centerY = self.centerY;
    
    input.layer.cornerRadius = 8;
    // input view
    input.autocorrectionType = UITextAutocorrectionTypeNo;
    input.textColor = atColor.darkGray;
    input.font = [UIFont systemFontOfSize:15];
    self.inputFrame = input.frame;
    [input at_adjustViewFrameWithKeyboard:self];
    
    
    return input;
}
- (void)adjustView:(UIView *)view {
    [self.inputView at_adjustViewFrameWithKeyboard:view];
}

- (void)_enableSendButton:(BOOL)enable{
    self.sendButton.enabled = enable;
    if (enable) {
        self.sendButton.alpha = 1;
    } else{
        self.sendButton.alpha = 0.7;
    }
    
}


#pragma mark - delegate


- (void)textViewDidBeginEditing:(UITextView *)textView{
    [self adjustTextView:textView replacementText:textView.text];
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    [self adjustTextView:textView replacementText:textView.text];
    [self _enableSendButton:(BOOL)textView.text.length];
    
}

- (void)textViewDidChange:(UITextView *)textView{
    [self _enableSendButton:(BOOL)textView.text.length];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    [self adjustTextView:textView replacementText:text];

    return YES;
}

- (void)adjustTextView:(UITextView *)textView replacementText:(NSString *)text{
    CGFloat oldHeight = textView.height;
    CGFloat height;
    ATFloatRange heightRange = ATFloatRangeMake(8, 100);
    if ([text isEqual:@""]) {
        
        if (![textView.text isEqualToString:@""]) {
            height = [textView at_heightWithText:[textView.text substringToIndex:[textView.text length] - 1] heightRange:heightRange];
        }else{
            height = [textView at_heightWithText:textView.text heightRange:heightRange];
        }
    }else{
        height = [textView at_heightWithText:[NSString stringWithFormat:@"%@%@",textView.text,text] heightRange:heightRange];
        
    }
    [UIView animateWithDuration:0.5 animations:^{
        textView.height = height;
        self.height = height + 16;
        self.top -= height - oldHeight;
        self.emoticonButton.centerY = self.centerY;
        self.sendButton.centerY = self.centerY;
    } completion:nil];
    

}

@end
