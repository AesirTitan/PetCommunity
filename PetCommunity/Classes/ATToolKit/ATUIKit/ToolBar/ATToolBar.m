//
//  ATToolBar.m
//  SmartLamp
//
//  Created by Aesir Titan on 2016-07-19.
//  Copyright © 2016年 Titan Studio. All rights reserved.
//

#import "ATToolBar.h"

static NSUInteger buttonW = 58;

@interface ATToolBar () <UIScrollViewDelegate>

// scrollview
@property (strong, nonatomic) UIScrollView *titleScrollView;
// the last button
@property (weak, nonatomic) UIButton *lastBtn;
// line
@property (strong, nonatomic) CALayer *line;

// button events
@property (copy, nonatomic) void (^btnAction)(NSUInteger index);
// titles
@property (strong, nonatomic) NSArray<NSString *> *titles;

// content scroll view
@property (strong, nonatomic) UIScrollView *contentScrollView;

@end

static UIColor *normalColor;
static UIColor *highlightedColor;

@implementation ATToolBar

#pragma mark only titles with frame
// create a toolbar
+ (instancetype)toolbarWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles titleColor:(UIColor *)color action:(void (^)(NSUInteger index))action {
    return [[ATToolBar alloc] initWithFrame:frame titles:titles titleColor:color action:action];
}
// create a toolbar
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles titleColor:(UIColor *)color action:(void (^)(NSUInteger index))action {
    if (self = [super initWithFrame:frame]) {
        // set titles
        self.titles = titles;
        // buttonW
        [self setupButtonW];
        // setup scrollview
        [self setupScrollViewWithFrame:frame];
        // set tintcolor
        self.tintColor = color;
        // setup line
        [self setupLine];
        // setup button events
        self.btnAction = action;
        // layout buttons
        [self _layoutButtons];
    }
    return self;
}

#pragma mark only titles with view
// create a toolbar and add to view
+ (instancetype)toolbarWithTitleView:(UIView *)view titles:(NSArray<NSString *> *)titles titleColor:(UIColor *)color action:(void (^)(NSUInteger index))action{
    return [[ATToolBar alloc] initWithTitleView:view titles:titles titleColor:color action:action];
}
// create a toolbar and add to view
- (instancetype)initWithTitleView:(UIView *)view titles:(NSArray<NSString *> *)titles titleColor:(UIColor *)color action:(void (^)(NSUInteger index))action {
    if (self = [self initWithFrame:view.bounds titles:titles titleColor:color action:action]) {
        if (view) {
            [view addSubview:self];
        }
    }
    return self;
}

#pragma mark titles and contents
// create a toolbar and add to view
+ (instancetype)toolbarWithTitleView:(UIView *)view titles:(NSArray<NSString *> *)titles titleColor:(UIColor *)color contentView:(UIView *)contentView contents:(NSArray<UIView *> *)contents action:(void (^)(NSUInteger index))action{
    return [[ATToolBar alloc] initWithTitleView:view titles:titles titleColor:color contentView:contentView contents:contents action:action];
}

- (instancetype)initWithTitleView:(UIView *)view titles:(NSArray<NSString *> *)titles titleColor:(UIColor *)color contentView:(UIView *)contentView contents:(NSArray<UIView *> *)contents action:(void (^)(NSUInteger index))action{
    if (self = [self initWithTitleView:view titles:titles titleColor:color action:action]) {
        if (contentView && contents) {
            [self view:contentView setupChildViews:contents];
        }
    }
    return self;
}



#pragma mark function
// set tint color
- (void)setTintColor:(UIColor *)tintColor{
    [super setTintColor:tintColor];
    CGFloat red,green,blue,alpha;
    [tintColor getRed:&red green:&green blue:&blue alpha:&alpha];
    highlightedColor = tintColor;
    normalColor = [UIColor colorWithRed:red green:green blue:blue alpha:0.5 * alpha];
}


#pragma mark - private methods

// layout buttons
- (void)_layoutButtons{
    CGFloat buttonH = self.frame.size.height;
    for (int i=0; i<_titles.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*buttonW, 0, buttonW, buttonH)];
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:normalColor forState:UIControlStateNormal];
        [btn setTitleColor:highlightedColor forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [self.titleScrollView addSubview:btn];
        if (!i) {
            _lastBtn = btn;
            [self action:btn];
        }
    }
    self.titleScrollView.contentSize = CGSizeMake(_titles.count * buttonW, 0);
    
}
- (void (^)(NSUInteger))selectIndex{
    return ^(NSUInteger index){
        [self action:self.titleScrollView.subviews[index]];
    };
}

// button events
- (void)action:(UIButton *)sender{
    _lastBtn.selected = NO;
    _lastBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _lastBtn = sender;
    _lastBtn.selected = YES;
    _lastBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    
    _line.position = CGPointMake(sender.center.x, sender.frame.size.height - 1);
    // adjust title content
    [self adjustTitleOffsetWith:sender];
    // delegate
    if (self.delegate && [self.delegate respondsToSelector:@selector(toolbarTitleDidSelectedIndex:)]) {
        [self.delegate performSelector:@selector(toolbarTitleDidSelectedIndex:) withObject:@(sender.tag)];
    }
    // scroll
    [self contentScrollToIndex:sender.tag];
    // user action
    if (self.btnAction) {
        self.btnAction(_lastBtn.tag);
    }
}

- (void)adjustTitleOffsetWith:(UIButton *)sender{
    CGPoint currentOffset = self.titleScrollView.contentOffset;
    CGFloat left = sender.frame.origin.x - currentOffset.x;
    CGFloat right = left + sender.frame.size.width;
    CGPoint offset = currentOffset;
    if (left < self.frame.origin.x + 30){
        offset.x -= buttonW;
        if (offset.x < 0) {
            offset.x = 0;
        }
    }
    if (right > self.frame.origin.x + self.frame.size.width - 30) {
        offset.x += buttonW;
        if (offset.x > self.titleScrollView.contentSize.width - self.titleScrollView.frame.size.width) {
            
            offset.x = self.titleScrollView.contentSize.width - self.titleScrollView.frame.size.width;
        }
    }
    [self.titleScrollView setContentOffset:offset animated:YES];
}

// scroll to index
- (void)contentScrollToIndex:(NSUInteger)index{
    // scroll
    CGRect rect = self.contentScrollView.bounds;
    rect.origin.y = 0;
    rect.origin.x = index * rect.size.width;
    [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:0.8f initialSpringVelocity:0.1f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.contentScrollView scrollRectToVisible:rect animated:NO];
    } completion:^(BOOL finished) {
        
    }];
}

// setup scrollview
- (void)setupScrollViewWithFrame:(CGRect)frame{
    self.titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    self.titleScrollView.showsVerticalScrollIndicator = NO;
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    self.titleScrollView.bounces = NO;
    [self addSubview:self.titleScrollView];
}

// setup button width
- (void)setupButtonW{
    // init and add to superview
    switch (self.titles.firstObject.length) {
        case 0:
        case 1: //
        case 2: //
            buttonW = 58;
            break;
        case 3: //
        case 4: //
            buttonW = 88;
            break;
        default:
            buttonW = 108;
            break;
    }
    // style
    
}

// setup line
- (void)setupLine{
    _line = [[CALayer alloc] init];
    _line.backgroundColor = highlightedColor.CGColor;
    _line.frame = CGRectMake(0, 0, buttonW, 2);
    [self.titleScrollView.layer addSublayer:_line];
}

// setup child views
- (void)view:(UIView *)view setupChildViews:(NSArray<UIView *> *)views{
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:view.bounds];
    self.contentScrollView.delegate = self;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.showsVerticalScrollIndicator = NO;
    self.contentScrollView.scrollEnabled = YES;
    const CGFloat contentWidth = 3 * view.bounds.size.width;
    self.contentScrollView.contentSize = CGSizeMake(contentWidth, 0);
    self.contentScrollView.pagingEnabled = YES;
    [self addSubview:self.contentScrollView];
    // scroll view content
    for (int i=0; i<views.count; i++) {
        UIView *view = views[i];
        CGRect frame = view.bounds;
        frame.origin.x = i * frame.size.width;
        view.frame = frame;
        [self.contentScrollView addSubview:view];
    }
    [view addSubview:self.contentScrollView];
}


#pragma mark - scroll view delegate

// will begin dragging
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.titleScrollView]) {
        
    } else if ([scrollView isEqual:self.contentScrollView]) {
        // delegate
        if (self.delegate&&[self.delegate respondsToSelector:@selector(toolbarContentViewWillBeginDragging:)]) {
            [self.delegate performSelector:@selector(toolbarContentViewWillBeginDragging:) withObject:scrollView];
        }
    }
}

// scrolling
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.titleScrollView]) {
        
    } else if ([scrollView isEqual:self.contentScrollView]) {
        // delegate
        if (self.delegate&&[self.delegate respondsToSelector:@selector(toolbarContentViewDidScroll:)]) {
            [self.delegate performSelector:@selector(toolbarContentViewDidScroll:) withObject:scrollView];
        }
    }
}

// did end decelerating (end scroll)
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.titleScrollView]) {
        
    } else if ([scrollView isEqual:self.contentScrollView]) {
        // select index
        self.selectIndex((NSUInteger)scrollView.contentOffset.x/self.frame.size.width);
        // delegate
        if (self.delegate&&[self.delegate respondsToSelector:@selector(toolbarContentViewDidEndDecelerating:)]) {
            [self.delegate performSelector:@selector(toolbarContentViewDidEndDecelerating:) withObject:scrollView];
        }
    }
}







@end



