//
//  ATInputBar.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-07.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "ATInputBar.h"
#import "MediaPickerView.h"

static CGFloat sHeight = 64;

@interface ATInputBar () <UITextViewDelegate>


// left button
@property (strong, nonatomic) UIButton *mediaButton;

// input view
@property (strong, nonatomic) UITextView *inputView;

// right button
@property (strong, nonatomic) UIButton *sendButton;


// input done
@property (copy, nonatomic) void (^doneAction)(NSString *text);

// emoticon
@property (copy, nonatomic) void (^mediaAction)();

// origin frame
@property (assign, nonatomic) CGRect selfFrame;
// input view frame
@property (assign, nonatomic) CGRect inputFrame;


// picker
@property (strong, nonatomic) MediaPickerView *mediaPicker;
@end

@implementation ATInputBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.selfFrame = frame;
        self.backgroundColor = atColor.groupTableViewBackground;
        [self setupSubviews];
        
    }
    return self;
}


// setup left
- (void)setupSubviews{
    // emoticon button
    self.mediaButton = [self _customButtonWithImage:@"icon_sendMedia" action:^(UIButton *sender) {
        if ([self.subviews containsObject:self.mediaPicker]) {
            [self hideMediaPicker];
        } else{
            [self showMediaPicker];
        }
        if (self.mediaAction) {
            self.mediaAction();
        }
    }];
    self.mediaButton.left = 0;
    
    // send button
    self.sendButton = [self _customButtonWithImage:@"icon_send" action:^(UIButton *sender) {
        [self hideMediaPicker];
        [self adjustTextView:self.inputView replacementText:@""];
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
    self.mediaAction = action;
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
    input.left = self.mediaButton.right;
    input.width = self.sendButton.left - input.left;
    input.height = self.height-16;
    input.centerY = self.centerY;
    
    input.layer.at_maskToCircle();
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

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [self hideMediaPicker];
    return YES;
}

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
    ATFloatRange heightRange = ATFloatRangeMake(17, 80);
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
        self.mediaButton.centerY = self.centerY;
        self.sendButton.centerY = self.centerY;
    } completion:nil];
    
    
}


- (void)showMediaPicker{
    
    [self addSubview:self.mediaPicker];
    
    CGFloat top = CGRectWithViewInScreen(self).origin.y;
    // in screen bottom
    [self.inputView resignFirstResponder];
    if (top < 400) {
        self.height += sHeight;
        self.bottom -= sHeight;
        _mediaPicker.top = self.inputView.bottom;
    } else{
        [UIView animateWithDuration:0.38 animations:^{
            self.height += sHeight;
            self.bottom -= sHeight;
            
        }];
    }
    
}

- (void)hideMediaPicker{
    if ([self.subviews containsObject:self.mediaPicker]) {
        CGFloat top = CGRectWithViewInScreen(self).origin.y;
        if (top < 300) {
            self.height -= sHeight;
            self.bottom += sHeight;
            
        } else{
            [UIView animateWithDuration:0.38 animations:^{
                self.height -= sHeight;
                self.bottom += sHeight;
                
            } completion:^(BOOL finished) {
                [self.mediaPicker removeFromSuperview];
            }];
        }
    }
    
}

- (MediaPickerView *)mediaPicker{
    if (!_mediaPicker) {
        // create it
        _mediaPicker = [[NSBundle mainBundle] loadNibNamed:@"MediaPickerView" owner:nil options:nil][0];
        // do something...
        _mediaPicker.top = self.inputView.bottom;
        _mediaPicker.width = self.width;
        _mediaPicker.left = self.left;
        _mediaPicker.height = sHeight;
        
    }
    return _mediaPicker;
}

- (void)didFinishPickImage:(void(^)(UIImage *))image {
    [self.mediaPicker didFinishPickImage:image];
}

- (void)didFinishPickAudio:(void(^)(NSURL *))audio {
    [self.mediaPicker didFinishPickAudio:audio];
}

- (void)didFinishPickPhoto:(void(^)(UIImage *))photo {
    [self.mediaPicker didFinishPickPhoto:photo];
}

- (void)didFinishPickVideo:(void(^)(NSURL *))video {
    [self.mediaPicker didFinishPickVideo:video];
}

@end
