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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"贷款详情";
    self.view.backgroundColor=AppPageColor;
    
     
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 5, WIDTH, 110)];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
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
    [view addSubview:label];
//    NSArray *titleArr = @[@"医德高尚",@"非常耐心",@"回复非常及时、满意",@"意见很有帮助",@"非常认真敬业",@"非常清楚"];
    NSArray *titleArr = @[@"意见很有帮助",@"非常认真敬业",@"非常清楚"];

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
    [self.view addSubview:view1];
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, WIDTH, 20)];
    if (![UtilTools isBlankString:self.product.post_excerpt]) {
        label1.text=self.product.post_excerpt;

    }

    [view1 addSubview:label1];
    
    UIView *yellowView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view1.frame)+10, WIDTH, 100)];
    yellowView.backgroundColor=kColorFromRGBHex(0xfffcf5);
    [self.view addSubview:yellowView];
    
    UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(margen, 20, WIDTH/2-margen*2, margen)];
    textField.delegate=self;
    textField.tag=500;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.keyboardType = UIKeyboardTypeNumberPad;

    textField.placeholder=@"1000";
    UILabel *unitLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(textField.frame)-30, 0, 30, 20)];
    unitLabel.text=@"元";
    unitLabel.textColor=[UIColor grayColor];
    [textField setRightView:unitLabel];
      [textField setRightViewMode:UITextFieldViewModeAlways];
    [yellowView addSubview:textField];

    UITextField *textField1=[[UITextField alloc]initWithFrame:CGRectMake(WIDTH/2+margen, 20, WIDTH/2-margen*2, 30)];
    textField1.delegate=self;
    textField.tag=501;
    textField1.placeholder=@"30";
    textField1.borderStyle = UITextBorderStyleRoundedRect;
    textField1.keyboardType = UIKeyboardTypeNumberPad;
    UILabel *unitLabel1=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(textField1.frame)-30, 0, 30, 20)];
    unitLabel1.text=@"天";
    unitLabel1.textColor=[UIColor grayColor];
    [textField1 setRightView:unitLabel1];
    [textField1 setRightViewMode:UITextFieldViewModeAlways];
    [yellowView addSubview:textField1];
    
    
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(margen, CGRectGetMaxY(textField.frame)+20, WIDTH/2-margen*2, 30)];
    label3.text=[NSString stringWithFormat:@"额度范围：%@元",self.product.edufanwei];
    label3.adjustsFontSizeToFitWidth=YES;
    [yellowView addSubview:label3];
    
    
    UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(margen+WIDTH/2, CGRectGetMaxY(textField.frame)+20, WIDTH/2-margen*2, 30)];
    label4.text=[NSString stringWithFormat:@"期限范围：%@天",self.product.qixianfanwei];
    label4.font=[UIFont systemFontOfSize:14];

    [yellowView addSubview:label4];
    
    UIView *view4=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(yellowView.frame), WIDTH, 100)];
    view4.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view4];
    for (int i=0; i<3; i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/3*i, 30, WIDTH/3, 20)];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=AppBlue;
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
            {   label.text=self.product.zuikuaifangkuan;
                label1.text=@"最快放款时间";
                
            }
                break;
            case 2:
            {        label.text=self.product.zuikuaifangkuan;
                label1.text=[self.product.fv_unit isEqualToString:@"1"]?@"每日还款":@"每月还款";
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
    [self.view addSubview:view5];
    
    UILabel *label5=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, WIDTH, 30)];
    label5.text=[self.product.fv_unit isEqualToString:@"1"]?@"按日计息，随借随还":@"参考月利率";
    label5.textAlignment=NSTextAlignmentCenter;
    [view5 addSubview:label5];
    view5.layer.borderWidth=1;
    
    UIView *view6=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view5.frame)+20, WIDTH, 100)];
    view6.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view6];
    UILabel *label6=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, WIDTH-20, 30)];
    label6.textAlignment=NSTextAlignmentCenter;
    label6.text=@"产品详情";
    label6.textColor=AppBlue;
    [view6 addSubview:label6];
    UILabel *_feliv_Label=[[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(label6.frame)-20, WIDTH-40, 70)];
    [_feliv_Label setText:self.product.shenqingtiaojian];
    [_feliv_Label setTextColor:[UIColor grayColor]];
    _feliv_Label.lineBreakMode = NSLineBreakByCharWrapping;//换行模式，与上面的计算保持一致。
    _feliv_Label.numberOfLines=0;
    _feliv_Label.textAlignment=NSTextAlignmentLeft;
    _feliv_Label.font=[UIFont systemFontOfSize:16];
    [view6 addSubview:_feliv_Label];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"review"]) {
    
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(10, HEIGHT-50, WIDTH-20, 40)];
        but.backgroundColor=AppBlue;
        [but setTitle:@"马上申请" forState:UIControlStateNormal];
        [but addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:but];
    }
    // Do any additional setup after loading the view.
}
-(void)click
{
   

    WebVC *vc = [[WebVC alloc] init];
    [vc setNavTitle:self.product.post_title];
    [vc loadFromURLStr:self.product.link];
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:NO];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (textField.tag==501) {
        //字条串是否包含有某字符串
        if ([self.product.edufanwei rangeOfString:@"-"].location == NSNotFound) {
                  } else {
            NSArray *array = [self.product.edufanwei componentsSeparatedByString:@"-"]; //从字符A中分隔成2个元素的数组
            if ([textField.text intValue]<[array[0]intValue]) {
                [MessageAlertView showErrorMessage:@"不能小于最小额度"];
            }
            if ([textField.text intValue]>[array[1]intValue]) {
                [MessageAlertView showErrorMessage:@"不能大于最大额度"];
                
            }
        }
    }
    else
    {
        //字条串是否包含有某字符串
        if ([self.product.edufanwei rangeOfString:@"-"].location == NSNotFound) {
        } else {
            NSArray *array = [self.product.edufanwei componentsSeparatedByString:@"-"]; //从字符A中分隔成2个元素的数组
            if ([textField.text intValue]<[array[0]intValue]) {
                [MessageAlertView showErrorMessage:@"不能小于最小期限"];
            }
            if ([textField.text intValue]>[array[1]intValue]) {
                [MessageAlertView showErrorMessage:@"不能大于最大期限"];
                
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
