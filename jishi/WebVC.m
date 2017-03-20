//
//  WebVC.m
//  xiaoyixiu
//
//  Created by hanzhanbing on 16/6/19.
//  Copyright © 2016年 柯南. All rights reserved.
//

/**
 *  网页展示通用页面
 *
 */

#import "WebVC.h"

@interface WebVC ()

@end

@implementation WebVC

- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
        _webView.delegate = self;
    }
    return _webView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.webView];
}

- (void)setNavTitle:(NSString *)navTitle
{
    self.title = navTitle;
}

- (NSString *)navTitle
{
    return self.navTitle;
}

- (void)loadLocalFile:(NSString *)fileName
{
    //文件内容string
    NSString *file = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
    
    NSString *fileString = [[NSString alloc] initWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:fileString baseURL:nil];
}

- (void)loadFromURLStr:(NSString *)urlStr
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.webView loadRequest:request];
}

#pragma mark -WebViewDelegate
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MessageAlertView showErrorMessage:error.localizedDescription];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MessageAlertView dismissHud];
    });
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MessageAlertView dismissHud];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
