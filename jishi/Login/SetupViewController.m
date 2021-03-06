//
//  SetupViewController.m
//  jishi
//
//  Created by Admin on 2017/3/29.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "SetupViewController.h"
#import "LoginViewController.h"
#import "AboutUsViewController.h"
#import "BusinessViewController.h"
#import "AddressVC.h"
@interface SetupViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong, nonatomic)UIView *footview;
@end

@implementation SetupViewController
{
    NSArray *arr;
     NSArray *array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"设置";
    self.view.backgroundColor=AppPageColor;
//    array=@[@"High praise",@"BusinessCooperation",@"AboutUs",@"feedback"];
     array=@[@"address",@"BusinessCooperation",@"AboutUs"];
//    arr=@[@"好评",@"商务合作",@"关于我们",@"意见反馈"];
    arr=@[@"为好友注册",@"商务合作",@"关于我们"];

    UITableView *tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, HEIGHT)];
    tab.delegate=self;
    tab.dataSource=self;
    tab.backgroundColor=AppPageColor;
    tab.tableFooterView=self.footview;
    [self.view addSubview:tab];
   
}

-(void)logout
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return arr.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.imageView.image=[UIImage imageNamed:array[indexPath.row]];
    cell.textLabel.text=arr[indexPath.row];
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            AddressVC *adress=[[AddressVC alloc]init];
            [self.navigationController pushViewController:adress animated:YES];
      
        }
            break;
        case 1:
        {
            BusinessViewController *Business=[[BusinessViewController alloc]init];
            [self.navigationController pushViewController:Business animated:YES];
        }
            break;
        case 2:
        {
            AboutUsViewController *aboutus=[[AboutUsViewController alloc]init];
            [self.navigationController pushViewController:aboutus animated:YES];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark 懒加载

-(UIView *)footview
{
    if (_footview==nil) {
        _footview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 80)];

        _footview.backgroundColor=AppPageColor;
        
        
        
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(0, 30, WIDTH, 50)];
        [but setTitle:@"退出登录" forState:UIControlStateNormal];
        [but setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        but.backgroundColor=[UIColor whiteColor];
        [but addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        [_footview addSubview:but];
    }
   
    return _footview;
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
