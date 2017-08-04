//
//  ContactVC.m
//  jishi
//
//  Created by Admin on 2017/8/2.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ContactVC.h"
#import "YLSOPickerView.h"

@interface ContactVC ()<UITableViewDelegate,UITableViewDataSource>
@property(strong, nonatomic)UIView *footView;

@end

@implementation ContactVC
{
    NSArray *arr;
    NSArray *array;
    NSArray *placeArray;
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"联系人信息";
    arr=@[@"与本人关系",@"姓名",@"手机",@"与本人的关系",@"姓名",@"手机"];
    placeArray=@[@"请选择",@"请输入姓名",@"请输入手机号码",@"请选择",@"请输入姓名",@"请输入手机号码"];
    
    NSArray *arr1=@[@"父亲",@"母亲",@"配偶",@"兄弟姐妹(直系亲属)"];
    NSArray *arr2=[NSArray array];
    NSArray *arr3=[NSArray array];
    NSArray *arr4=@[@"父亲",@"母亲",@"配偶",@"兄弟姐妹(直系亲属)"];
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
-(void)getList
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        Context.currentUser.uid,@"uid",
                        nil];
    [[NetWorkManager sharedManager]postNoTipJSON:[NSString stringWithFormat:@"%@&m=Tempinfo&a=linkman_list",SERVERE] parameters:dic2 success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"]isEqualToString:@"0000"]) {
            NSDictionary *dictionary=[[responseObject objectForKey:@"data"]objectForKey:@"data"];
            if (![UtilTools isBlankDictionary:dictionary]) {
                if (![UtilTools isBlankString:dictionary[@"ralation_a"]]) {
                    UITextField *text=[self.view viewWithTag:1000];
                    text.text=dictionary[@"ralation_a"];
                }
                if (![UtilTools isBlankString:dictionary[@"name_a"]]) {
                    UITextField *text=[self.view viewWithTag:1001];
                    text.text=dictionary[@"name_a"];
                }
                if (![UtilTools isBlankString:dictionary[@"mobile_a"]]) {
                    UITextField *text=[self.view viewWithTag:1002];
                    text.text=dictionary[@"mobile_a"];
                }
                if (![UtilTools isBlankString:dictionary[@"relation_b"]]) {
                    UITextField *text=[self.view viewWithTag:1003];
                    text.text=dictionary[@"relation_b"];
                }
                if (![UtilTools isBlankString:dictionary[@"name_b"]]) {
                    UITextField *text=[self.view viewWithTag:1004];
                    text.text=dictionary[@"name_b"];
                }
                if (![UtilTools isBlankString:dictionary[@"mobile_b"]]) {
                    UITextField *text=[self.view viewWithTag:1005];
                    text.text=dictionary[@"mobile_b"];
                }

            }
        }
      
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];
    
    
}
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
    switch (indexPath.row) {
        case 0:
        case 3:
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
            break;
            
        default:
            break;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor whiteColor];
    cell.textLabel.text=arr[indexPath.row];
    UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(WIDTH-300, 0, 250, cell.frame.size.height)];
    textField.textAlignment=NSTextAlignmentRight;
    textField.placeholder=placeArray[indexPath.row];
    textField.delegate=self;
    textField.tag=1000+indexPath.row;
    [cell.contentView addSubview:textField];
    
    return cell;
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    
    [textField resignFirstResponder];
    
    return YES;
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    [self.view endEditing:YES];
    switch (textField.tag-1000) {
        case 0:
        case 3:
      
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
//        case 3:
//        {
//            
//            [LZCityPickerController showPickerInViewController:self selectBlock:^(NSString *address, NSString *province, NSString *city, NSString *area) {
//                UITextField *text=[self.view viewWithTag:1003];
//                text.text=address;
//                
//                
//                
//            }];
//            
//            return NO;
//        }
//            break;
            
        default:
            break;
    }
    return YES;
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
                        [(UITextField *) [self.view viewWithTag:1000] text],@"ralation_a",
                        [(UITextField *) [self.view viewWithTag:1001] text],@"name_a",
                        [(UITextField *) [self.view viewWithTag:1002] text],@"mobile_a",
                        [(UITextField *) [self.view viewWithTag:1003] text],@"relation_b",
                        [(UITextField *) [self.view viewWithTag:1004] text],@"name_b",
                        [(UITextField *) [self.view viewWithTag:1005] text],@"mobile_b",
                       
                        nil];
    [[NetWorkManager sharedManager]postNoTipJSON:[NSString stringWithFormat:@"%@&m=Tempinfo&a=linkman_add",SERVERE] parameters:dic2 success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"]isEqualToString:@"0000"]) {
            [MessageAlertView showSuccessMessage:@"上传成功"];
            //            if (self.clickBlock) {
            //                self.clickBlock();
            //            }
            [[NSNotificationCenter defaultCenter]postNotificationName:@"CertificationStatus" object:@"3"];

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
-(UIView *)footView
{
    if (!_footView) {
        _footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 90)];
        UIButton *   but=[[UIButton alloc]initWithFrame:CGRectMake(10, 40, WIDTH-20, 50 )];
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
-(void)getValue:(NSNotification *)notification
{
    
    
    UITextField *text=[self.view viewWithTag:1000+[arr indexOfObject:notification.name]];
    text.text=notification.object;
    
    //    [self.dic setObject:notification.object forKey:@"10"];
    
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
