//
//  CommentView.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-17.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "CommentView.h"

@interface CommentView ()

@end

static CGFloat lastY = 0;

@implementation CommentView

- (void)awakeFromNib{
    
    [self _initUI];
    
    [super awakeFromNib];
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
    
    NSInteger tag = 10;
    CGFloat lastX = 0;
    lastY = 0;
    for (int i=0; i<3; i++) {
        
        UILabel *lb_name = [[UILabel alloc] initWithFrame:CGRectMake(0, lastY, 100, 20)];
        [self addSubview:lb_name];
        lb_name.tag = tag++;
        lb_name.font = [UIFont systemFontOfSize:12];
        lb_name.text = @"测试数据";
        [lb_name sizeToFit];
        lastX = lb_name.right;
        
        UILabel *lb_content = [[UILabel alloc] initWithFrame:lb_name.frame];
        [self addSubview:lb_content];
        lb_content.tag = tag++;
        lb_content.font = [UIFont systemFontOfSize:12];
        lb_content.textColor = [UIColor lightGrayColor];
        lb_content.text = @"测试数据";
        [lb_content sizeToFit];
        lb_content.left = lastX;
        
        lastY = lb_content.bottom + 8;
    }
    
    UILabel *more = [[UILabel alloc] initWithFrame:CGRectMake(0, lastY, self.right, 20)];
    [self addSubview:more];
    more.tag = tag++;
    more.font = [UIFont systemFontOfSize:13];
    more.text = @"查看所有评论";
    [more sizeToFit];
    more.right = self.right - 8;
    
    lastY = more.bottom;
    
}

- (void)setSource:(CameraSource *)source{
    
    lastY = 0;
    [self reloadSubviewsWithSource:source];
    
    self.height = lastY + 4;
    [self layoutIfNeeded];
}

- (void)reloadSubviewsWithSource:(CameraSource *)source{
    NSUInteger count = source.camera.discuz_count.integerValue;
    
    NSInteger tag = 10;
    for (int i=0; i<source.social_discuz.count; i++) {
        
        UILabel *lb_name = [self viewWithTag:tag++];
        lb_name.text = [source.social_discuz[i].user_nickname stringByReplacingOccurrencesOfString:@" " withString:@""];
        [lb_name sizeToFit];
        
        
        UILabel *lb_content = [self viewWithTag:tag++];
        lb_content.text = [@" : " stringByAppendingString:source.social_discuz[i].content];
        lb_content.left = lb_name.right;
        lb_content.width = self.width - lb_content.left;
        
        lastY = lb_content.bottom;
        
    }
    
    if (count > 3) {
        UILabel *more = [self viewWithTag:tag++];
        lastY = more.bottom;
    }
    
    
    
    
}


- (void)setupAction{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:tap];
}

- (void)tapped:(UITapGestureRecognizer *)sender{
    ATLogOBJ(@"点击了评论");
}



@end
