//
//  XianJinSuDaiViewController.m
//  jishi
//
//  Created by Admin on 2017/7/27.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "XianJinSuDaiViewController.h"
#import "ASValueTrackingSlider.h"
#import "BaseViewController.h"
#import "KLandscapePickerView.h"
#import "WebVC.h"
#define viewHeight 80
#define ImageHeight 220


@interface XianJinSuDaiViewController ()<ASValueTrackingSliderDataSource,KLanscapePickerViewDataSource, KLanscapePickerViewDelegate>

@property(strong, nonatomic)UIView*loadHeadView;
@property(strong, nonatomic)UIView *loadMiddleView;
@end

@implementation XianJinSuDaiViewController
{
    UILabel *label2;
    UILabel *label4;
    UILabel *label6;
    int edu;
    int qixian;
    UILabel *lab22;
    NSString *month;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    edu=4800;
    qixian=12;
    month=@"12个月";

    [self.view addSubview:self.loadHeadView];
    [self.view addSubview:self.loadMiddleView];
    // Do any additional setup after loading the view.
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
        
        UILabel *appTitle=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconImageView.frame)+20, 5, 150, 30)];
        appTitle.text=@"流程简单 极速放款";
        appTitle.font=[UIFont systemFontOfSize:16];
        [blueview addSubview:appTitle];
        
        UILabel *testLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 200, 70)];
        
        //    testLabel.backgroundColor = [UIColor lightGrayColor];
        
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
//     
//        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(21,  40, WIDTH-21*2, viewHeight)];
//        view.backgroundColor=[UIColor whiteColor];
//        [_loadMiddleView addSubview:view];
        
        
//        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(60, 20, 100, 20)];
//        label1.text=@"我要借";
//        label1.center=CGPointMake(WIDTH/2-20, label1.center.y);
//        label1.textAlignment=NSTextAlignmentCenter;
//        [view addSubview:label1];
        
//        label2=[[UILabel alloc]initWithFrame:CGRectMake(38, CGRectGetMaxY(label1.frame)+10, 100, 20)];
//        label2.text=@"4800";
//        CGPoint point=CGPointMake(label1.center.x, label2.center.y);
//        label2.center=point;
//        label2.font=[UIFont boldSystemFontOfSize:16];
//        label2.textAlignment=NSTextAlignmentCenter;
//        [view addSubview:label2];
//        
//        UILabel *  label3=[[UILabel alloc]initWithFrame:CGRectMake(30+WIDTH/2, 10, 100, 20)];
//        label3.center=CGPointMake(WIDTH/4*3-20, label3.center.y);
//        label3.text=@"还款期限";
//        label3.textAlignment=NSTextAlignmentCenter;
//        [view addSubview:label3];
//        
//        
//        label4=[[UILabel alloc]initWithFrame:CGRectMake(60+WIDTH/2, CGRectGetMaxY(label3.frame)+10, 100, 20)];
//        label4.text=@"12个月";
//        label4.font=[UIFont boldSystemFontOfSize:16];
//        label4.textAlignment=NSTextAlignmentCenter;
//        label4.center=CGPointMake(label3.center.x, label4.center.y);
//        [view addSubview:label4];
//        
//        UILabel *  label5=[[UILabel alloc]initWithFrame:CGRectMake(30+WIDTH/2, 10, 100, 20)];
//        label5.center=CGPointMake(WIDTH/2-20, label3.center.y);
//        label5.text=@"还款金额";
//        label5.textAlignment=NSTextAlignmentCenter;
//        [view addSubview:label5];
//        
//        
//        label6=[[UILabel alloc]initWithFrame:CGRectMake(60+WIDTH/2, CGRectGetMaxY(label5.frame)+10, 100, 20)];
//        label6.text=@"400";
//        label6.font=[UIFont boldSystemFontOfSize:16];
//        label6.textAlignment=NSTextAlignmentCenter;
//        label6.center=CGPointMake(label5.center.x, label4.center.y);
//        [view addSubview:label6];
//        
        _loadMiddleView.backgroundColor=[UIColor whiteColor];
        
        UIView *view1 =[[UIView alloc]initWithFrame:CGRectMake(0,  20, WIDTH, 400)];
        view1.userInteractionEnabled=YES;
        UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-200, 20, 200, 20)];
        lab1.text=@"我要借（元）";
        lab1.textAlignment=NSTextAlignmentRight;
        lab1.font=[UIFont systemFontOfSize:14];
        [view1 addSubview:lab1];
        label2=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2+10, 20, 100, 20)];
        label2.text=@"5000";
        label2.textColor=kColorFromRGBHex(0xfec9a0);
        label2.textAlignment=NSTextAlignmentLeft;
        label2.font=[UIFont systemFontOfSize:24];
        [view1 addSubview:label2];
        ASValueTrackingSlider *asValue=[[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(WIDTH/2-100, CGRectGetMaxY(lab1.frame)+50, 250, 10)];
        asValue.maximumValue=10000;
        asValue.minimumValue=1000;
        asValue.value=5000;
        //        asValue.dataSource=self;
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
        
        
        UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-150, CGRectGetMaxY(asValue.frame)+50, 150, 20)];
        lab2.text=@"借款期限";
        lab2.textAlignment=NSTextAlignmentRight;
        lab2.font=[UIFont systemFontOfSize:14];
        [view1 addSubview:lab2];
       lab22=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2+10, CGRectGetMaxY(asValue.frame)+50, 100, 20)];
        lab22.text=@"12个月";
        lab22.textAlignment=NSTextAlignmentLeft;
        lab22.textColor=kColorFromRGBHex(0x2591f3);

        lab22.font=[UIFont systemFontOfSize:20];
        [view1 addSubview:lab22];
        
       
        KLandscapePickerView *pickerView = [[KLandscapePickerView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lab22.frame)+20, WIDTH, 50)];
        pickerView.dataSource = self;
        pickerView.delegate = self;
        [pickerView initLandscapePickerView];
        [view1 addSubview:pickerView];
     
        ASValueTrackingSlider *asValue2=[[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(WIDTH/2-120, CGRectGetMaxY(lab2.frame)+50, 250, 20)];
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
        
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(18, CGRectGetMaxY(pickerView.frame)+80, WIDTH-36, 50)];
        [but setImage:[UIImage imageNamed:@"ApplyImmediately"] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(applyForLoan) forControlEvents:UIControlEventTouchUpInside];
        [view1 addSubview:but];
        
        UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view1.frame)+15, WIDTH, 5)];
        view2.backgroundColor=AppPageColor;
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
            label2.text=[NSString stringWithFormat:@"%d",edu];
            label6.text=[NSString stringWithFormat:@"%d",edu/qixian];
        }
            break;
        case 1002:
        {
            qixian=slider.value;
            label4.text=[NSString stringWithFormat:@"%d个月",(int)slider.value];
            label6.text=[NSString stringWithFormat:@"%d",edu/qixian];
        }
            
        default:
            break;
    }
}
- (NSString *)slider:(ASValueTrackingSlider *)slider stringForValue:(float)value;
{
    return [NSString stringWithFormat:@"%d个月",(int)value];
}


#pragma mark KLandscapePickerView
- (NSInteger)numberOfRowInPickerView:(KLandscapePickerView *)pickerView{
    return 1;
}

- (NSInteger)numberOfColumnInPickerView:(KLandscapePickerView *)pickerView row:(NSInteger)row{
    if (row == 0) {
        return 12;
    }else{
        return 6;
    }
}
- (void)pickerView:(KLandscapePickerView *)pickerView didSelectColumn:(NSInteger)column InRow:(NSInteger)row title:(NSString *)title{
    if (![title isEqualToString:month]) {
        month=title;
        lab22.text=month;
    };
}


- (NSArray *)titleOfColumnInPickerView:(KLandscapePickerView *)pickerView row:(NSInteger)row{
    if (row == 0) {
        return [NSArray arrayWithObjects:@"1个月",@"2个月",@"3个月",@"4个月",@"5个月",@"6个月",@"7个月",@"8个月",@"9个月",@"10个月",@"11个月",@"12个月", nil];
    }else {
        return @[ @"默认排序", @"价格由高到低", @"价格由低到高", @"面积由大到小", @"面积由小到大", @"更新时间"];
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


