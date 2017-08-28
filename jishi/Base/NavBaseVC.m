//
//  NavBaseVC.m
//  xiaoyixiu
//
//  Created by 柯南 on 16/6/13.
//  Copyright © 2016年 柯南. All rights reserved.
//

#import "NavBaseVC.h"

@interface NavBaseVC ()

@end

@implementation NavBaseVC

- (void)setTitle:(NSString *)title
{
    self.navigationItem.title = title;
}

#ifdef __IPHONE_7_0
- (UIRectEdge)edgesForExtendedLayout
{
    return UIRectEdgeNone;
}
#endif

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self]; //移除通知
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([[self.navigationController viewControllers] count] == 1) {
        self.navigationItem.hidesBackButton = YES;
        self.navigationItem.leftBarButtonItem = nil;
    }
    else
    {
        UIButton *backButton = [[UIButton alloc] init];
        backButton.frame = CGRectMake(0, 0, 25, 34);
        [backButton setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
        [backButton addTarget: self action: @selector(backAction) forControlEvents: UIControlEventTouchUpInside];
        [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = backItem;
    }
    
    self.upSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(backAction)];
    [self.upSwipe setDirection: UISwipeGestureRecognizerDirectionRight];
    [self.upSwipe setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:self.upSwipe];
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"review"]) {
//        self.navigationController.navigationBar.barTintColor=AppgreenColor;
//        self.navigationController.navigationBar.tintColor=AppgreenColor;
//        UINavigationBar *appearance = [UINavigationBar appearance];
//        
//        [appearance setBarTintColor:AppgreenColor];
//    }
//    else{
    self.navigationController.navigationBar.barTintColor=AppButtonbackgroundColor;
    self.navigationController.navigationBar.tintColor=AppButtonbackgroundColor;
        UINavigationBar *appearance = [UINavigationBar appearance];
        
        [appearance setBarTintColor:AppButtonbackgroundColor];
//    }
    self.upSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(backAction)];
    [self.upSwipe setDirection: UISwipeGestureRecognizerDirectionRight];
    [self.upSwipe setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:self.upSwipe];
    
    self.navigationController.navigationBar.alpha = 1.0;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes =textAttrs;
    
   
}

- (void)backAction
{
    if ([self.navigationController.viewControllers count]>1) {
 
      
        [self.navigationController popViewControllerAnimated:NO];
    }
}

@end
