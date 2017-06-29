//
//  InviteFriendsViewController.m
//  jishi
//
//  Created by Admin on 2017/4/13.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "InviteFriendsViewController.h"
#import "AddressVC.h"
@interface InviteFriendsViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UITextField *phoneTf;
@property(nonatomic, strong)UITextField *passTf;
@property(nonatomic, strong)UITextField *codeTf;
@property(nonatomic, strong)UIButton *codeBtn;
@end

@implementation InviteFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"为好友注册";
    _tableView = [[UITableView alloc] initWithFrame:SCREEN_BOUNDS style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = TableViewBGcolor;
    _tableView.separatorColor = TableViewBGcolor;
    [self.view addSubview:_tableView];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(registerClick)];
    self.navigationItem.rightBarButtonItem = backItem;    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =nil;
    static NSString *identifer = @"cell";
    cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
 
        if (indexPath.row == 0) {
            cell.textLabel.text = @"账号";
            _phoneTf = [[UITextField alloc] initWithFrame:CGRectMake(85 , 0, WIDTH-85, 50)];
//            _phoneTf.delegate = self;
            _phoneTf.text=_tel;
            _phoneTf.keyboardType = UIKeyboardTypeNumberPad;
            [_phoneTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            [cell.contentView addSubview:_phoneTf];
        }else if(indexPath.row == 1){
            cell.textLabel.text = @"密码";
            _passTf = [[UITextField alloc] initWithFrame:CGRectMake(85, 0, WIDTH-95, 50)];
//            _passTf.delegate = self;
            _passTf.placeholder = @"为好友设置密码";
            _passTf.keyboardType = UIKeyboardTypeDefault;
            [cell.contentView addSubview:_passTf];
        }else{
            cell.textLabel.text = @"验证码";
            _codeTf = [[UITextField alloc] initWithFrame:CGRectMake(85, 0, WIDTH-85-90, 50)];
//            _codeTf.delegate = self;
            _codeTf.placeholder = @"好友账号的验证码";
            _codeTf.keyboardType = UIKeyboardTypeDefault;
            [cell.contentView addSubview:_codeTf];
            _codeBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-90, 0, 90, 50)];
            _codeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [_codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _codeBtn.backgroundColor = AppBackColor;
            [_codeBtn addTarget:self action:@selector(verificationCodeRegister) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:_codeBtn];
        }
  
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)verificationCodeRegister
{

    
    if (_phoneTf.text.length==0) {
        [MessageAlertView showErrorMessage:@"请输入手机号"];
        return;
    }
    else if (_phoneTf.text.length!=11)
    {
        [MessageAlertView showErrorMessage:@"请输入正确的手机号"];
        return;
    }
    
    __block NSInteger second = 60;
    //全局队列    默认优先级
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //定时器模式  事件源
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    //NSEC_PER_SEC是秒，＊1是每秒
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), NSEC_PER_SEC * 1, 0);
    //设置响应dispatch源事件的block，在dispatch源指定的队列上运行
    dispatch_source_set_event_handler(timer, ^{
        //回调主线程，在主线程中操作UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second >= 0) {
                [_codeBtn setTitle:[NSString stringWithFormat:@"%ld秒",(long)second] forState:UIControlStateNormal];
                second--;
                [_codeBtn setEnabled:NO];
                _codeBtn.alpha=0.4;
                _codeBtn.backgroundColor=[UIColor grayColor];
            }
            else
            {
                //这句话必须写否则会出问题
                dispatch_source_cancel(timer);
                [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [_codeBtn setEnabled:YES];
                _codeBtn.alpha=1;
                _codeBtn.backgroundColor=AppBackColor;
            }
        });
    });
    //启动源
    dispatch_resume(timer);
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                       _phoneTf.text,@"mobile",
                       
                       nil];
    [[NetWorkManager sharedManager]postJSON:verificationCoderegister parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic=(NSDictionary *)responseObject;
        if ([dic[@"status"]boolValue]) {
            [MessageAlertView showSuccessMessage:@"发送成功"];
        }
        else
        {
            [MessageAlertView showErrorMessage:[NSString stringWithFormat:@"%@",dic[@"info"]]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
}
-(void)registerClick
{
    
 

    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                      _phoneTf.text,@"mobile",
                      _passTf.text,@"password",
                      _codeTf.text,@"code",
                       @"QD0087",@"no",

                       nil];
    [[NetWorkManager sharedManager]postJSON:doregister parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic=(NSDictionary *)responseObject;
        
        if ([dic[@"status"]boolValue]) {
            [MessageAlertView showSuccessMessage:@"注册成功"];
            UIViewController *viewCtl = self.navigationController.viewControllers[self.navigationController.viewControllers.count-3];
            
            [self.navigationController popToViewController:viewCtl animated:YES];
        }else
        {
            [MessageAlertView showErrorMessage:[NSString stringWithFormat:@"%@",dic[@"info"]]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
//
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == _phoneTf) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
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
