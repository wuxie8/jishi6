
//
//  NewRemindViewController.m
//  haitian
//
//  Created by Admin on 2017/5/15.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "NewRemindViewController.h"
#import "YLSOPickerView.h"
#import "HcdDateTimePickerView.h"
#import "RemindModel.h"
#define RemianType @"请选择类型"
#define RepeatType @"请选择重复方式"

#define RemianTime @"请选择提醒时间"

@interface NewRemindViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)UIView*footView;
@end

@implementation NewRemindViewController
{
    NSArray *array;
    NSArray *placeArray;
    UITextView *_textView;
    NSMutableArray *remindArray;
    NSMutableArray *remindTimeArray;
    NSMutableDictionary *remindDic;
    NSMutableDictionary *remindTimeDic;
    NSString *rep_id;
      NSString *rem_id;
 
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"新建提醒";
    NSArray *sectionArr1=@[@"类型",@"姓名",@"金额"];
    NSArray *sectionArr2=@[@"还款日",@"重复",@"提醒"];
    NSArray *placesectionArr1=@[self.remindTitle,@"请输入姓名",@"请输入金额"];
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    NSString  *string   = [dateFormatter stringFromDate:date];
    NSArray *placesectionArr2=@[string,@"每月",@"提前30分钟"];

    placeArray=@[placesectionArr1,placesectionArr2];
    array=@[sectionArr1,sectionArr2];
    [self getList];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getValue:) name:RemianType object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getValue:) name:RepeatType object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getValue:) name:RemianTime object:nil];

    UITableView *tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    tab.delegate=self;
    tab.dataSource=self;
    tab.tableFooterView=self.footView;
    [self.view addSubview:tab];
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
//    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
//    tapGestureRecognizer.cancelsTouchesInView = NO;
//    //将触摸事件添加到当前view
//    [tab addGestureRecognizer:tapGestureRecognizer];
    // Do any additional setup after loading the view.
}

-(void)getList
{
    [[NetWorkManager sharedManager]postJSON:[NSString stringWithFormat:@"%@&m=message&a=postReplist",SERVEREURL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic=(NSDictionary *)responseObject;
        if ([dic[@"code"] isEqualToString:@"0000"]) {

        NSDictionary *diction=dic[@"data"];
        NSArray *arr=diction[@"data"];
        remindArray=[NSMutableArray array];
        remindDic=[NSMutableDictionary dictionary];
        for (NSDictionary *dic1 in arr) {
            RemindModel *remind=[RemindModel new];
            [remind setValuesForKeysWithDictionary:dic1];
            [remindArray addObject:remind.name];
            [remindDic setValue:dic1[@"rep_id"] forKey:dic1[@"name"]];
        }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
    
//    [[NetWorkManager sharedManager]postJSON:[NSString stringWithFormat:@"%@/message/typelist",SERVEREURL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//    }];
    
    [[NetWorkManager sharedManager]postJSON:[NSString stringWithFormat:@"%@&m=message&a=postRemlist",SERVEREURL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic=(NSDictionary *)responseObject;
        if ([dic[@"code"] isEqualToString:@"0000"]) {
            NSDictionary *diction=dic[@"data"];
            NSArray *arr=diction[@"data"];
            remindTimeArray=[NSMutableArray array];
            remindTimeDic=[NSMutableDictionary dictionary];
            for (NSDictionary *dic1 in arr) {
                ReminndTimeModel *remind=[ReminndTimeModel new];
                [remind setValuesForKeysWithDictionary:dic1];
                [remindTimeArray addObject:remind.name];
                [remindTimeDic setValue:dic1[@"rem_id"] forKey:dic1[@"name"]];
            }
        }
       
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0 , 0 , WIDTH, 40)];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
    label.text=@"添加提醒";
    [view addSubview:label];
    view.backgroundColor=BaseColor;
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 40;

    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0 , 0 , WIDTH, 20)];
    view.backgroundColor=BaseColor;
    return view;
}
-(UIView *)footView
{
    if (_footView==nil) {
        _footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 0.3*HEIGHT)];
        _footView.backgroundColor=BaseColor;
        _textView=[[UITextView alloc]initWithFrame:CGRectMake(10, 10, WIDTH-20, 100)];
        _textView.text=@"备注...";
        _textView.delegate=self;
        _textView.font=[UIFont systemFontOfSize:15];
        _textView.scrollEnabled=YES;
        _textView.backgroundColor=[UIColor whiteColor];
        [_footView addSubview:_textView];
        
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(20 , CGRectGetMaxY(_textView.frame)+10, WIDTH-40, 50)];
        but.backgroundColor=AppButtonbackgroundColor;
        but.layer.masksToBounds=YES;
        but.layer.cornerRadius=10;
        [but addTarget:self action:@selector(addRemind) forControlEvents:UIControlEventTouchUpInside];
        [but setTitle:@"保存" forState:UIControlStateNormal];
        [_footView addSubview:but];
    }
    
    return _footView;
}
-(void)addRemind
{
    NSString *remark;
    if (![_textView.text isEqualToString:@"备注..."]) {
        remark=_textView.text;
    }
    int type = 1 ;
    if ([self.remindTitle isEqualToString:@"房贷"]) {
       type=1;
    }
    else if ([self.remindTitle isEqualToString:@"车贷"])
    {
type=2;
    }
    else if ([self.remindTitle isEqualToString:@"水电费"])
    {
type=3;
    }
    else if ([self.remindTitle isEqualToString:@"燃气费"])
    {
type=4;
    }
    else if ([self.remindTitle isEqualToString:@"物业费"])
    {
type=5;
    }
   else if ([self.remindTitle isEqualToString:@"自定义"])
    {
type=6;
    }
   
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                      Context.currentUser.uid,@"user_id",
                       [NSString stringWithFormat:@"%d",type],@"type_id",
                       [(UITextField *) [self.view viewWithTag:1001] text],@"name",
                        [(UITextField *) [self.view viewWithTag:1002] text],@"amount",
                       [(UITextField *) [self.view viewWithTag:1010] text],@"date",
                       rep_id,@"rep_id",
                       rem_id,@"rem_id",
                       remark,@"remark",
                      

                       nil];
    NSMutableDictionary *dic1=[NSMutableDictionary dictionaryWithDictionary:dic];
    if ([self.remindTitle isEqualToString:@"自定义"]) {
      
        [dic1 setObject:[(UITextField *) [self.view viewWithTag:1000] text] forKey:@"msg_name"];
    }
    NSString *url=[NSString stringWithFormat:@"%@&m=message&a=postAdd",SERVEREURL];
    [[NetWorkManager sharedManager]postNoTipJSON:url parameters:dic1  success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"0000"]) {
            [MessageAlertView showSuccessMessage:@"添加成功"];
              UIViewController *viewCtl = self.navigationController.viewControllers[self.navigationController.viewControllers.count-3];
            [self.navigationController popToViewController:viewCtl animated:NO];
        }
        else
        {
            [MessageAlertView showErrorMessage:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        DLog(@"%@",error);

        
    }];

}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"备注..."]) {
        textView.text = @"";
    }
}
- (void)textViewDidChange:(UITextView *)textView
{
    if ([UtilTools isBlankString:textView.text]) {
        textView.text = @"备注...";

    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return array.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[array objectAtIndex:(section)] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdenfer=@"addressCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdenfer];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdenfer];
    }
    
    cell.textLabel.text=[[array objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(WIDTH-300, 0, 280, cell.frame.size.height)];
    textField.textAlignment=NSTextAlignmentRight;
    textField.placeholder=[[placeArray objectAtIndex:(indexPath.section)] objectAtIndex:indexPath.row];
    textField.delegate=self;
    textField.tag=1000+[[NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row] integerValue];
    [cell.contentView addSubview:textField];
    
      return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    [self.view endEditing:YES];
    if (textField.tag==1000) {
        if (![self.remindTitle isEqualToString:@"自定义"]) {
            return NO;
        }
        
    }
    else if (textField.tag==1010) {
        HcdDateTimePickerView* dateTimePickerView = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDatetimeMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:0]];
        dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
            UITextField *text=[self.view viewWithTag:1010];
            text.text=datetimeStr;
        };
        [self.view addSubview:dateTimePickerView];
        [dateTimePickerView showHcdDateTimePicker];
        return NO;
    }
    else if (textField.tag==1011) {
        YLSOPickerView *picker = [[YLSOPickerView alloc]init];
        
        picker.array =remindArray;
        picker.title = RepeatType;
        
        [picker show];
        return NO;
        
    }
    else if (textField.tag==1012) {
        YLSOPickerView *picker = [[YLSOPickerView alloc]init];
        picker.array = remindTimeArray;
        picker.title = RemianTime;
        [picker show];
        return NO;
        
    }
    return YES;
}
-(void)getValue:(NSNotification *)notification
{
    if ([notification.name isEqualToString:RepeatType]) {
        UITextField *text=[self.view viewWithTag:1011];
        text.text=notification.object;
        rep_id=[remindDic objectForKey:notification.object];
    }
    else if([notification.name isEqualToString:RemianTime])
    {
        UITextField *text=[self.view viewWithTag:1012];
        text.text=notification.object;
        rem_id=[remindTimeDic objectForKey:notification.object];

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
