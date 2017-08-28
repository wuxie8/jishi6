//
//  LoginVC.m
//  jishi
//
//  Created by Admin on 2017/8/1.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "LoginVC.h"
#import "LandingDynamicViewControllerViewController.h"
#import "PasswordLandingViewViewController.h"
#import "OptionBarController.h"
#import "RegisterVC.h"
#import "ForgotPasswordVC.h"
#import "LandingDynamicViewControllerViewController.h"
#import "JPUSHService.h"
#import "AppDelegate.h"

#import "User.h"

#define ViewHeight 40
#define ButtonWeight 100
#define FontSize 14
@interface LoginVC ()


@property(nonatomic, assign)CGFloat viewBottom;     //textField的底部

@end

@implementation LoginVC
{
    UIButton *but;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=  @"手机密码登录";
    NSArray *arr=@[@"手机号",@"密码"];
    NSArray *arr1=@[@"请输入手机号",@"请输入密码"];
    self.view.backgroundColor=AppPageColor;
    UIImageView * image=[[UIImageView  alloc]initWithFrame:CGRectMake(0, 64, WIDTH, ButtonWeight)];
    [image setImage:[UIImage imageNamed:@"LoginBackGround"]];
    image.contentMode=UIViewContentModeScaleAspectFill;
    [self.view addSubview:image];
    
    for (int i=0; i<arr.count; i++) {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(image.frame) +ViewHeight+i*ViewHeight, WIDTH, ViewHeight)];
        view.tag=100+i;
        view.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:view];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 40)];
        label.textColor=[UIColor blackColor];
        [label setText:arr[i]];
        [view addSubview:label];
        
        UITextField *text=[[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 0, WIDTH-CGRectGetMaxX(label.frame)-i*100, 40)];
        text.placeholder=arr1[i];
        text.keyboardType= UIKeyboardTypeNumberPad;
        text.delegate=self;
        text.tag=1000+i;
        [view addSubview:text];
        
        UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(5, 39, WIDTH-10, 1)];
        backView.backgroundColor=PageColor;
        [view addSubview:backView];
        if (i==arr.count-1) {
//            but=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-90, 0, 90, ViewHeight)];
//            but.backgroundColor=AppButtonbackgroundColor;
//            [but addTarget:self action:@selector(verificationCode) forControlEvents:UIControlEventTouchUpInside];
//            [but setTitle:@"获取验证码" forState:UIControlStateNormal];
//            but.titleLabel.font    = [UIFont systemFontOfSize:  FontSize];
//            
//            [view addSubview:but];
            text.keyboardType= UIKeyboardTypeDefault;
            text.secureTextEntry=YES;
        }
        [self.view addSubview:view];
    }
    
    UIButton *loginButton=[[UIButton alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(image.frame) +ViewHeight+2*ViewHeight+20, WIDTH-10*2, 50)];
    loginButton.backgroundColor=AppButtonbackgroundColor;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    loginButton.clipsToBounds=YES;
    
    loginButton.layer.cornerRadius=5;
    [self.view addSubview:loginButton];
    
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(loginButton.frame)+10, WIDTH, 1)];
    backgroundView.backgroundColor=PageColor;
    
    [self.view addSubview:backgroundView];
    NSArray *arr2=@[@"注册账号",@"忘记密码"];
    for (int i=0; i<2; i++) {
        UIButton *but1=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH/2-ButtonWeight+i*ButtonWeight, CGRectGetMaxY(backgroundView.frame)+20, ButtonWeight, 40)];
        [but1 setTitleColor:AppBackColor forState:UIControlStateNormal];
        but1.tag=i;
        [but1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        but1.titleLabel.font    = [UIFont systemFontOfSize:  15];
        [but1 setTitle:arr2[i] forState:UIControlStateNormal];
        [self.view addSubview:but1];
    }
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH/2, CGRectGetMaxY(backgroundView.frame)+20+5, 1, 30)];
    lineView.backgroundColor=PageColor;
    [self.view addSubview:lineView];
//    UIButton *but1=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH/2-ButtonWeight/2, CGRectGetMaxY(backgroundView.frame)+20, ButtonWeight, 40)];
//    [but1 setTitleColor:AppBackColor forState:UIControlStateNormal];
//    but1.tag=0;
//    [but1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//    but1.titleLabel.font    = [UIFont systemFontOfSize:  18];
//    [but1 setTitle:@"注册账号" forState:UIControlStateNormal];
//    [self.view addSubview:but1];
    
    
}
- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias {
    
    
}
-(void)verificationCode
{
    
    UIView *view1=[self.view viewWithTag:100];
    
    UITextField *text1=(UITextField *)[view1 viewWithTag:1000];
    if (text1.text.length==0) {
        [MessageAlertView showErrorMessage:@"请输入手机号"];
        return;
    }
    else if (text1.text.length!=11)
    {
        [MessageAlertView showErrorMessage:@"请输入正确的手机号"];
        return;
    }
    __block NSString * string=text1.text;
    __block NSInteger second = 60;
    //全局队列    默认优先级
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //定时器模式  事件源
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    //NSEC_PER_SEC是秒，＊1是每秒
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), NSEC_PER_SEC * 1, 0);
    //设置响应dispatch源事件的block，在dispatch源指定的队列上运行
    dispatch_source_set_event_handler(timer, ^{
        //回调主线程，在主线程中操作UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second >= 0) {
                [but setTitle:[NSString stringWithFormat:@"%ld秒",(long)second] forState:UIControlStateNormal];
                second--;
                [but setEnabled:NO];
                but.alpha=0.4;
                but.backgroundColor=[UIColor grayColor];
            }
            else
            {
                //这句话必须写否则会出问题
                dispatch_source_cancel(timer);
                [but setTitle:@"获取验证码" forState:UIControlStateNormal];
                [but setEnabled:YES];
                but.alpha=1;
                but.backgroundColor=AppButtonbackgroundColor;
            }
        });
    });
    //启动源
    dispatch_resume(timer);
    [self sendCode:string];
    
}
-(void)sendCode:(NSString *)str
{
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                       str,@"mobile",
                       
                       nil];
    
    [[NetWorkManager sharedManager]postJSON:verificationCodeLogin parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic=(NSDictionary *)responseObject;
        if ([dic[@"status"]boolValue]) {
            [MessageAlertView showSuccessMessage:@"发送成功"];
            
        }
        else
        {
            [MessageAlertView showErrorMessage:[NSString stringWithFormat:@"%@",dic[@"info"]]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
}

-(void)loginClick
{
    
    
//       [UIApplication sharedApplication].keyWindow.rootViewController = [AppDelegate setTabBarController];
    UIView *view1=[self.view viewWithTag:100];
    
    UITextField *text1=(UITextField *)[view1 viewWithTag:1000];
    
    if (text1.text.length==0) {
        [MessageAlertView showErrorMessage:@"请输入手机号"];
        return;
    }
    else if (text1.text.length!=11)
    {
        [MessageAlertView showErrorMessage:@"请输入正确的手机号"];
        return;
    }
    UIView *view2=[self.view viewWithTag:101];
    
    UITextField *text2=(UITextField *)[view2 viewWithTag:1001];
    if ([UtilTools isBlankString:text2.text]) {
        [MessageAlertView showErrorMessage:@"请输入验证码"];
        return;
    }

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
        if ([resultDic[@"status"]boolValue]) {
            User *user=[[User alloc]init];
            user.token=resultDic[@"token"];
            user.uid=resultDic[@"uid"];
            user.username=resultDic[@"username"];
            Context.currentUser=user;
            if ( [NSKeyedArchiver archiveRootObject:Context.currentUser toFile:DOCUMENT_FOLDER(@"loginedUser")]) {
                //保存用户登录状态以及登录成功通知
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kIsLogin"];
                [JPUSHService setAlias:diction[@"0"] callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
                       [UIApplication sharedApplication].keyWindow.rootViewController = [AppDelegate setTabBarController];

               
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
-(void)click:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
        {RegisterVC *registerVC=[RegisterVC new];
            registerVC.isHidden=YES;

            [self.navigationController pushViewController:registerVC animated:YES];
        }
            break;
        case 1:
            [self.navigationController pushViewController:[ ForgotPasswordVC new] animated:YES];
            
            break;
        default:
            break;
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