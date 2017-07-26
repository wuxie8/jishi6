//
//  JishiyudaikuanViewController.m
//  jishi
//
//  Created by Admin on 2017/7/26.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "JishiyudaikuanViewController.h"
#import "ASValueTrackingSlider.h"
#import "BaseViewController.h"
#define viewHeight 80
#define ImageHeight 220

@interface JishiyudaikuanViewController ()<ASValueTrackingSliderDataSource>

@property(strong, nonatomic)UIView*loadHeadView;
@property(strong, nonatomic)UIView *loadMiddleView;
@end

@implementation JishiyudaikuanViewController
{
    UILabel *label2;
    UILabel *label4;
    UILabel *eduLabel3;
    UILabel *eduLabel;
    int edu;
    int qixian;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    edu=5000;
    qixian=12;
    [self.view addSubview:self.loadHeadView];
    [self.view addSubview:self.loadMiddleView];
}
-(UIView *)loadHeadView
{
    if (!_loadHeadView) {
        _loadHeadView=[[UIView alloc]initWithFrame:CGRectMake(0 , 0, WIDTH, 240)];
        _loadHeadView.backgroundColor=AppButtonbackgroundColor;
        UIView *blueview=[[UIView alloc]initWithFrame:CGRectMake(10, 50, WIDTH-10*2, 160)];
        blueview.backgroundColor=kColorFromRGBHex(0x348cdf);
        [_loadHeadView addSubview:blueview];
        UIView *deepView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH-10*2, 40)];
        deepView.backgroundColor=kColorFromRGBHex(0x2c7cc7);
        [blueview addSubview:deepView];
        UIImageView *iconImageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 20, 30)];
        [iconImageView setImage:[UIImage imageNamed:@"lightning"]];
        [blueview addSubview:iconImageView];
        
        UILabel *appTitle=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconImageView.frame)+20, 5, 200, 30)];
        appTitle.text=@"身份证贷款 简单放心";
        appTitle.font=[UIFont systemFontOfSize:16];
        [blueview addSubview:appTitle];
        
        UILabel *testLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 200, 70)];
        
        testLabel.textAlignment = NSTextAlignmentLeft;
        testLabel.numberOfLines=0;
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"信用额度(元)\n10000"];
        
        [AttributedStr addAttribute:NSFontAttributeName
         
                              value:[UIFont systemFontOfSize:28]
         
                              range:NSMakeRange(8, 5)];
        
        [AttributedStr addAttribute:NSForegroundColorAttributeName
         
                              value:[UIColor whiteColor]
         
                              range:NSMakeRange(8, 5)];
        
        
        testLabel.attributedText = AttributedStr;
        
        [blueview addSubview:testLabel];
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(testLabel.frame), blueview.frame.size.width, 1)];
        view.backgroundColor=AppButtonbackgroundColor;
        [blueview addSubview:view];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH-30-150, CGRectGetMaxY(view.frame)+10, 150, 20)];
        label.text=@"成功借款0次";
        label.font=[UIFont systemFontOfSize:14];
        label.textAlignment=NSTextAlignmentRight;
        [blueview addSubview:label];
    }
    return _loadHeadView;
}
-(UIView *)loadMiddleView
{
    if (!_loadMiddleView) {
        _loadMiddleView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.loadHeadView.frame), WIDTH, 520)];
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, WIDTH-20, 20)];
        lab.text=@"立即申请，马上用钱";
        [_loadMiddleView  addSubview:lab];
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(21,  40, WIDTH-21*2, viewHeight)];
        view.backgroundColor=[UIColor whiteColor];
        [_loadMiddleView addSubview:view];
        
        
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(60, 10, 100, 20)];
        label1.text=@"借款金额";
        label1.center=CGPointMake(WIDTH/4-20, label1.center.y);
        label1.textAlignment=NSTextAlignmentCenter;
        [view addSubview:label1];
        
        label2=[[UILabel alloc]initWithFrame:CGRectMake(38, CGRectGetMaxY(label1.frame)+10, 100, 20)];
        label2.text=@"4800";
        CGPoint point=CGPointMake(label1.center.x, label2.center.y);
        label2.center=point;
        label2.font=[UIFont boldSystemFontOfSize:16];
        label2.textAlignment=NSTextAlignmentCenter;
        [view addSubview:label2];
        
        UILabel *  label3=[[UILabel alloc]initWithFrame:CGRectMake(30+WIDTH/2, 10, 100, 20)];
        label3.center=CGPointMake(WIDTH/4*3-20, label3.center.y);
        label3.text=@"还款期限";
        label3.textAlignment=NSTextAlignmentCenter;
        [view addSubview:label3];
        
        
        label4=[[UILabel alloc]initWithFrame:CGRectMake(60+WIDTH/2, CGRectGetMaxY(label3.frame)+10, 100, 20)];
        label4.text=@"12个月";
        label4.font=[UIFont boldSystemFontOfSize:16];
        label4.textAlignment=NSTextAlignmentCenter;
        label4.center=CGPointMake(label3.center.x, label4.center.y);
        [view addSubview:label4];
        
        _loadMiddleView.backgroundColor=[UIColor whiteColor];
        
        UIView *view1 =[[UIView alloc]initWithFrame:CGRectMake(0,  CGRectGetMaxY(view.frame), WIDTH, 400)];
        view1.userInteractionEnabled=YES;
        UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 20, 20)];
        image1.image=[UIImage imageNamed:@"Cash"];
        [view1 addSubview:image1];
        
        UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(image1.frame)+10, 10, 150, 20)];
        lab1.text=@"我要借";
        lab1.font=[UIFont systemFontOfSize:14];
        [view1 addSubview:lab1];
        eduLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-50, 20, 100, 20)];
        eduLabel.text=@"2000";
        eduLabel.font=[UIFont systemFontOfSize:20];
        eduLabel.textAlignment=NSTextAlignmentCenter;
        [view1 addSubview:eduLabel];
        UIView *slierView1=[[UIView alloc]initWithFrame:CGRectMake(WIDTH/2-50, CGRectGetMaxY(eduLabel.frame)+5, 100, 1)];
        slierView1.backgroundColor=kColorFromRGBHex(0xababab);
        [view1 addSubview:slierView1];
        UILabel *eduLabel1=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-50, CGRectGetMaxY(slierView1.frame)+5, 100, 20 )] ;
               eduLabel1.text=@"1000-10000元";
        eduLabel1.textAlignment=NSTextAlignmentCenter;
        eduLabel1.font=[UIFont systemFontOfSize:14];
        [view1 addSubview:eduLabel1];
        UIImageView *blackView1=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(eduLabel1.frame), WIDTH, 60)];
        blackView1.image=[UIImage imageNamed:@"gradient"];
        [view1 addSubview:blackView1];
        ASValueTrackingSlider *asValue=[[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(WIDTH/2-120, CGRectGetMaxY(eduLabel1.frame)+40, 250, 10)];
        asValue.maximumValue=10000;
        asValue.minimumValue=1000;
        asValue.value=5000;
        asValue.tag=1001;
        NSNumberFormatter *tempFormatter = [[NSNumberFormatter alloc] init];
        [tempFormatter setPositivePrefix:@"¥"];
        [tempFormatter setNegativePrefix:@"¥"];
        [asValue setMaxFractionDigitsDisplayed:0];
        [asValue setNumberFormatter:tempFormatter];
        asValue.popUpViewColor = [UIColor colorWithHue:0.55 saturation:0.8 brightness:0.9 alpha:0.7];
        asValue.font = [UIFont fontWithName:@"GillSans-Bold" size:10];
        [asValue addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];// 针对值变化添加响应方法
        
        [asValue showPopUpView];
        [asValue setThumbImage:[UIImage imageNamed:@"dot"] forState:UIControlStateNormal];
        asValue.textColor = [UIColor colorWithHue:0.55 saturation:1.0 brightness:0.5 alpha:1];
        [view1 addSubview:asValue];
#pragma mark 期限
        UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(blackView1.frame)+10, 20, 20)];
        image2.image=[UIImage imageNamed:@"OverallTimeLimit"];
        [view1 addSubview:image2];
        
        UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(image2.frame)+10, CGRectGetMaxY(blackView1.frame)+10, 150, 20)];
        lab2.text=@"借款期限";
        lab2.font=[UIFont systemFontOfSize:14];
        [view1 addSubview:lab2];
       eduLabel3=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-50, CGRectGetMaxY(blackView1.frame)+20, 100, 20)];
        eduLabel3.text=@"12";
        eduLabel3.font=[UIFont systemFontOfSize:20];
        eduLabel3.textAlignment=NSTextAlignmentCenter;
        [view1 addSubview:eduLabel3];
        UIView *slierView4=[[UIView alloc]initWithFrame:CGRectMake(WIDTH/2-50, CGRectGetMaxY(eduLabel3.frame)+5, 100, 1)];
        slierView4.backgroundColor=kColorFromRGBHex(0xababab);
        [view1 addSubview:slierView4];
        UILabel *eduLabel4=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-50, CGRectGetMaxY(slierView4.frame)+5, 100, 20 )] ;
        eduLabel4.text=@"1-12个月";
        eduLabel4.textAlignment=NSTextAlignmentCenter;
        eduLabel4.font=[UIFont systemFontOfSize:14];
        [view1 addSubview:eduLabel4];

        UIImageView *blackView2=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(eduLabel4.frame), WIDTH, 60)];
        blackView2.image=[UIImage imageNamed:@"gradient"];
        [view1 addSubview:blackView2];
        
        ASValueTrackingSlider *asValue2=[[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(WIDTH/2-120, CGRectGetMaxY(eduLabel4.frame)+40, 250, 20)];
        asValue2.maximumValue=12;
        asValue2.minimumValue=1;
        //        asValue2.dataSource=self;
        asValue2.tag=1002;
        [asValue2 addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];// 针对值变化添加响应方法
        
        NSNumberFormatter *tempFormatter2 = [[NSNumberFormatter alloc] init];
        [tempFormatter2 setPositiveSuffix:@"个月"];
        [tempFormatter2 setNegativeSuffix:@"个月"];
        asValue2.value=asValue2.maximumValue;
        [asValue2 setMaxFractionDigitsDisplayed:0];
        [asValue2 setNumberFormatter:tempFormatter2];
        asValue2.popUpViewColor = [UIColor colorWithHue:0.55 saturation:0.8 brightness:0.9 alpha:0.7];
        asValue2.font = [UIFont fontWithName:@"GillSans-Bold" size:10];
        asValue2.dataSource=self;
        [asValue2 showPopUpView];
        [asValue2  setThumbImage:[UIImage imageNamed:@"dot"] forState:UIControlStateNormal];
        asValue2.textColor = [UIColor colorWithHue:0.55 saturation:1.0 brightness:0.5 alpha:1];
        [view1 addSubview:asValue2];

        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(asValue2.frame)+10, WIDTH, 50)];
        [but setImage:[UIImage imageNamed:@"ApplyImmediately"] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(applyForLoan) forControlEvents:UIControlEventTouchUpInside];
        [view1 addSubview:but];

        [_loadMiddleView addSubview:view1];
        
    }
    return _loadMiddleView;
}
-(void)applyForLoan
{
    BaseViewController *certification=[[BaseViewController alloc]init];
    certification.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:certification animated:YES];
}
- (void)sliderValueChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    switch (slider.tag) {
        case 1001:
        { edu=slider.value;
            edu=edu/100*100;
            label2.text=[NSString stringWithFormat:@"%d元",edu];
            eduLabel.text=[NSString stringWithFormat:@"%d",edu];
        }
            break;
        case 1002:
        {
            qixian=slider.value;
            label4.text=[NSString stringWithFormat:@"%d个月",(int)slider.value];
            eduLabel3.text=[NSString stringWithFormat:@"%d",qixian];
        }
            
        default:
            break;
    }
}
- (NSString *)slider:(ASValueTrackingSlider *)slider stringForValue:(float)value;
{
    return [NSString stringWithFormat:@"%d个月",(int)value];
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

