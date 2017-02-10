//
//  HeaderDetailVC.m
//  DearyPet
//
//  Created by Aesir Titan on 2016-08-18.
//  Copyright © 2016 Titan Studio. All rights reserved.
//

#import "HeaderDetailVC.h"
#import "UIWebView+AFNetworking.h"

@interface HeaderDetailVC ()

@end


@implementation HeaderDetailVC

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


- (void)loadRequest{
    if (self.url.length) {
        
        // url
        NSURL *url = [NSURL URLWithString:self.url];
        
        // web
        CGRect frame = self.view.frame;
        frame.size.height -= 64;
        UIWebView *web = [[UIWebView alloc] initWithFrame:frame];
        [self.view addSubview:web];
        // request
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:6.0f];
        
        // load request
        [web loadRequest:request];
        
        
    } else{
        ATLogFail(@"url not found");
    }
}



@end
