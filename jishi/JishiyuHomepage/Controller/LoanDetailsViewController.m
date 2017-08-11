//
//  LoanDetailsViewController.m
//  jishi
//
//  Created by Admin on 2017/5/9.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "LoanDetailsViewController.h"
#import "BtnView.h"
#import "WebVC.h"
#define margen 30

@interface LoanDetailsViewController ()

@end

@implementation LoanDetailsViewController
{
    int edu;
    int qixian;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"贷款详情";
    self.view.backgroundColor=AppPageColor;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-50)];
         [self.view addSubview:scrollView];
       scrollView.contentSize = self.view.frame.size;
    scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 5, WIDTH, 110)];
    view.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:view];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 90, 90)];
    image.backgroundColor=[UIColor whiteColor];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"review"]) {
        [image setImage:[UIImage imageNamed:self.product.smeta]];
    }
    else
    {
        [image setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMG_PATH,self.product.smeta]]];
    }

    [view addSubview:image];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(image.frame)+10, 10, WIDTH-CGRectGetMaxX(image.frame)-20, 30)];
    label.text=self.product.post_title;
//    label.adjustsFontSizeToFitWidth=YES;
    label.font=[UIFont systemFontOfSize:14*Context.rectScaleX];
    [view addSubview:label];
    NSArray *titleArr = self.product.tagsArray;

    UIView *btnview=[BtnView creatBtnWithArray:titleArr frame:CGRectMake(CGRectGetMaxX(image.frame)+10, CGRectGetMaxY(label.frame), WIDTH-CGRectGetMaxX(image.frame)-10, 40)];
    [view addSubview:btnview];
    
    UILabel *detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(image.frame)+10, CGRectGetMaxY(btnview.frame), 150, 20)];
    detailLabel.text=[NSString stringWithFormat:@"%@人成功申请",self.product.post_hits];
    detailLabel.font=[UIFont systemFontOfSize:13];
    [view addSubview:detailLabel];
    
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame), WIDTH, 30)];
    view1.backgroundColor=[UIColor whiteColor];
    view1.layer.borderWidth=1;
    view1.layer.borderColor=[UIColor grayColor].CGColor;
    [scrollView addSubview:view1];
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, WIDTH-40, 20)];
    if (![UtilTools isBlankString:self.product.post_excerpt]) {
        label1.text=self.product.post_excerpt;

    }
    label1.font=[UIFont systemFontOfSize:13];
    [view1 addSubview:label1];
    
    UIView *yellowView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view1.frame)+10, WIDTH, 100)];
    yellowView.backgroundColor=kColorFromRGBHex(0xfffcf5);
    [scrollView addSubview:yellowView];
    
    UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(margen, 20, WIDTH/2-margen*2, margen)];
    textField.delegate=self;
    textField.tag=500;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    NSString *maxString;
    if ([self.product.edufanwei rangeOfString:@"-"].location == NSNotFound) {
        NSArray *arr=   [self.product.edufanwei   componentsSeparatedByString:@","];
        maxString=[arr lastObject];
    }
    else
    {
        NSRange range=[self.product.edufanwei rangeOfString:@"-"];
        maxString=[self.product.edufanwei substringFromIndex:(range.location+1)];
    }
    
  
    textField.text=maxString;
    edu=[maxString intValue];
    UILabel *unitLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(textField.frame)-30, 0, 30, 20)];
    unitLabel.text=@"元";
    unitLabel.textColor=[UIColor grayColor];
    [textField setRightView:unitLabel];
      [textField setRightViewMode:UITextFieldViewModeAlways];
    [yellowView addSubview:textField];

    UITextField *textField1=[[UITextField alloc]initWithFrame:CGRectMake(WIDTH/2+margen, 20, WIDTH/2-margen*2, 30)];
    textField1.delegate=self;
    textField1.tag=501;
    NSString *maxString1;
    if ([self.product.qixianfanwei rangeOfString:@"-"].location == NSNotFound) {
        NSArray *arr=   [self.product.qixianfanwei   componentsSeparatedByString:@","];
        maxString1=[arr lastObject];
    }
    else
    {
        NSRange range1=[self.product.qixianfanwei rangeOfString:@"-"];
        maxString1=[self.product.qixianfanwei substringFromIndex:(range1.location+1)];
    }
    maxString1=[maxString1 substringToIndex:maxString1.length-1];
    textField1.text=maxString1;
    qixian=[maxString1 intValue];
    if ([self.product.post_title isEqualToString:@"平安i贷"]) {
        qixian=20;
        textField1.text=@"20";

    }
    textField1.borderStyle = UITextBorderStyleRoundedRect;
    textField1.keyboardType = UIKeyboardTypeNumberPad;
    UILabel *unitLabel1=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(textField1.frame)-30, 0, 30, 20)];
    unitLabel1.text=[self.product.fv_unit isEqualToString:@"1"]?@"天":@"月";
    if ([self.product.post_title isEqualToString:@"平安i贷"]) {
        unitLabel1.text=@"月";
    }
    unitLabel1.textColor=[UIColor grayColor];
    [textField1 setRightView:unitLabel1];
    [textField1 setRightViewMode:UITextFieldViewModeAlways];
    [yellowView addSubview:textField1];
    
    
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(margen, CGRectGetMaxY(textField.frame)+20, WIDTH/2-margen*2, 30)];
    label3.text=[NSString stringWithFormat:@"额度范围：%@元",self.product.edufanwei];
    label3.adjustsFontSizeToFitWidth=YES;
    [yellowView addSubview:label3];

    
    UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(margen+WIDTH/2, CGRectGetMaxY(textField.frame)+20, WIDTH/2-margen*2, 30)];
    label4.text=[NSString stringWithFormat:@"期限范围：%@",self.product.qixianfanwei];
    label4.adjustsFontSizeToFitWidth=YES;
    [yellowView addSubview:label4];
    
    UIView *view4=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(yellowView.frame), WIDTH, 100)];
    view4.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:view4];
    for (int i=0; i<3; i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/3*i, 30, WIDTH/3, 20)];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=AppBlue;
        label.tag=1000+i;
        [view4 addSubview:label];
        
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/3*i, CGRectGetMaxY(label.frame)+10, WIDTH/3, 20)];
        label1.text=@"500-1000元";
        label1.tag=100+i;
        label1.textAlignment=NSTextAlignmentCenter;

        [view4 addSubview:label1];
        UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(WIDTH/3*i, 10, 1, 80)];
        backgroundView.backgroundColor=[UIColor lightGrayColor];
        [view4 addSubview:backgroundView];
        switch (i) {
            case 0:
            {        label.text=self.product.feilv;
                label1.text=[self.product.fv_unit isEqualToString:@"1"]?@"参考日利率":@"参考月利率";
            
            }
                break;
            case 1:
            {
                
                if([self.product.feilv containsString:@"-"])
                {
                    NSArray *array = [self.product.feilv componentsSeparatedByString:@"-"]; //从字符A中分隔成2个元素的数组

                    float feilv1=edu/qixian+edu*[[array firstObject] floatValue]/100;
                    
                    float feilv2=edu/qixian+edu*[[array lastObject] floatValue]/100;

                    label.text=[NSString stringWithFormat:@"%d-%d",(int)feilv1,(int)feilv2];
                }
                else{
                    
                    float feilv=edu/qixian+edu*[self.product.feilv floatValue]/100;
                    
                    label.text=[NSString stringWithFormat:@"%d",(int)feilv];
                }
                
                
                label1.text=[self.product.fv_unit isEqualToString:@"1"]?@"每日还款":@"每月还款";

            }
                break;
            case 2:
            {        label.text=self.product.zuikuaifangkuan;
                label1.text=@"最快放款时间";

            }
                break;
            default:
                break;
        }
    }
    UIView *view5=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view4.frame), WIDTH, 40)];
    view5.layer.borderWidth=1;
    view5.layer.borderColor=[UIColor grayColor].CGColor;
    view5.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:view5];
    
    UILabel *label5=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, WIDTH, 30)];
    label5.text=[self.product.fv_unit isEqualToString:@"1"]?@"按日计息，随借随还":@"参考月利率";
    label5.textAlignment=NSTextAlignmentCenter;
    [view5 addSubview:label5];
    view5.layer.borderWidth=1;
    
    UIView *view6=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view5.frame)+20, WIDTH, HEIGHT-CGRectGetMaxY(view5.frame)-20)];
    view6.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:view6];
    UILabel *label6=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, WIDTH-20, 30)];
    label6.textAlignment=NSTextAlignmentCenter;
    label6.text=@"申请条件";
    label6.textColor=AppBlue;
    [view6 addSubview:label6];
    UILabel *_feliv_Label=[[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(label6.frame)+20, WIDTH-40, 70)];
    [_feliv_Label setText:self.product.shenqingtiaojian];
    [_feliv_Label setTextColor:[UIColor grayColor]];
    _feliv_Label.lineBreakMode = NSLineBreakByCharWrapping;//换行模式，与上面的计算保持一致。
    _feliv_Label.numberOfLines=0;
    _feliv_Label.textAlignment=NSTextAlignmentLeft;
    _feliv_Label.font=[UIFont systemFontOfSize:16];
    [view6 addSubview:_feliv_Label];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"review"]) {
    
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(10, HEIGHT-64-50, WIDTH-20, 40)];
        but.backgroundColor=AppBlue;
    
        [but setTitle:@"马上申请" forState:UIControlStateNormal];
        [but addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:but];
    }
    // Do any additional setup after loading the view.
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}
-(void)click
{
    
    if ([self.product.post_title isEqualToString:@"现金巴士"]) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
      

        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                           Context.currentUser.username,@"mobile",
                           [NSString stringWithFormat:@"%d",edu],@"amount",
                            [NSString stringWithFormat:@"%d",qixian],@"loandays",
                           nil];
        NSString *urlStr = [NSString stringWithFormat:@"http://app.jishiyu11.cn:81/api/cashbus/url"];
        [manager POST:urlStr parameters:dic progress:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {
            NSDictionary *imagedic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:nil];
            NSString *link=[[imagedic objectForKey:@"data"]objectForKey:@"url"];

            WebVC *vc = [[WebVC alloc] init];
            [vc setNavTitle:self.product.post_title];
            [vc loadFromURLStr:link];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:NO];
        } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
            DLog(@"%@",error);
            
        } ];
    }
    else
    {
        WebVC *vc = [[WebVC alloc] init];
        [vc setNavTitle:self.product.post_title];
        [vc loadFromURLStr:self.product.link];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:NO];
    }
  

  
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if ([self.product.post_title isEqualToString:@"平安i贷"]&&textField.tag==501) {
       
        return NO;
        
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (textField.tag==500) {
        //字条串是否包含有某字符串
        if ([self.product.edufanwei rangeOfString:@"-"].location == NSNotFound) {
            NSArray *arr=   [self.product.edufanwei   componentsSeparatedByString:@","];
            if (![arr containsObject:textField.text]) {
                [MessageAlertView  showErrorMessage:@"请输入正确金额"];
                textField.text=[NSString stringWithFormat:@"%d",edu];
            }
            else
            {
                edu=[textField.text intValue];
                UILabel *label=[self.view viewWithTag:1001];
                if (qixian) {
                    float feilv=edu/qixian+edu*[self.product.feilv floatValue]/100;
                    
                    label.text=[NSString stringWithFormat:@"%d",(int)feilv ];
                }
        

            }
                  } else {
            NSArray *array = [self.product.edufanwei componentsSeparatedByString:@"-"]; //从字符A中分隔成2个元素的数组
            if ([textField.text intValue]<[array[0]intValue]) {
                [MessageAlertView showErrorMessage:@"不能小于最小额度"];
                textField.text=[NSString stringWithFormat:@"%d",edu];

            }
            if ([textField.text intValue]>[array[1]intValue]) {
                [MessageAlertView showErrorMessage:@"不能大于最大额度"];
                textField.text=[NSString stringWithFormat:@"%d",edu];

                
            }else
            {
                edu=[textField.text intValue];
                UILabel *label=[self.view viewWithTag:1001];
                if (qixian) {
                    float feilv=edu/qixian+edu*[self.product.feilv floatValue]/100;
                    
                    label.text=[NSString stringWithFormat:@"%d",(int)feilv ];
                }
           
                
            }
                    

        }
    }
    else
    {
        //字条串是否包含有某字符串
        if ([self.product.qixianfanwei rangeOfString:@"-"].location == NSNotFound) {
            
            NSArray *arr=   [self.product.edufanwei   componentsSeparatedByString:@","];
            if (![arr containsObject:textField.text]) {
                [MessageAlertView  showErrorMessage:@"请输入正确期限"];
                textField.text=[NSString stringWithFormat:@"%d",qixian];

            }
            else
            {
                qixian=[textField.text intValue];
                UILabel *label=[self.view viewWithTag:1001];
                if (qixian) {
                    float feilv=edu/qixian+edu*[self.product.feilv floatValue]/100;
                    
                    label.text=[NSString stringWithFormat:@"%d",(int)feilv ];
                }
              
                
            }

        } else {
            NSArray *array = [self.product.qixianfanwei componentsSeparatedByString:@"-"]; //从字符A中分隔成2个元素的数组
            if ([textField.text intValue]<[array[0]intValue]) {
                [MessageAlertView showErrorMessage:@"不能小于最小期限"];
                textField.text=[NSString stringWithFormat:@"%d",qixian];

            }
            if ([textField.text intValue]>[array[1]intValue]) {
                [MessageAlertView showErrorMessage:@"不能大于最大期限"];
                textField.text=[NSString stringWithFormat:@"%d",qixian];

            }
            else
            {
                qixian=[textField.text intValue];
                UILabel *label=[self.view viewWithTag:1001];
                if (qixian) {
                    float feilv=edu/qixian+edu*[self.product.feilv floatValue]/100;
                    
                    label.text=[NSString stringWithFormat:@"%d",(int)feilv ];
                }
    
                

            }

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
