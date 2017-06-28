//
//  LoanClasssificationVC.m
//  jishi
//
//  Created by Admin on 2017/3/14.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "LoanClasssificationVC.h"
#import "ProductModel.h"
#import "LoanClassification.h"
#import "JishiyuDetailsViewController.h"
#import "LoanDetailsViewController.h"
#define SectionHeight 90
@interface LoanClasssificationVC ()<UITableViewDataSource,UITableViewDelegate>
@property(strong, nonatomic)NSMutableArray*productArray;
@end

@implementation LoanClasssificationVC
{
    UITableView *tab;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTableView];
    self.title=@"极速微贷";
    
    [self loadData];
    // Do any additional setup after loading the view.
}
-(void)loadData
{
    
    
    self.productArray=nil;
 
 NSArray *array=@[@"帮帮-社保贷",@"帮帮-公积金贷",@"帮帮-保单贷",@"帮帮-供房贷",@"帮帮-税金贷",@"帮帮-学信贷"];
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                      appcode,@"code",
                       @"1.0.0",@"version",
                       @"1",@"page",
                       nil];
    [[NetWorkManager sharedManager]postNoTipJSON:loan parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic=(NSDictionary *)responseObject;
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
                pro.productID=diction[@"id"];
                pro.post_excerpt=diction[@"post_excerpt"];
                NSArray *tags=diction[@"tags"];
                NSMutableArray *tagsArray=[NSMutableArray array];
                for (NSDictionary *dic in tags) {
                    [tagsArray addObject:dic[@"tag_name"]];
                }
                pro.tagsArray=tagsArray;
                pro.fv_unit=diction[@"fv_unit"];
                
                pro.qx_unit=diction[@"qx_unit"];
                [self.productArray addObject:pro];
                
            }          
            
            [tab reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
               
        
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
    LoanDetailsViewController *load=[[LoanDetailsViewController alloc]init];
    load.hidesBottomBarWhenPushed=YES;
    
    load.product=pro;
    [self.navigationController pushViewController:load animated:YES];

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
