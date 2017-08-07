//
//  OtherContactsViewController.m
//  haitian
//
//  Created by Admin on 2017/6/21.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "OtherContactsViewController.h"
#import "AddressVC.h"
#import "AuditViewController.h"
@interface OtherContactsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong, nonatomic)UIView *footView;
@end

@implementation OtherContactsViewController
{
    NSArray *arr;
}
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(complete)];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    self.navigationItem.rightBarButtonItem = backItem;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self getList];
    arr=@[@"父亲",@"手机号码",@"母亲",@"手机号码"];
    self.title=@"联系人";
    UITableView *tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    tab.delegate=self;
    tab.dataSource=self;
    
    [self.view addSubview:tab];
    [self.view addSubview:self.footView];
    // Do any additional setup after loading the view.
}
-(UIView *)footView
{
    if (!_footView) {
        _footView=[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-60-64, WIDTH, 60)];
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, WIDTH-20, 40 )];
        [but setTitle:@"下一步" forState:UIControlStateNormal];
        [but addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
        but.layer.cornerRadius =  20;
        //            //将多余的部分切掉
        but.layer.masksToBounds = YES;
        
        //        but.enabled=NO;
        but.backgroundColor=AppButtonbackgroundColor;
        [_footView addSubview:but];
    }
    return _footView;
}
-(void)nextStep
{
    [self.navigationController pushViewController:[AuditViewController new] animated:YES];

}
//-(void)getList
//{
//    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
//                        Context.currentUser.uid,@"uid",
//                        nil];
//    [[NetWorkManager sharedManager]postNoTipJSON:[NSString stringWithFormat:@"%@&m=userdetail&a=other_list",SERVERE] parameters:dic2 success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        if ([responseObject[@"code"]isEqualToString:@"0000"]) {
//            NSArray *array1=[[responseObject objectForKey:@"data"]objectForKey:@"data"];
//            NSDictionary *dictionary=[array1 firstObject];
//            if (![UtilTools isBlankString:dictionary[@"kinsfolk_name"]]) {
//               UITextField *label=[self.view viewWithTag:100];
//                label.text=dictionary[@"kinsfolk_name"];
//            }
//            if (![UtilTools isBlankString:dictionary[@"kinsfolk_mobile"]]) {
//               UITextField *label=[self.view viewWithTag:101];
//                label.text=dictionary[@"kinsfolk_mobile"];
//            }
//            if (![UtilTools isBlankString:dictionary[@"urgency_name"]]) {
//               UITextField *label=[self.view viewWithTag:102];
//                label.text=dictionary[@"urgency_name"];
//            }
//            if (![UtilTools isBlankString:dictionary[@"urgency_mobile"]]) {
//               UITextField *label=[self.view viewWithTag:103];
//                label.text=dictionary[@"urgency_mobile"];
//            }
//                   }
//        else
//        {
//        }
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        
//    }];
//    
//    
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor whiteColor];
    cell.textLabel.text=arr[indexPath.row];
//    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH-80, 10,80, cell.frame.size.height-20)];
//    label.tag=100+indexPath.row;
//    label.textAlignment=NSTextAlignmentRight;
//    label.font=[UIFont systemFontOfSize:14];
//    [cell.contentView addSubview:label];
    UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(WIDTH-120, 0, 100, cell.frame.size.height)];
    textField.textAlignment=NSTextAlignmentRight;
    textField.delegate=self;
    textField.tag=100+indexPath.row;
    textField.adjustsFontSizeToFitWidth=YES;
    textField.textColor=[UIColor grayColor];
    switch (indexPath.row) {
        case 0:
        case 2:
        {
//            UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-200, 10, 80, cell.frame.size.height-20)];
//            [but setTitle:@"快捷导入" forState:UIControlStateNormal];
//            [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
//            but.tag=1000+indexPath.row;
//            [but setTitleColor: kColorFromRGBHex(0x5190e1) forState:UIControlStateNormal];
//            [but.layer setMasksToBounds:YES];
//            [but.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
//            //边框宽度
//            [but.layer setBorderWidth:1.0];
//            but.layer.borderColor=kColorFromRGBHex(0x5190e1).CGColor;
//            [cell.contentView addSubview:but];
            textField.placeholder=@"请输入姓名";


        }
            break;
            
        default:
            textField.placeholder=@"输入手机号";

            break;
    }
    [cell.contentView addSubview:textField];

    return cell;
}

-(void)butClick:(UIButton *)click
{
    AddressVC *address=[[AddressVC alloc]init];
   [ address setClickPersonBlock:^(PersonModel *person){
        
        if (click.tag==1000) {
            UITextField *label=(UITextField *)[self.view viewWithTag:100];
            label.text=person.name1;
            UITextField *label1=(UITextField *)[self.view viewWithTag:101];
            label1.text=person.tel;
        }
        else{
            UITextField *label=(UITextField *)[self.view viewWithTag:102];
            label.text=person.name1;
            UITextField *label1=(UITextField *)[self.view viewWithTag:103];
            label1.text=person.tel;
            
        }
        
    }];

       [self.navigationController pushViewController:address animated:YES];
  


}
-(void)complete
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        Context.currentUser.uid,@"uid",
                        [(UITextField  *) [self.view viewWithTag:100] text],@"kinsfolk_name",
                        [(UITextField  *) [self.view viewWithTag:101] text],@"kinsfolk_mobile",
                        [(UITextField  *) [self.view viewWithTag:102] text],@"urgency_name",
                        [(UITextField  *) [self.view viewWithTag:103] text],@"urgency_mobile",
                        
                        nil];
    [[NetWorkManager sharedManager]postNoTipJSON:[NSString stringWithFormat:@"%@&m=userdetail&a=other_add",SERVERE] parameters:dic2 success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"]isEqualToString:@"0000"]) {
            [MessageAlertView showSuccessMessage:@"上传成功"];
            if (self.clickBlock) {
                self.clickBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];

        }
        else
        {
            [MessageAlertView showErrorMessage:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
