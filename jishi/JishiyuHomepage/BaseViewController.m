//
//  BaseViewController.m
//  jishi
//
//  Created by Admin on 2017/7/24.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "BaseViewController.h"
#import "YLSOPickerView.h"
#import "WebVC.h"
#import "OperatorViewController.h"

@interface BaseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)UIView*footView;
@end

@implementation BaseViewController
{
    NSArray *arr;
    NSArray *array;
    NSArray *placeArr;
    NSMutableDictionary *dic;
    UIButton *selectebutton;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(complete)];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    self.navigationItem.rightBarButtonItem = backItem;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getValue:) name:@"是否婚配" object:nil];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"资料提交";
    arr=@[@"本人姓名",@"本人身份证号码",@"性别",@"是否婚配"];
    NSArray *arr1=[NSArray array];
    NSArray *arr2=[NSArray array];
    NSArray *arr3=[NSArray array];
    NSArray *arr4=@[@"是",@"否"];
    [self getList];
    array=@[arr1,arr2,arr3,arr4];
    dic=[NSMutableDictionary dictionary];
    for (int i=0; i<arr.count; i++) {
        [dic setObject:array[i] forKey:arr[i]];
        
    }

    placeArr=@[@"请填写姓名",@"请填写身份证号码",@"请填写性别",@"请选择"];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(boardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = YES;
    
    UITableView *tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    tab.delegate=self;
    tab.dataSource=self;
    tab.tableFooterView=[UIView new];
    [self.view addSubview:tab];
    [self.view addSubview:self.footView];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    // Do any additional setup after loading the view.
}
- (void)boardHide:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
    
}
-(UIView *)footView
{
    if (!_footView) {
        _footView=[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-120-44, WIDTH, 120)];
        selectebutton=[[UIButton alloc]initWithFrame:CGRectMake(20, 10, 30, 30)];
        [selectebutton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [selectebutton  setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateNormal];
        [selectebutton  setImage:[UIImage imageNamed:@"UnSelected"] forState:UIControlStateSelected];

        [_footView addSubview:selectebutton];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(selectebutton.frame)+10, 10, 100, 30)];
        label.text=@"我已阅读并同意";
        label.font=[UIFont systemFontOfSize:13];
        [_footView addSubview:label];
        UILabel *clickLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 10, 100, 30 )];
        clickLabel.text=@"用户协议";
        clickLabel.font=[UIFont systemFontOfSize:13];
        clickLabel.textColor=kColorFromRGBHex(0x3795d0);
        [_footView addSubview:clickLabel];
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)];
        [clickLabel addGestureRecognizer:labelTapGestureRecognizer];
        clickLabel.userInteractionEnabled = YES;
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(label.frame)+10, WIDTH-20, 40 )];
        [but setTitle:@"下一步" forState:UIControlStateNormal];
        [but addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
        but.layer.cornerRadius =  20;
        //            //将多余的部分切掉
        but.layer.masksToBounds = YES;
        
        //        but.enabled=NO;
        but.backgroundColor=AppButtonbackgroundColor;
        [_footView addSubview:but];
    }
    return _footView;
}
-(void)click:(UIButton *)sender{
    selectebutton.selected=!selectebutton.selected;
}
-(void)labelClick{
    WebVC *vc = [[WebVC alloc] init];

    [vc setNavTitle:@"用户使用协议"];
    [vc loadFromURLStr:@"http://www.jishiyu007.com/xieyi_bj.html"];
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:NO];

}
-(void)nextStep{
    if ([UtilTools isBlankString: [(UITextField *) [self.view viewWithTag:1000] text]]) {
        [MessageAlertView showErrorMessage:@"姓名不能为空"];
    }
    else if ([UtilTools isBlankString: [(UITextField *) [self.view viewWithTag:1001] text]]){
        [MessageAlertView showErrorMessage:@"身份证不能为空"];
    }
    else if ([UtilTools isBlankString: [(UITextField *) [self.view viewWithTag:1002] text]]){
        [MessageAlertView showErrorMessage:@"性别不能为空"];
    }
    else if ([UtilTools isBlankString: [(UITextField *) [self.view viewWithTag:1003] text]]){
        [MessageAlertView showErrorMessage:@"是否婚配不能为空"];
    }
    else{
        [self.navigationController pushViewController:[OperatorViewController new] animated:YES];}

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
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor whiteColor];
    cell.textLabel.text=arr[indexPath.row];
    UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(WIDTH-300, 0, 250, cell.frame.size.height)];
    textField.textAlignment=NSTextAlignmentRight;
    textField.placeholder=placeArr[indexPath.row];
    textField.delegate=self;
    textField.tag=1000+indexPath.row;
    [cell.contentView addSubview:textField];
    
    return cell;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    [self.view endEditing:YES];
    if (textField.tag==1003) {
        YLSOPickerView *picker = [[YLSOPickerView alloc]init];
        picker.array=[array objectAtIndex:textField.tag-1000];
        picker.title=[arr objectAtIndex:textField.tag-1000];
        
        
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
-(void)getValue:(NSNotification *)notification
{
    
    
    UITextField *text=[self.view viewWithTag:1000+[arr indexOfObject:notification.name]];
    text.text=notification.object;
    //    [self.dic setObject:notification.object forKey:@"10"];
    
}

-(void)getList
{
    NSDictionary *dic1=[NSDictionary dictionaryWithObjectsAndKeys:
                        
                        Context.currentUser.uid,@"uid",
                        nil];
    
    [[NetWorkManager sharedManager]postJSON:[NSString stringWithFormat:@"%@&m=userinfo&a=postDetail",SERVEREURL] parameters:dic1 success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"0000"]) {
            NSDictionary *diction=[responseObject[@"data"] objectForKey:@"data"];
            if (![UtilTools isBlankDictionary:diction]) {
                UITextField *text1=    [self.view viewWithTag:1000];
                [text1 setText:[diction objectForKey:@"realname"]];
                UITextField *text2=    [self.view viewWithTag:1001];
                [text2 setText:[diction objectForKey:@"idcard"]];
                if (![UtilTools isBlankString:[diction objectForKey:@"sex"]]) {
                    UITextField *text3=    [self.view viewWithTag:1002];

                    [text3  setText:[diction objectForKey:@"sex"]];
                }
                if (![UtilTools isBlankString:[diction objectForKey:@"is_married"]]) {
                    UITextField *text4=    [self.view viewWithTag:1003];
                    [text4 setText:[diction objectForKey:@"is_married"]];
                }
             
            }
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
    
}


-(void)complete
{
    
    if ([UtilTools isBlankString: [(UITextField *) [self.view viewWithTag:1000] text]]) {
        [MessageAlertView showErrorMessage:@"姓名不能为空"];
    }
    else if ([UtilTools isBlankString: [(UITextField *) [self.view viewWithTag:1001] text]]){
        [MessageAlertView showErrorMessage:@"身份证不能为空"];
    }
    else if ([UtilTools isBlankString: [(UITextField *) [self.view viewWithTag:1002] text]]){
        [MessageAlertView showErrorMessage:@"性别不能为空"];
    }
    else if ([UtilTools isBlankString: [(UITextField *) [self.view viewWithTag:1003] text]]){
        [MessageAlertView showErrorMessage:@"是否婚配不能为空"];
    }
    else{
        
        NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                            Context.currentUser.uid,@"uid",
                            [(UITextField *) [self.view viewWithTag:1000] text],@"realname",
                            [(UITextField *) [self.view viewWithTag:1001] text],@"idcard",
                            [(UITextField *) [self.view viewWithTag:1002] text],@"sex",
                            [(UITextField *) [self.view viewWithTag:1003] text],@"is_married",
                            
                            nil];
        [[NetWorkManager sharedManager]postNoTipJSON:[NSString stringWithFormat:@"%@&m=userinfo&a=postAdd",SERVERE] parameters:dic2 success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([responseObject[@"code"]isEqualToString:@"0000"]) {
            }
            else
            {
                [MessageAlertView showErrorMessage:responseObject[@"msg"]];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@",error);
            
            
        }];

        [self.navigationController pushViewController:[OperatorViewController new] animated:YES];}
    
    
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
