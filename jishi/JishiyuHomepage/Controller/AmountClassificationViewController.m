//
//  AmountClassificationViewController.m
//  jishi
//
//  Created by Admin on 2017/3/29.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "AmountClassificationViewController.h"
#import "AmountTableViewCell.h"
#import "LoanClickViewController.h"
#import "LoanDetailsViewController.h"
#import "WebVC.h"
@interface AmountClassificationViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation AmountClassificationViewController
{
    NSArray *arr;
    NSArray *array;
      NSArray *amountarray;
    NSArray *describearray;
    NSMutableArray *productArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"极速贷款";
    self.view.backgroundColor=AppPageColor;
   arr=@[@"speed",@"PopularLoan",@"StudentLoan"];
     array=@[@"极速微额贷款",@"热门极速贷",@"学生贷"];
     amountarray=@[@"2000元以下",@"2000-10000元",@"1万-10万"];
    describearray=@[@"有手机服务密码就能贷 \n微额快速，闪电放款",@"有手机服务密码就能贷 \n 1分钟申请，10分钟放款",@"放款快，学生的最爱 \n额度高，利率低，如你所想"];
    [self getData];
    UITableView *tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 10, WIDTH, HEIGHT)];
    tab.delegate=self;
    tab.dataSource=self;
    tab.backgroundColor=AppPageColor;
    [self.view addSubview:tab];
    
    
   

    // Do any additional setup after loading the view.
}
-(void)getData
{
    productArray=[NSMutableArray array];
    for (int i=0; i<3; i++) {
        ProductModel *pro=[[ProductModel alloc]init];
        
            pro.smeta=@"icon";
            
//            pro.post_title=array[location];
       
        
//        pro.link=diction[@"link"];
//        pro.edufanwei=diction[@"edufanwei"];
//        pro.qixianfanwei=diction[@"qixianfanwei"];
//        pro.shenqingtiaojian=diction[@"shenqingtiaojian"];
//        pro.zuikuaifangkuan=diction[@"zuikuaifangkuan"];
        switch (i) {
            case 0:
            {
                pro.edufanwei=@"500-2000";
                pro.qixianfanwei=@"1-6月";
                pro.shenqingtiaojian=@"身份证";
                pro.zuikuaifangkuan=@"立即放款";
                        pro.post_title=@"小额贷款";
pro.post_hits=@"957714";
                pro.feilv=@"0.5%月";
                pro.fv_unit=@"2";
                pro.tagsArray=@[@"有公积金就能贷",@"用淘宝贷款"];

                pro.qx_unit=@"1";

            }
                break;
            case 1:
            {
                pro.edufanwei=@"2000-10000";
                pro.qixianfanwei=@"3-36月";
                pro.shenqingtiaojian=@"身份证";
                pro.zuikuaifangkuan=@"立即放款";
                pro.post_title=@"极速贷款";
                pro.post_hits=@"1057714";
                pro.feilv=@"0.5%";
                pro.fv_unit=@"1";
                pro.tagsArray=@[@"有公积金就能贷"];
                pro.qx_unit=@"1";

                
            }
                break;
            case 2:
            {
                pro.edufanwei=@"1000-3000";
                pro.qixianfanwei=@"6-12月";
                pro.shenqingtiaojian=@"身份证";
                pro.zuikuaifangkuan=@"立即放款";
                pro.post_title=@"极速贷款";
                pro.post_hits=@"1057714";
                pro.feilv=@"0.5%";
                pro.fv_unit=@"1";
                pro.tagsArray=@[@"有身份证就能贷",@"用淘宝贷款"];
                
                pro.qx_unit=@"1";

            }
                break;
            default:
                break;
        }
                pro.post_excerpt=@"芝麻分620，借款5000元";

//        pro.post_hits=diction[@"post_hits"];
//        pro.feilv=diction[@"feilv"];
//        pro.productID=diction[@"id"];
//        pro.post_excerpt=diction[@"post_excerpt"];
//        
//        pro.fv_unit=diction[@"fv_unit"];
//        NSArray *tags=diction[@"tags"];
//        NSMutableArray *tagsArray=[NSMutableArray array];
//        for (NSDictionary *dic in tags) {
//            [tagsArray addObject:dic[@"tag_name"]];
//        }
//        pro.tagsArray=tagsArray;
//        pro.qx_unit=diction[@"qx_unit"];
        [productArray addObject:pro];
    }
   
    

}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 120;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   AmountTableViewCell *cell=[[AmountTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
      cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    cell.image.image=[UIImage imageNamed:arr[indexPath.row]];
    cell.titleLabel.text=array[indexPath.row];
    cell.post_hits_Label.text=amountarray[indexPath.row];
    cell.feliv_Label.text=describearray[indexPath.row];
    cell.backgroundColor=AppPageColor;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"review"]) {
        ProductModel  *product=[productArray objectAtIndex:indexPath.row];
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                           product.productID,@"id",
                           Context.currentUser.uid,@"uid",
                           appNo,@"channel",
                           
                           nil];
        
        [[NetWorkManager sharedManager]getJSON:@"http://app.jishiyu11.cn/index.php?g=app&m=product&a=hits" parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            
        }];

    LoanDetailsViewController *load=[[LoanDetailsViewController alloc]init];
    load.hidesBottomBarWhenPushed=YES;
        load.product=product;
   
    [self.navigationController pushViewController:load animated:YES];
    }
    else{
    LoanClickViewController *loanclick=[[LoanClickViewController alloc]init];
    loanclick.hidesBottomBarWhenPushed=YES;
    loanclick.location=[NSString stringWithFormat:@"%ld",(long)indexPath.row+19];
    [self.navigationController pushViewController:loanclick animated:YES];
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
