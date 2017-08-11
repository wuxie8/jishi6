//
//  CertificationViewController.m
//  haitian
//
//  Created by Admin on 2017/4/18.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "CertificationViewController.h"
#import "IdVerificationViewController.h"
#import "BankCardAuthenticationViewController.h"
//#import "DataSubmittedViewController.h"
#import <ZMCreditSDK/ALCreditService.h>

@interface CertificationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)UIView*headView;

@property(strong, nonatomic)UIView*footView;

@end

@implementation CertificationViewController
{
    NSArray *arr1;
    NSArray *arr2;
    NSArray *arr3;
    NSMutableDictionary *dic;
    UITableView *tab;

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"资料提交";
    arr1=@[@"身份认证",@"芝麻信用",@"绑定银行卡"];
    arr2=@[@"AuthenticationImage",@"CreditSesame",@"BindCreditCard"];
    arr3=@[@"待认证",@"待认证",@"待认证"];
    NSNumber *num1=[NSNumber numberWithBool:NO];
dic=[NSMutableDictionary dictionaryWithObjectsAndKeys:
                  num1 , @"0",
                    num1, @"1",
                   [NSNumber numberWithBool:NO], @"2",nil];
    tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    tab.delegate=self;
    tab.dataSource=self;
    tab.tableHeaderView=self.headView;
    tab.tableFooterView=self.footView;
    [self.view addSubview:tab];
       // Do any additional setup after loading the view.
}
-(UIView *)headView
{
    if (!_headView) {
        _headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 80)];
        _headView.backgroundColor=[UIColor redColor];
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 80)];
        imageView.image=[UIImage imageNamed:@"DataSubmitted-1"];
        [_headView addSubview:imageView];
    }
    return _headView;
}
-(UIView *)footView
{
    if (!_footView) {
        _footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 80)];
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(10, 20, WIDTH-20, 40 )];
        [but setTitle:@"下一步" forState:UIControlStateNormal];
        [but addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
        but.layer.cornerRadius =  20;
        //            //将多余的部分切掉
        but.layer.masksToBounds = YES;
        
//        but.enabled=NO;
        but.backgroundColor=AppPageColor;
        [_footView addSubview:but];
    }
    return _footView;
}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//   return @"*温馨提示：请填写真实有效信息以获得更高信用额度";
//}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    headerView.backgroundColor=AppBackColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, tableView.frame.size.width-20*2-40, 20)];
    label.textAlignment = NSTextAlignmentLeft;  //文本对齐方式
    [label setBackgroundColor:[UIColor clearColor]];
    label.adjustsFontSizeToFitWidth=YES;
    label.text=@"*温馨提示：请填写真实有效信息以获得更高信用额度";
    [headerView setBackgroundColor:[UIColor clearColor]];
    [headerView addSubview:label];
    return  headerView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.imageView.image=[UIImage imageNamed:arr2[indexPath.row]];
    cell.textLabel.text=arr1[indexPath.row];
    if ([(NSNumber *)[dic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]boolValue]) {
        cell.detailTextLabel.text=@"已认证";

    }
    else
    {
        cell.detailTextLabel.text=@"待认证";

    }
    cell.detailTextLabel.textColor=[UIColor blueColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            IdVerificationViewController *idver=[IdVerificationViewController new];
            [idver setClickBlock:^(){
                // remove the transform animation if the animation finished and wasn't interrupted
                [dic setValue:[NSNumber numberWithBool:YES] forKey:@"0"];
                [tab reloadData];
                
            }];
            [self.navigationController pushViewController:idver animated:YES];
        }
            break;
        case 1:
        {
            [self launchSDK];
        }
            break;
        case 2:
        {
            [self.navigationController pushViewController:[BankCardAuthenticationViewController new] animated:YES];
        }
            break;
        default:
            break;
    }
}
- (void)launchSDK {
    NSDictionary *dic1=[NSDictionary dictionaryWithObjectsAndKeys:
                        Context.currentUser.username,@"mobileNo",
                        
                        nil];
    
    NSString *string=[self convertToJsonData:dic1];
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        string,@"identity_param",
                        @"1",@"identity_type",
                        nil];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    [manager.requestSerializer setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
    NSString *urlStr = [NSString stringWithFormat:@"http://app.jishiyu11.cn/index.php?g=app&m=alipay&a=signEncrypt"];
    
    [manager GET:urlStr parameters:dic2 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"]isEqualToString:@"0000"]) {
            NSDictionary *diction=responseObject[@"data"];
            NSString *params=diction[@"params"];
            NSString *sign=diction[@"sign"];
            
            
            [[ALCreditService sharedService] queryUserAuthReq:@"1002755" sign:sign params:params extParams:nil selector:@selector(result:) target:self];
            self.navigationController.navigationBar.barTintColor=AppButtonbackgroundColor;
            self.navigationController.navigationBar.tintColor=AppButtonbackgroundColor;
            
            
            self.navigationController.navigationBar.alpha = 1.0;
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            self.navigationController.navigationBar.barTintColor = AppButtonbackgroundColor;
            
            NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
            textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
            self.navigationController.navigationBar.titleTextAttributes =textAttrs;
            
            UINavigationBar *appearance = [UINavigationBar appearance];
            
            [appearance setBarTintColor:AppButtonbackgroundColor];
        }
        else
        {
            [MessageAlertView showErrorMessage:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}
- (void)result:(NSMutableDictionary*)diction{
    
    NSString *params=[UtilTools URLEncodedString:diction[@"params"]];
    NSString *sign=[UtilTools URLEncodedString:diction[@"sign"]];
    NSDictionary *dic1=[NSDictionary dictionaryWithObjectsAndKeys:
                        Context.currentUser.uid,@"uid",
                        sign,@"sign",
                        params,@"params",
                        nil];
    [[NetWorkManager sharedManager]postJSON:@"http://app.jishiyu11.cn/index.php?g=app&m=alipay&a=anyAuthorize" parameters:dic1 success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"]isEqualToString:@"0000"]) {
            [MessageAlertView showSuccessMessage:@"认证成功"];
//            Context.currentUser.zhima_auth=YES;
//            [NSKeyedArchiver archiveRootObject:Context.currentUser toFile:DOCUMENT_FOLDER(@"loginedUser")];
            [dic setValue:[NSNumber numberWithBool:YES] forKey:@"1"];
            [tab reloadData];
            
        }
        else
        {
          
            Context.currentUser.zhima_auth=NO;
            [NSKeyedArchiver archiveRootObject:Context.currentUser toFile:DOCUMENT_FOLDER(@"loginedUser")];
        }
    
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];
    
    
    
    
}

-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

#pragma mark 实现方法
-(void)nextStep
{
//    [self.navigationController pushViewController:[DataSubmittedViewController new] animated:YES];
    [MessageAlertView showErrorMessage:@"已提交审核"];
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
