//
//  MineViewController.m
//  jishiyu.com
//
//  Created by Admin on 2017/3/6.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "MineViewController.h"

#import "LoginViewController.h"
#define InitialHeight  64
@interface MineViewController ()

@end

@implementation MineViewController

{
    UIButton *but;
    UILabel *label;

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kIsLogin"]) {
         [but setTitle:@"退出登录" forState:UIControlStateNormal];
         [label setText:Context.currentUser.username];
     }
    else
    {
     [but setTitle:@"登录" forState:UIControlStateNormal];
        [label setText:nil];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我";
    
    self.view.backgroundColor=AppPageColor;
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 60)];
    view.backgroundColor=[UIColor whiteColor ];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    image.image=[UIImage imageNamed:@"Mine"];
    [view addSubview:image];
    
   label =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(image.frame)+20, 10, 300, 40)];
    [view addSubview:label];
   but=[[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame)+20, WIDTH, 40)];
    
    [but addTarget:self action:@selector(denglu) forControlEvents:UIControlEventTouchUpInside];
    but.backgroundColor=[UIColor whiteColor];
    [but setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:view];
    [self.view addSubview:but];
}

-(void)denglu
{
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kIsLogin"]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kIsLogin"];
    
     Context.currentUser = nil;
        //用户信息归档
        [NSKeyedArchiver archiveRootObject:Context.currentUser toFile:DOCUMENT_FOLDER(@"loginedUser")];
    }
       LoginViewController *login=[[LoginViewController alloc]init];
    login.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:login animated:YES];
   
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
