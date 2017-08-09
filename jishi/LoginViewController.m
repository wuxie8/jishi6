//
//  LoginViewController.m
//  jishi
//
//  Created by Admin on 2017/3/8.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "LoginViewController.h"
#import "LandingDynamicViewControllerViewController.h"
#import "PasswordLandingViewViewController.h"
#import "OptionBarController.h"
#import "RegisterVC.h"
#import "ForgotPasswordVC.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

#ifdef __IPHONE_7_0
- (UIRectEdge)edgesForExtendedLayout
{
    return UIRectEdgeNone;
}
#endif
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.hidden) {
        self.navigationItem.hidesBackButton =YES;
        self.navigationItem.leftBarButtonItem=nil;
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kIsLogin"]) {
        [self.navigationController popViewControllerAnimated:NO];
        
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"登录";
    

    LandingDynamicViewControllerViewController *landing=[[ LandingDynamicViewControllerViewController alloc]init];
    [landing setRegisterblock:^()
     {
         RegisterVC *registerVC=[[RegisterVC alloc]init];
         registerVC.isHidden=NO;
         [registerVC setBackblock:^()
          {
              if (self.tabBarController.selectedIndex==0) {
                  [self.navigationController popViewControllerAnimated:NO];
              }
              self.tabBarController.selectedIndex = 0;
          }];
         [self.navigationController pushViewController:registerVC animated:YES];
     }];
    
    [landing setForgotblock:^()
     {
         
         ForgotPasswordVC *forgot=[[ForgotPasswordVC alloc]init];
         [self.navigationController pushViewController:forgot animated:YES];
     }];
    [landing setBackblock:^()
     {
         if (self.tabBarController.selectedIndex==0) {
             [self.navigationController popViewControllerAnimated:NO];
         }
         self.tabBarController.selectedIndex = 0;
     }];
    
    PasswordLandingViewViewController *password=[[PasswordLandingViewViewController alloc]init];
    [password setRegisterblock:^()
     {
         RegisterVC *registerVC=[[RegisterVC alloc]init];
         registerVC.isHidden=NO;

         [registerVC setBackblock:^()
          {
              if (self.tabBarController.selectedIndex==0) {
                  [self.navigationController popViewControllerAnimated:NO];
              }
              self.tabBarController.selectedIndex = 0;
          }];
         [self.navigationController pushViewController:registerVC animated:YES];
     }];
    
    [password setForgotblock:^()
     {
         ForgotPasswordVC *forgot=[[ForgotPasswordVC alloc]init];
         [self.navigationController pushViewController:forgot animated:YES];
     }];
    [password setBackblock:^()
     {
       
         if (self.tabBarController.selectedIndex==0) {
             [self.navigationController popViewControllerAnimated:NO];
         }
         self.tabBarController.selectedIndex = 0;
     }];
    
    NSArray *controllersArr = @[landing, password];
    
    OptionBarController *optionBar = [[OptionBarController alloc] initWithSubViewControllers:controllersArr andParentViewController:self andshowSeperateLine:NO];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"review"]) {
        optionBar.linecolor=AppgreenColor;
    }
    else{
        optionBar.linecolor=AppBackColor;
        
    }
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    // Do any additional setup after loading the view.
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
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
