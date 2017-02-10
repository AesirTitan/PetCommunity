//
//  ContentView.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-16.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "ContentView.h"
#import "CommentButton.h"

@interface ContentView ()

// content
@property (strong, nonatomic) UILabel *content;

// button1
@property (strong, nonatomic) CommentButton *btn1;
// button2
@property (strong, nonatomic) CommentButton *btn2;
// button3
@property (strong, nonatomic) CommentButton *btn3;

// image
@property (strong, nonatomic) UIImageView *countImage;
// view count
@property (strong, nonatomic) UILabel *countLabel;


@end


static CGFloat lastY = 0;
@implementation ContentView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self _initUI];
}

-(void)setCamera:(CameraCamera *)camera{
    
    // content
    [self reloadUIWithCamera:camera];
    
    self.height = lastY;
    
}

+ (instancetype)viewWithFrame:(CGRect)frame andAddToView:(UIView *)view {
    return [[self alloc] initWithFrame:frame andAddToView:view];
}

- (instancetype)initWithFrame:(CGRect)frame andAddToView:(UIView *)view {
    if (self = [super initWithFrame:frame]) {
        [self _initUI];
        [view addSubview:self];
    }
    return self;
}


// init UI
- (void)_initUI{
    // ==================== [ content ] ==================== //
    _content = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 20)];
    [self addSubview:_content];
    _content.numberOfLines = 0;
    _content.font = [UIFont systemFontOfSize:15];
    
    // ==================== [ buttons ] ==================== //
    static const NSUInteger count = 3;
    static const CGFloat margin = 8.0;
    const CGFloat width = (self.width - margin * (count - 1) ) / 3;
    CGFloat lastX = 0;
    self.btn1 = [[CommentButton alloc] initWithFrame:CGRectMake(lastX, 0, width, 26)];
    [self addSubview:self.btn1];
    lastX = self.btn1.right + 8;
    self.btn2 = [[CommentButton alloc] initWithFrame:CGRectMake(lastX, 0, width, 26)];
    [self addSubview:self.btn2];
    lastX = self.btn2.right + 8;
    self.btn3 = [[CommentButton alloc] initWithFrame:CGRectMake(lastX, 0, width, 26)];
    [self addSubview:self.btn3];
    lastY = self.btn3.bottom + 8;
    
    
    
    
    // ==================== [ view count ] ==================== //
    // image
    _countImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"recommend_watch_14x10_"]];
    [self addSubview:_countImage];
    self.countImage.left = 0;
    
    // label
    _countLabel = [[UILabel alloc] init];
    [self addSubview:_countLabel];
    self.countLabel.font = [UIFont systemFontOfSize:12];
    self.countLabel.textColor = [UIColor md_orange];
    self.countLabel.frame = CGRectMake(self.countImage.right + 4, lastY, 200, 26);
    self.countLabel.width = self.width - self.countLabel.left;
    
    
}

- (void)reloadUIWithCamera:(CameraCamera *)camera{
    // content
    self.content.text = camera.explain;
    [_content sizeToFit];
    self.content.width = self.width - self.content.left;
    lastY = _content.bottom + 8;
    
    // buttons
    self.btn1.top = self.btn2.top = self.btn3.top = lastY;
    [self.btn1 reloadButtonWithImage:@"icon_forwarding_15x15_" title:camera.share_count action:^(UIButton *sender) {
        
    }];
    [self.btn2 reloadButtonWithImage:@"icon_comments_15x15_" title:camera.discuz_count action:^(UIButton *sender) {
        
    }];
    [self.btn3 reloadButtonWithImage:@"icon_like_n_15x15_" title:camera.praise_count action:^(UIButton *sender) {
        
    }];
    lastY = self.btn1.bottom + 8;
    
    // view count
    self.countLabel.text = [NSString stringWithFormat:@"浏览%@次",camera.view_count];
    [self.countLabel sizeToFit];
    self.countLabel.top = lastY;
    self.countLabel.width = self.width - self.countLabel.left;
    self.countImage.centerY = self.countLabel.centerY;
    
    lastY = self.countLabel.bottom;
    
}





@end
