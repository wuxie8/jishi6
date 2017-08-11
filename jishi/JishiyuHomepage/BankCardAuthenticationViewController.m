//
//  BankCardAuthenticationViewController.m
//  haitian
//
//  Created by Admin on 2017/4/26.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "BankCardAuthenticationViewController.h"
#import "YLSOPickerView.h"
//#import "DataSubmittedViewController.h"
@interface BankCardAuthenticationViewController ()<UITableViewDelegate,UITableViewDataSource>


#define bank @"请选择银行"
@property(strong, nonatomic)UIView *footView;

@property(strong, nonatomic) NSMutableDictionary *dic;
@end

@implementation BankCardAuthenticationViewController
{
    NSArray *arr;
    NSArray *placeArr;
    NSArray *_dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"收、还款银行卡";
    NSArray *arr1=@[@"持卡人姓名",@"持卡人身份号"];
    NSArray *arr2=@[@"选择银行",@"银行卡号",@"预留手机号"];
    arr=@[arr1,arr2];
    
    NSArray *arr3=@[@"请输入姓名",@"请输入持卡人身份号"];
    NSArray *arr4=@[@"选择开户行",@"请输入银行卡号",@"请输入预留手机号"];
    placeArr=@[arr3,arr4];
    _dataArray=@[@"建设银行",@"建设银行",@"建设银行",@"建设银行",@"建设银行",@"建设银行",@"建设银行"];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getValue:) name:bank object:nil];

    UITableView *tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    tab.delegate=self;
    tab.dataSource=self;
    tab.backgroundColor=AppPageColor;
    tab.tableFooterView=self.footView;
    [self.view addSubview:tab];
    // Do any additional setup after loading the view.
}
-(UIView *)footView
{
    if (_footView==nil) {
        _footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 150)];
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, WIDTH-20, 60)];
        lab.text=@"温馨提示:\n填写的银行卡必须是本人名下的借记卡(储蓄卡)。";
        lab.numberOfLines=0;
        [_footView addSubview:lab];
        
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lab.frame)+30, WIDTH-20, 60)];
        [button setImage:[UIImage imageNamed:@"BanKCardBinging"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(ImmediatelyBinding) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius =  20;
        //            //将多余的部分切掉
                    button.layer.masksToBounds = YES;
        [_footView addSubview:button];
    }
    return _footView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[arr objectAtIndex:(section)] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType=UITableViewCellAccessoryNone;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor whiteColor];
    if (indexPath.section==1&&indexPath.row==3) {
        UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(10, 0, 200, cell.frame.size.height)];
        textField.textAlignment=NSTextAlignmentLeft;
        textField.placeholder=[[placeArr objectAtIndex:(indexPath.section)] objectAtIndex:indexPath.row];
        textField.delegate=self;
        textField.tag=[[NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row] integerValue];
        [cell.contentView addSubview:textField];
        textField.returnKeyType=UIReturnKeyDefault;
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-120, 5, 100, cell.frame.size.height-10)];
        [but setTitle:@"获取验证码" forState:UIControlStateNormal];
        [but setTitleColor:AppButtonbackgroundColor forState:UIControlStateNormal];
//        but.backgroundColor=AppPageColor;
        [but.layer setBorderColor:[UIColor blueColor].CGColor];
        [but.layer setBorderWidth:1];
        [but.layer setMasksToBounds:YES];
        [but addTarget:self action:@selector(getVerificationCode) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:but];
    }
    else
    {
        cell.textLabel.text=[[arr objectAtIndex:(indexPath.section)] objectAtIndex:indexPath.row];

        UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(WIDTH-300, 0, 280, cell.frame.size.height)];
        textField.textAlignment=NSTextAlignmentRight;
        textField.placeholder=[[placeArr objectAtIndex:(indexPath.section)] objectAtIndex:indexPath.row];
        textField.delegate=self;
        textField.returnKeyType=UIReturnKeyDefault;

        textField.tag=[[NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row] integerValue];
        [cell.contentView addSubview:textField];

    }
    return cell;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (textField.tag==10) {
        YLSOPickerView *picker = [[YLSOPickerView alloc]init];
        picker.array = _dataArray;
        picker.title = bank;
        [picker show];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
        //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
        tapGestureRecognizer.cancelsTouchesInView = YES;
        //将触摸事件添加到当前view
        [picker addGestureRecognizer:tapGestureRecognizer];
        return NO;

    }
    return YES;
}

- (void)keyboardHide:(UITapGestureRecognizer *)tap
{
    YLSOPickerView *pickView=(YLSOPickerView *)tap.view;
    [pickView quit];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.view endEditing:YES];

    NSUInteger tag=textField.tag;
    [self.dic setObject:textField.text forKey:[NSString stringWithFormat:@"%lu",(unsigned long)tag]];
}


#pragma mark 实现方法
-(void)getVerificationCode
{
}
-(void)ImmediatelyBinding
{
//    [self.navigationController pushViewController:[DataSubmittedViewController new] animated:YES];
}
-(void)getValue:(NSNotification *)notification
{
    UITextField *text=[self.view viewWithTag:10];
    text.text=notification.object;
    [self.dic setObject:notification.object forKey:@"10"];

}
#pragma mark 懒加载
-(NSMutableDictionary *)dic
{
    if (_dic==nil) {
        _dic=[NSMutableDictionary dictionary];
    }
    return _dic;
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
