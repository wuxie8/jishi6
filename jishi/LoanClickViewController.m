//
//  LoanClickViewController.m
//  jishi
//
//  Created by Admin on 2017/3/30.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "LoanClickViewController.h"
#import "ProductModel.h"
#import "LoanClassification.h"
#import "JishiyuDetailsViewController.h"
#define SectionHeight 90
@interface LoanClickViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(strong, nonatomic)NSMutableArray*productArray;
@end

@implementation LoanClickViewController

{
    UITableView *tab;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTableView];
    self.title=@"极速微贷";
    
    [self loadData];
   
}
-(void)loadData
{
    

    
    
    
        NSDictionary*dic1=@{@"page":@"1",
                            @"count":@"6"};
        NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                           appcode,@"code",
                           @"1.0.0",@"version",
                           dic1,@"PAGINATION",
//                            @"1",@"career",
//                          self.business_money,@"money",
//                           self.business_time,@"time",
                          self.location,@"type",
                           nil];
    
    NSArray *array=@[@"小僧-社保贷",@"小僧-公积金贷",@"小僧-保单贷",@"小僧-供房贷",@"小僧-税金贷",@"小僧-学信贷"];
    
    self.productArray=nil;
  
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer   serializer];
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVERE,filter]  parameters:dic2 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"status"]boolValue]) {
            NSArray *arr=dic[@"list"];
            for (int i=0; i<arr.count; i++) {
                NSDictionary *diction=arr[i];
                ProductModel *pro=[[ProductModel alloc]init];
                
                if ([[NSUserDefaults standardUserDefaults] boolForKey:@"review"]) {
                      pro.smeta=@"icon";
                    
                                    int location=i%array.count;
                                    pro.post_title=array[location];
                }
                else
                {
                    NSString *jsonString=diction[@"smeta"];
                    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
                    NSError *err;
                    NSDictionary *imagedic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                             options:NSJSONReadingMutableContainers
                                                                               error:&err];
                   pro.smeta=imagedic[@"thumb"];
                      pro.post_title=diction[@"post_title"];
                }

                
                pro.link=diction[@"link"];
                pro.edufanwei=diction[@"edufanwei"];
                pro.qixianfanwei=diction[@"qixianfanwei"];
                pro.shenqingtiaojian=diction[@"shenqingtiaojian"];
                pro.zuikuaifangkuan=diction[@"zuikuaifangkuan"];
                

                pro.post_hits=diction[@"post_hits"];
                pro.feilv=diction[@"feilv"];
                [self.productArray addObject:pro];
                
            }
            
            [tab reloadData];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
   
    
    
}
-(void)loadTableView
{
    
    tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64)];
    tab.delegate=self;
    tab.dataSource=self;
    [self.view addSubview:tab];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    return SectionHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString *cell=@"cell";
    ProductModel *pro=[self.productArray objectAtIndex:indexPath.row];
    LoanClassification *loancell=[tableView dequeueReusableCellWithIdentifier:cell];
    
    if (!loancell) {
        loancell=[[LoanClassification alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell];
        loancell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    [loancell setProduct:pro];
    return loancell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{ProductModel *pro=[self.productArray objectAtIndex:indexPath.row];
    JishiyuDetailsViewController *jishiyu=[[JishiyuDetailsViewController alloc]init];
    jishiyu.product=pro;
    [self.navigationController pushViewController:jishiyu animated:YES];
}
-(NSMutableArray *)productArray
{
    if (!_productArray) {
        _productArray=[NSMutableArray array];
    }
    return _productArray;
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
