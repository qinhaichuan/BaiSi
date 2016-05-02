//
//  QHCWebView.m
//  Baisi
//
//  Created by QHC on 5/2/16.
//  Copyright © 2016 秦海川. All rights reserved.
//

#import "QHCWebView.h"

@implementation QHCWebView


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIWebView *webV = [[UIWebView alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [webV loadRequest:request];
    [self.view addSubview:webV];
    
    
}

@end
