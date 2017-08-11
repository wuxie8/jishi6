//
//  BBSViewController.m
//  jishi
//
//  Created by Admin on 2017/7/28.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "BBSViewController.h"

@interface BBSViewController ()<UIWebViewDelegate>
@property(nonatomic, strong)UIWebView *webView;

@end

@implementation BBSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"论坛";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://114.215.210.61:10080/bbs/forum.php"]];
    [self.webView loadRequest:request];
    self.webView.scalesPageToFit=YES;
    _webView.scrollView.scrollEnabled = YES;
    [self.view addSubview:self.webView];

    // Do any additional setup after loading the view.
}
- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64)];
        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
        _webView.delegate = self;
    }
    return _webView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
