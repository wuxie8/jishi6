//
//  WebVC.h
//  xiaoyixiu
//
//  Created by hanzhanbing on 16/6/19.
//  Copyright © 2016年 柯南. All rights reserved.
//

#import "NavBaseVC.h"

@interface WebVC : NavBaseVC<UIWebViewDelegate>

@property(nonatomic, strong)NSString *navTitle;
@property(nonatomic, strong)UIWebView *webView;

/**
 *  加载本地文件(html/txt)
 *
 *  @param filePath 程序文件夹下文件路径
 */
- (void)loadLocalFile:(NSString *)filePath;

/**
 *  通过网络加载内容
 *
 *  @param urlStr url字符串
 */
- (void)loadFromURLStr:(NSString *)urlStr;

@end
