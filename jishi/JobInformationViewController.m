//
//  JobInformationViewController.m
//  jishi
//
//  Created by Admin on 2017/8/2.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "JobInformationViewController.h"

#import "YLSOPickerView.h"
#import "LZCityPickerController.h"

@interface JobInformationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)UIView *footView;

@end

@implementation JobInformationViewController
{
    NSArray *arr;
    NSArray *array;
    NSArray *placeArray;

    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"身份信息";
    arr=@[@"您的姓名",@"身份证号",@"学历",@"现居住城市",@"详细地址",@"住宅电话"];
    placeArray=@[@"请输入您的姓名",@"请输入身份证号",@"请选择学历",@"请选择现居住城市",@"请填写详细地址",@"请填写住宅电话"];

    NSArray *arr1=[NSArray array];
    NSArray *arr2=[NSArray array];
    NSArray *arr3=@[@"高中以下",@"大专",@"本科",@"研究生以上"];
    NSArray *arr4=[NSArray array];
    NSArray *arr5=[NSArray array];
    NSArray *arr6=[NSArray array];
  
    array=@[arr1,arr2,arr3,arr4,arr5,arr6];
    for (int i=0; i<arr.count; i++) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getValue:) name:arr[i] object:nil];
        
    }
    [self getList];
    
    UITableView *tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    tab.delegate=self;
    tab.dataSource=self;
    tab.tableFooterView=self.footView;
    [self.view addSubview:tab];
    
    // Do any additional setup after loading the view.
}
- (void)keyboardHide:(UITapGestureRecognizer *)tap
{
    YLSOPickerView *pickView=(YLSOPickerView *)tap.view;
    [pickView quit];
    
}
#pragma mark 实现方法
-(void)getList
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        Context.currentUser.uid,@"uid",
                        nil];
    [[NetWorkManager sharedManager]postNoTipJSON:[NSString stringWithFormat:@"%@&m=Tempinfo&a=identity_list",SERVERE] parameters:dic2 success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"]isEqualToString:@"0000"]) {
           NSDictionary *dictionary=[[responseObject objectForKey:@"data"]objectForKey:@"data"];
            if (![UtilTools isBlankDictionary:dictionary]) {
                if (![UtilTools isBlankString:dictionary[@"name"]]) {
                    UITextField *text=[self.view viewWithTag:1000];
                    text.text=dictionary[@"name"];
                }
                if (![UtilTools isBlankString:dictionary[@"idcard"]]) {
                    UITextField *text=[self.view viewWithTag:1001];
                    text.text=dictionary[@"idcard"];
                }
                if (![UtilTools isBlankString:dictionary[@"edu"]]) {
                    UITextField *text=[self.view viewWithTag:1002];
                    text.text=dictionary[@"edu"];
                }
                if (![UtilTools isBlankString:dictionary[@"city"]]) {
                    UITextField *text=[self.view viewWithTag:1003];
                    text.text=dictionary[@"city"];
                }
                if (![UtilTools isBlankString:dictionary[@"address"]]) {
                    UITextField *text=[self.view viewWithTag:1004];
                    text.text=dictionary[@"address"];
                }
                if (![UtilTools isBlankString:dictionary[@"tel"]]) {
                    UITextField *text=[self.view viewWithTag:1005];
                    text.text=dictionary[@"tel"];
                }

            }
                   }
       
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];
    
    
}
-(void)complete
{
    for (int i=0; i<arr.count; i++) {
        if ([UtilTools isBlankString:[(UITextField *) [self.view viewWithTag:1000+i] text]]) {
            [MessageAlertView showErrorMessage:@"请补全信息"];
            return;
        }
    }
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        Context.currentUser.uid,@"uid",
                        [(UITextField *) [self.view viewWithTag:1000] text],@"name",
                        [(UITextField *) [self.view viewWithTag:1001] text],@"idcard",
                        [(UITextField *) [self.view viewWithTag:1002] text],@"edu",
                        [(UITextField *) [self.view viewWithTag:1003] text],@"city",
                        [(UITextField *) [self.view viewWithTag:1004] text],@"address",
                        [(UITextField *) [self.view viewWithTag:1005] text],@"tel",
                        nil];
    
    [[NetWorkManager sharedManager]postNoTipJSON:[NSString stringWithFormat:@"%@&m=Tempinfo&a=identity_add",SERVERE] parameters:dic2 success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"]isEqualToString:@"0000"]) {
            [MessageAlertView showSuccessMessage:@"上传成功"];
            //            if (self.clickBlock) {
            //                self.clickBlock();
            //            }
            [[NSNotificationCenter defaultCenter]postNotificationName:@"CertificationStatus" object:@"0"];
            
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
-(void)getValue:(NSNotification *)notification
{
    
    
    UITextField *text=[self.view viewWithTag:1000+[arr indexOfObject:notification.name]];
    text.text=notification.object;
    
    //    [self.dic setObject:notification.object forKey:@"10"];
    
}

#pragma  mark  UITableViewDelegate

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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor whiteColor];
    cell.textLabel.text=arr[indexPath.row];
    UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(WIDTH-300, 0, 250, cell.frame.size.height)];
    textField.textAlignment=NSTextAlignmentRight;
    textField.placeholder=placeArray[indexPath.row];
    textField.delegate=self;
    textField.tag=1000+indexPath.row;
    switch (indexPath.row) {
        case 2:
        case 3:
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
            break;
            case 1:
            case 5:
            textField.keyboardType=UIKeyboardTypeNumberPad;
            break;
        default:
            break;
    }

    [cell.contentView addSubview:textField];
    
    return cell;
    
    
}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    
    [textField resignFirstResponder];
    
    return YES;
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    [self.view endEditing:YES];
    switch (textField.tag-1000) {
        case 2:
            
        {  YLSOPickerView *picker = [[YLSOPickerView alloc]init];
            picker.array=[array objectAtIndex:textField.tag-1000];
            picker.title=[arr objectAtIndex:textField.tag-1000];
            
            
            [picker show];
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
            //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
            tapGestureRecognizer.cancelsTouchesInView = YES;
            //将触摸事件添加到当前view
            [picker addGestureRecognizer:tapGestureRecognizer];
            return NO;}
        case 3:
        {
            
            [LZCityPickerController showPickerInViewController:self selectBlock:^(NSString *address, NSString *province, NSString *city, NSString *area) {
                UITextField *text=[self.view viewWithTag:1003];
                text.text=address;
                
                
                
            }];
            
            return NO;
        }
            break;
            
        default:
            break;
    }
    return YES;
}
#pragma mark 懒加载
-(UIView *)footView
{
    if (!_footView) {
        _footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 80)];
        UIButton *   but=[[UIButton alloc]initWithFrame:CGRectMake(10, 40, WIDTH-20, 40 )];
        [but setTitle:@"完成" forState:UIControlStateNormal];
        [but addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
        but.layer.cornerRadius =  20;
        //            //将多余的部分切掉
        but.layer.masksToBounds = YES;
        but.backgroundColor=AppgreenColor;
        [_footView addSubview:but];
    }
    return _footView;
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
