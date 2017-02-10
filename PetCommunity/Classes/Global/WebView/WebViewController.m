//
//  WebViewController.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-01.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "WebViewController.h"
#import "UIWebView+AFNetworking.h"

@interface WebViewController () <UIWebViewDelegate>

// web view
@property (strong, nonatomic) UIWebView *webView;




@end


@implementation WebViewController

+ (instancetype)webViewWithURLString:(NSString *)urlStr {
    return [[self alloc] initWithURLString:urlStr];
}

- (instancetype)initWithURLString:(NSString *)urlStr{
    if (self = [super init]) {
        self.urlStr = urlStr;
    }
    return self;
}

+ (instancetype)webViewWithURLString:(NSString *)urlStr start:(void (^)(UIWebView *webView))start finish:(void (^)(UIWebView *))finish {
    return [[self alloc] initWithURLString:urlStr start:start finish:finish];
}

- (instancetype)initWithURLString:(NSString *)urlStr start:(void (^)(UIWebView *webView))start finish:(void (^)(UIWebView *))finish {
    if (self = [self initWithURLString:urlStr]) {
        self.webViewDidStartLoad = start;
        self.webViewDidFinishLoad = finish;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.navigationItem.title = @"精选";
    [self loadRequest];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setUrlStr:(NSString *)urlStr{
    _urlStr = urlStr;
    [self loadRequest];
}

- (void)loadRequest{
    if (self.urlStr.length) {
        // url
        NSURL *url = [NSURL URLWithString:self.urlStr];
        // web
        CGRect frame = self.view.frame;
        frame.size.height -= 64;
        self.webView = [[UIWebView alloc] initWithFrame:frame];
        [self.view addSubview:self.webView];
        self.webView.delegate = self;
        // request
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:6.0f];
        // load request
        [self.webView loadRequest:request];
        
    } else{
        ATLogFail(@"url not found");
    }
}


// should load
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if (self.shouldStartLoadWithRequest) {
        return self.shouldStartLoadWithRequest(webView, request, navigationType);
    } else{
        return YES;
    }
}

// start load
- (void)webViewDidStartLoad:(UIWebView *)webView{
    if (self.webViewDidStartLoad) {
        self.webViewDidStartLoad(webView);
    }
}

// finish load
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if (self.webViewDidFinishLoad) {
        self.webViewDidFinishLoad(webView);
    }
}

// fail
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if (self.didFailLoadWithError) {
        self.didFailLoadWithError(webView, error);
    }
}





@end
