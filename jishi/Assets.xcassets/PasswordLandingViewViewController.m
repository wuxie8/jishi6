//
//  PasswordLandingViewViewController.m
//  jishi
//
//  Created by Admin on 2017/3/8.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "PasswordLandingViewViewController.h"
#import "JPUSHService.h"

#import "User.h"
#define ViewHeight 40
#define ButtonWeight 100
@interface PasswordLandingViewViewController ()

@end

@implementation PasswordLandingViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title=@"账号密码登录";
    NSArray *arr=@[@"手机号",@"密码"];
    NSArray *arr1=@[@"请输入手机号",@"请输入密码"];
    self.view.backgroundColor=AppPageColor;
    for (int i=0; i<arr.count; i++) {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 20+i*ViewHeight, WIDTH, ViewHeight)];
        view.backgroundColor=[UIColor whiteColor];
        view.tag=100+i;
        [self.view addSubview:view];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 40)];
        label.textColor=[UIColor blackColor];
        [label setText:arr[i]];
        [view addSubview:label];
        
        UITextField *text=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 0, WIDTH-CGRectGetMaxX(label.frame)-i*100, 40)];
        text.placeholder=arr1[i];
        text.tag=1000+i;
        if (i==0) {
             text.keyboardType=UIKeyboardTypeNumberPad;
        }
       else
       {
            text.secureTextEntry = YES;
         text.keyboardType=UIKeyboardTypeDefault;
       }
        [view addSubview:text];
        
        UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(5, 39, WIDTH-10, 1)];
        backView.backgroundColor=PageColor;
        [view addSubview:backView];
        
        [self.view addSubview:view];
    }
    
    UIButton *loginButton=[[UIButton alloc]initWithFrame:CGRectMake(3, 20+2*ViewHeight+20, WIDTH-3*2, 50)];
    loginButton.backgroundColor=AppBackColor;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.clipsToBounds=YES;
    [loginButton addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];

    loginButton.layer.cornerRadius=5;
    [self.view addSubview:loginButton];
    
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(loginButton.frame)+10, WIDTH, 1)];
    backgroundView.backgroundColor=PageColor;
    
    [self.view addSubview:backgroundView];
    NSArray *arr2=@[@"注册账号",@"忘记密码"];
    for (int i=0; i<2; i++) {
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH/2-ButtonWeight+i*ButtonWeight, CGRectGetMaxY(backgroundView.frame)+20, ButtonWeight, 40)];
        [but setTitleColor:AppBackColor forState:UIControlStateNormal];
        but.tag=i;
        [but addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        

        [but setTitle:arr2[i] forState:UIControlStateNormal];
        [self.view addSubview:but];
    }
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH/2, CGRectGetMaxY(backgroundView.frame)+20+5, 1, 30)];
    lineView.backgroundColor=PageColor;
    [self.view addSubview:lineView];
    // Do any additional setup after loading the view.
}
-(void)loginClick
{
    
    
  
    NSMutableDictionary *diction=[NSMutableDictionary dictionary];
    for (int i=0; i<2; i++) {
        UIView *view1=[self.view viewWithTag:100+i];
        
        UITextField *text1=(UITextField *)[view1 viewWithTag:1000+i];
        [diction setObject:text1.text forKey:[NSString stringWithFormat:@"%d",i]];
    }
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                       diction[@"0"],@"username",
                       
                       diction[@"1"],@"password",
                       @"1",@"logintype",
                       nil];

    [[NetWorkManager sharedManager]postJSON:dologin parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *resultDic=(NSDictionary *)responseObject;
        
        if ([resultDic[@"status"] boolValue] ) {
            User *user=[[User alloc]init];
            user.token=resultDic[@"token"];
            user.uid=resultDic[@"uid"];
            user.username=resultDic[@"username"];
            Context.currentUser=user;
            if ( [NSKeyedArchiver archiveRootObject:Context.currentUser toFile:DOCUMENT_FOLDER(@"loginedUser")]) {
                //保存用户登录状态以及登录成功通知
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kIsLogin"];
                [JPUSHService setAlias:diction[@"0"] callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];

                if (self.backblock) {
                    self.backblock();
            }
                NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                                   resultDic[@"uid"],@"user_id",
                                   @"1",@"type",
                                   nil];
                [[NetWorkManager sharedManager]postJSON:@"&m=business&a=record" parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
                    
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    
                }];

                
            }
        }
        else
        {
            [MessageAlertView showErrorMessage:resultDic[@"info"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];

}
- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias {
    
    
}
-(void)click:(UIButton *)sender
{
    if (sender.tag==0) {
        if (self.registerblock) {
            self.registerblock();
        }
    }
    else
    {
        if (self.forgotblock) {
            self.forgotblock();
        }
    }
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
