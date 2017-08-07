//
//  OperatorViewController.m
//  jishi
//
//  Created by Admin on 2017/7/24.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "OperatorViewController.h"
#import "OtherContactsViewController.h"
@interface OperatorViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)UIView *headView;
@property(strong, nonatomic)UIView*footView;
@end

@implementation OperatorViewController
{
    NSArray *arr;
    NSArray *placeArr;
    NSArray *titlePlaceArr;
    NSDictionary *dic1;
    NSString *otherInfo;

}
-(void)viewWillDisappear:(BOOL)animated

{
    [super viewWillDisappear:animated];
    [MessageAlertView dismissHud];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"运营商验证";
    arr=@[@"手机号码",@"服务密码"];
    placeArr=@[@"请输入手机号码",@"请输入服务密码"];
    titlePlaceArr=@[@"本人实名认证的手机号码",@"请谨慎输入,多次输错会导致账号锁定"];

    UITableView *tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
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
        _headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 160)];
        _headView.backgroundColor=[UIColor redColor];
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 160)];
        imageView.image=[UIImage imageNamed:@"Operator"];
        [_headView addSubview:imageView];
    }
    return _headView;
}
-(UIView *)footView
{
    if (!_footView) {
        _footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 80)];
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(20, 20, WIDTH-20*2, 40 )];
        [but setTitle:@"提交" forState:UIControlStateNormal];
        [but addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
        but.layer.cornerRadius =  20;
        //            //将多余的部分切掉
        but.layer.masksToBounds = YES;
        
        //        but.enabled=NO;
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"review"]) {
            but.backgroundColor=AppgreenColor;
        }
        else{
            but.backgroundColor=AppButtonbackgroundColor;

        }
        [_footView addSubview:but];
    }
    return _footView;
}
-(void)nextStep
{

    NSMutableDictionary *diction=[NSMutableDictionary dictionary];
    UITextField *textField1=(UITextField *)[self.view viewWithTag:1000];
    UITextField *textField2=(UITextField *)[self.view viewWithTag:1001];

    if ([UtilTools isBlankString:textField1.text]) {
        [MessageAlertView showErrorMessage:@"手机号码不能为空"];
        return;
    }
    if (textField1.text.length!=11) {
        [MessageAlertView showErrorMessage:@"请输入正确的手机号"];
         return;
    }
    if ([UtilTools isBlankString:textField2.text]) {
        [MessageAlertView showErrorMessage:@"服务密码不能为空"];
        return;
    }
    for (int i=0; i<2; i++) {
        
        UITextField *text1=(UITextField *)[self.view viewWithTag:1000+i];
        [diction setObject:text1.text forKey:[NSString stringWithFormat:@"%d",i]];
    }
    if (![UtilTools  isBlankDictionary:diction]) {
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                           @"api.mobile.area",@"method",
                           @"0618854278903691",@"apiKey",
                           @"1.0.0",@"version",
                       
                           diction[@"0"],@"mobileNo",
                           
                           
                           nil];
        [self getResultSign:dic step:@"0"];
    }
    


}
//第一步  提交申请
-(void)getSign:(NSString *)value
{
    NSMutableDictionary *diction=[NSMutableDictionary dictionary];
    for (int i=0; i<2; i++) {
        
        UITextField *text1=(UITextField *)[self.view viewWithTag:1000+i];
        [diction setObject:text1.text forKey:[NSString stringWithFormat:@"%d",i]];
    }
    
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                       @"api.mobile.get",@"method",
                       @"0618854278903691",@"apiKey",
                       @"1.0.0",@"version",
                       
                       diction[@"0"],@"username",
                       [UtilTools base64EncodedString:diction[@"1"]],@"password",
                       @"busi",@"contentType",
                       
                       
                       nil];
    NSMutableDictionary *paradic=[NSMutableDictionary dictionaryWithDictionary:dic];
    if (![UtilTools isBlankString:value]) {
        [paradic setObject:value forKey:@"otherInfo"];
    }
    [self getResultSign:paradic step:@"1"];
    
}
#pragma mark 运营商验证
-(void)phoneCarrier:(NSDictionary *)paraDic
{
    
    [[NetWorkManager sharedManager]postJSON:@"http://api.tanzhishuju.com/api/gateway" parameters:paraDic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"] isEqualToString:@"0010"]) {
            NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                               @"api.common.getStatus",@"method",
                               @"0618854278903691",@"apiKey",
                               @"1.0.0",@"version",
                               @"mobile",@"bizType",
                               responseObject[@"token"],@"token",
                               nil];
            [self getResultSign:dic step:@"2"];
            
        }
        else
        {
            [MessageAlertView showErrorMessage:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
}

-(void)getResultSign:(NSDictionary *)signDic step:(NSString *)step
{
    
    
    [[NetWorkManager sharedManager]postJSON:@"http://app.jishiyu11.cn/index.php?g=app&m=userdetail&a=mobileSign" parameters:signDic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableDictionary *paradic=[NSMutableDictionary dictionaryWithDictionary:signDic];
        [paradic setObject:[responseObject[@"data"] objectForKey:@"sign"] forKey:@"sign"];
        if ([step isEqualToString:@"0"]) {
            
            [self getmobilePhoneOwnership:paradic];
        }
        else if ([step isEqualToString:@"1"]) {
            [self phoneCarrier:paradic];
            
        }
        else if ([step isEqualToString:@"2"])
        {
            dic1=paradic;
            [self getStatus:paradic];
        }
        else{
            [self getRusult:paradic];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];
    
}
//第一步 获取归属地
-(void)getmobilePhoneOwnership:(NSDictionary *)paraDic
{
    
    [[NetWorkManager sharedManager]postJSON:@"http://api.tanzhishuju.com/api/gateway" parameters:paraDic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"] isEqualToString:@"0000"]) {
            NSString *typeString = [NSString stringWithFormat:@"%@%@",responseObject[@"province"],responseObject[@"type"]];
            if ([typeString isEqualToString:@"北京移动"]) {
                NSString *title = NSLocalizedString(@"请输入客服密码", nil);
                NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
                NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                // Add the text field for the secure text entry.
                [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                    // Listen for changes to the text field's text so that we can toggle the current
                    // action's enabled property based on whether the user has entered a sufficiently
                    // secure entry.
                    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:textField];
                    
                    textField.secureTextEntry = YES;
                }];
                
                // Create the actions.
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    
                    // Stop listening for text changed notifications.
                    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:alertController.textFields.firstObject];
                }];
                
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    if ([UtilTools isBlankString:otherInfo]) {
                        [MessageAlertView  showErrorMessage:@"客服密码不能为空"];
                        return ;
                    }
                    else{
                    [self getSign:otherInfo];
                          [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:alertController.textFields.firstObject];
                    }
                    // Stop listening for text changed notifications.
                  
                }];
                
                // The text field initially has no text in the text field, so we'll disable it.
                //                otherAction.enabled = NO;
                
                // Hold onto the secure text alert action to toggle the enabled/disabled state when the text changed.
                //                self.secureTextAlertAction = otherAction;
                
                // Add the actions.
                [alertController addAction:cancelAction];
                [alertController addAction:otherAction];
                
                [self presentViewController:alertController animated:YES completion:nil];
                
                
            }
            else if([typeString isEqualToString:@"广西电信"]||[typeString isEqualToString:@"山西电信"]){
                NSString *title = NSLocalizedString(@"请输入身份证号码", nil);
                NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
                NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                // Add the text field for the secure text entry.
                [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                    // Listen for changes to the text field's text so that we can toggle the current
                    // action's enabled property based on whether the user has entered a sufficiently
                    // secure entry.
                    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:textField];
                    
                    textField.secureTextEntry = YES;
                }];
                
                // Create the actions.
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    
                    // Stop listening for text changed notifications.
                    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:alertController.textFields.firstObject];
                }];
                
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    if ([UtilTools isBlankString:otherInfo]) {
                        [MessageAlertView  showErrorMessage:@"身份证号码不能为空"];
                        return ;
                    }
                    else{
                        [self getSign:otherInfo];
                         [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:alertController.textFields.firstObject];
                    }                    // Stop listening for text changed notifications.
                   
                }];
                
                // The text field initially has no text in the text field, so we'll disable it.
                //                otherAction.enabled = NO;
                
                // Hold onto the secure text alert action to toggle the enabled/disabled state when the text changed.
                //                self.secureTextAlertAction = otherAction;
                
                // Add the actions.
                [alertController addAction:cancelAction];
                [alertController addAction:otherAction];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }
            
            else if([typeString isEqualToString:@"吉林电信"]){
                NSString *title = NSLocalizedString(@"请输入验证码", nil);
                NSString *message = NSLocalizedString(@"请发送CXDD到10001获取验证码", nil);
                
                NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
                NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
                
                // Add the text field for the secure text entry.
                [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                    // Listen for changes to the text field's text so that we can toggle the current
                    // action's enabled property based on whether the user has entered a sufficiently
                    // secure entry.
                    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:textField];
                    
                    textField.secureTextEntry = YES;
                }];
                
                // Create the actions.
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    
                    // Stop listening for text changed notifications.
                    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:alertController.textFields.firstObject];
                }];
                
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    if ([UtilTools isBlankString:otherInfo]) {
                        [MessageAlertView  showErrorMessage:@"验证码不能为空"];
                        return ;
                    }
                    else{
                        [self getSign:otherInfo];
                         [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:alertController.textFields.firstObject];
                    }                    // Stop listening for text changed notifications.
                   
                }];
                
                // The text field initially has no text in the text field, so we'll disable it.
                //                otherAction.enabled = NO;
                
                // Hold onto the secure text alert action to toggle the enabled/disabled state when the text changed.
                //                self.secureTextAlertAction = otherAction;
                
                // Add the actions.
                [alertController addAction:cancelAction];
                [alertController addAction:otherAction];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else
            {
                [self getSign:@""];
                
            }
            
        }
        else
        {
            [MessageAlertView showErrorMessage:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
}
- (void)handleTextFieldTextDidChangeNotification:(NSNotification *)notification {
    UITextField *textField = notification.object;
   
    otherInfo=textField.text;
    // Enforce a minimum length of >= 5 characters for secure text alerts.
    //    self.secureTextAlertAction.enabled = textField.text.length >= 5;
}
//第三步 获取结果
-(void)getRusult:(NSDictionary *)paraDic
{
    
    [[NetWorkManager sharedManager]postJSON:@"http://api.tanzhishuju.com/api/gateway" parameters:paraDic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [MessageAlertView showSuccessMessage:@"认证成功"];
//        [self.navigationController pushViewController:[OtherContactsViewController new] animated:YES];

        [self OperatorStatus];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];
}
//第二步 轮询
-(void)OperatorStatus
{
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                       Context.currentUser.uid,@"uid",
                       @"1",@"status",
                       nil];
    [[NetWorkManager sharedManager]postJSON:[NSString stringWithFormat:@"%@&m=Tempinfo&a=mobile_add",SERVERE] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"0000"]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"CertificationStatus" object:@"4"];

            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];
    
    
}
-(void)getStatus:(NSDictionary *)paraDic
{
    
    [[NetWorkManager sharedManager]postNoTipJSON:@"http://api.tanzhishuju.com/api/gateway" parameters:paraDic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [MessageAlertView showLoading:@"数据加载中"];
        if ([responseObject[@"code"] hasPrefix:@"0"]||[UtilTools isBlankString:responseObject[@"code"]]) {
            if ([responseObject[@"code"] isEqualToString:@"0000"]) {
                NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                                   @"api.common.getResult",@"method",
                                   @"0618854278903691",@"apiKey",
                                   @"1.0.0",@"version",
                                   @"mobile",@"bizType",
                                   responseObject[@"token"],@"token",
                                   nil];
                [self getResultSign:dic step:@"3"];
                [MessageAlertView dismissHud];
            }
            else
            {
                [self performSelector:@selector(getStatus:) withObject:dic1 afterDelay:5];
                
            }
            
        }
        else if ([responseObject[@"code"]isEqualToString:@"2038" ]){
            [MessageAlertView showErrorMessage:@"客服密码不对"];
            [MessageAlertView dismissHud];

        }
        else{

            [MessageAlertView showErrorMessage:responseObject[@"msg"]];
            [MessageAlertView dismissHud];

        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        [MessageAlertView dismissHud];

        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return titlePlaceArr[section];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    headerView.backgroundColor=AppBackColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, tableView.frame.size.width-20*2-40, 20)];
    label.textAlignment = NSTextAlignmentLeft;  //文本对齐方式
    [label setBackgroundColor:[UIColor clearColor]];
    label.font=[UIFont systemFontOfSize:14];
    label.text=titlePlaceArr[section];
    [headerView setBackgroundColor:[UIColor clearColor]];
    [headerView addSubview:label];
    return  headerView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text=arr[indexPath.section];
    cell.backgroundColor=AppPageColor;
    UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(WIDTH-300, 0, 300, cell.frame.size.height)];
    textField.textAlignment=NSTextAlignmentLeft;
    textField.delegate=self;
    textField.tag=1000+indexPath.section;
   
    textField.adjustsFontSizeToFitWidth=YES;
    textField.textColor=[UIColor grayColor];
    textField.placeholder=placeArr[indexPath.section];
 
    [cell.contentView addSubview:textField];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
