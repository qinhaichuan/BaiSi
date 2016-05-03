//
//  QHCWebView.m
//  Baisi
//
//  Created by QHC on 5/2/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCWebView.h"

@interface QHCWebView()

@property(nonatomic, strong) UIWebView *webV;

@end

@implementation QHCWebView


-(void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIWebView *webV = [[UIWebView alloc] init];
//    self.webV = webV;
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
//    [webV loadRequest:request];
////    webV.backgroundColor = [UIColor redColor];
//    [self.view addSubview:webV];
//    
    
}

-(UIWebView *)webV
{
    if (!_webV) {
        _webV = [[UIWebView alloc] init];
        _webV.frame = self.view.bounds;
        NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
        [_webV loadRequest:req];
        [self.view addSubview:_webV];

    }
    return _webV;
}

@end
