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
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64)];
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
-(void)viewWillAppear:(BOOL)animated
{
    UIButton *backButton = [[UIButton alloc] init];
    backButton.frame = CGRectMake(0, 0, 25, 34);
    [backButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    [backButton addTarget: self action: @selector(backAction) forControlEvents: UIControlEventTouchUpInside];
    [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
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
    self.webView.scalesPageToFit=YES;
}

- (void)loadFromURLStr:(NSString *)urlStr
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.webView loadRequest:request];
    self.webView.scalesPageToFit=YES;
    _webView.scrollView.scrollEnabled = YES;

}
-(void)backAction
{

    if (self.webView.canGoBack==YES) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark -WebViewDelegate


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MessageAlertView showErrorMessage:error.localizedDescription];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //定义JS字符串
//    NSString *script = [NSString stringWithFormat: @"var script = document.createElement('script');"
//                        "script.type = 'text/javascript';"
//                        "script.text = \"function ResizeImages() { "
//                        "var myimg;"
//                        "var maxwidth=%f;" //屏幕宽度
//                        "for(i=0;i <document.images.length;i++){"
//                        "myimg = document.images[i];"
//                        "myimg.height = maxwidth / (myimg.width/myimg.height);"
//                        "myimg.width = maxwidth;"
//                        "}"
//                        "}\";"
//                        "document.getElementsByTagName('p')[0].appendChild(script);",WIDTH];
//    
//    //添加JS
//    [webView stringByEvaluatingJavaScriptFromString:script];
//    
//    //添加调用JS执行的语句
//    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    [webView setScalesPageToFit:YES];
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
