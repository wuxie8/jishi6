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
@interface AmountClassificationViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation AmountClassificationViewController
{
    NSArray *arr;
    NSArray *array;
      NSArray *amountarray;
    NSArray *describearray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"极速贷款";
    self.view.backgroundColor=AppPageColor;
   arr=@[@"speed",@"PopularLoan",@"StudentLoan"];
     array=@[@"极速微额贷款",@"热门极速贷",@"学生贷"];
     amountarray=@[@"2000元以下",@"2000-10000元",@"1万-10万"];
    describearray=@[@"有手机服务密码就能贷 \n微额快速，闪电放款",@"有手机服务密码就能贷 \n 1分钟申请，10分钟放款",@"放款快，学生的最爱 \n额度高，利率低，如你所想"];
    UITableView *tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 10, WIDTH, HEIGHT)];
    tab.delegate=self;
    tab.dataSource=self;
    tab.backgroundColor=AppPageColor;
    [self.view addSubview:tab];
    // Do any additional setup after loading the view.
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

    LoanClickViewController *loanclick=[[LoanClickViewController alloc]init];
    loanclick.location=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    [self.navigationController pushViewController:loanclick animated:YES];
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
