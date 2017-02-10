//
//  WebViewController.h
//  DearyPet
//
//  Created by Aesir Titan on 2016-09-01.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "ATBaseViewController.h"

@interface WebViewController : ATBaseViewController

// url
@property (strong, nonatomic) NSString *urlStr;

// shouldStartLoadWithRequest
@property (copy, nonatomic) BOOL (^shouldStartLoadWithRequest)(UIWebView *, NSURLRequest *, UIWebViewNavigationType);
// webViewDidStartLoad
@property (copy, nonatomic) void (^webViewDidStartLoad)(UIWebView *);
// webViewDidFinishLoad
@property (copy, nonatomic) void (^webViewDidFinishLoad)(UIWebView *);
// didFailLoadWithError
@property (copy, nonatomic) void (^didFailLoadWithError)(UIWebView *, NSError *);



+ (instancetype)webViewWithURLString:(NSString *)urlStr;

+ (instancetype)webViewWithURLString:(NSString *)urlStr start:(void (^)(UIWebView *webView))start finish:(void (^)(UIWebView *webView))finish;



@end
