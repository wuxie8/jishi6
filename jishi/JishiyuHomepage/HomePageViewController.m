//
//  HomePageViewController.m
//  haitian
//
//  Created by Admin on 2017/4/12.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "HomePageViewController.h"
#import "ASValueTrackingSlider.h"
#import "CertificationViewController.h"
#import "BaseViewController.h"
#import "OtherContactsViewController.h"
#define ImageHeight 220
#define viewHeight 80
@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource,ASValueTrackingSliderDataSource>
@property(strong, nonatomic)UIView*headView;
@end

@implementation HomePageViewController
{
    NSArray *arr1;
    NSArray *arr2;
    NSArray *arr3;
    int value1;
    int value2;
    UILabel *label2;

    UILabel *label4;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=BaseColor;
    arr1=@[@"applyFor",@"audit",@"borrow"];
     arr2=@[@"APP申请，大数据授信",@"极速审核，当天到账",@"借款灵活，还款无压力"];
     arr3=@[@"动动手指就能借款，无需繁琐流程",@"3分钟前填资料，30分钟审核，1天到账",@"最高1万元额度，支持12个月超长分期"];
    value1=5000;
    value2=12;
    UITableView *tab=[[UITableView alloc]initWithFrame:CGRectMake(0,0, WIDTH, HEIGHT-44)];
    tab.delegate=self;
    tab.tableHeaderView=self.headView;
    tab.dataSource=self;
    [self.view addSubview:tab];
    // Do any additional setup after loading the view.
}


-(UIView *)headView
{
    if (!_headView) {
        _headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 520)];
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH,  ImageHeight)];
        [image setImage:[UIImage imageNamed:@"banner"]];
        [_headView addSubview:image];
        
        UIView *whiteView=[[UIView alloc]initWithFrame:CGRectMake(0,  ImageHeight, WIDTH, viewHeight)];
        whiteView.backgroundColor=[UIColor grayColor];
        [_headView addSubview:whiteView];
        
        
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(21,  ImageHeight-13, WIDTH-21*2, viewHeight)];
        view.backgroundColor=[UIColor whiteColor];
        [_headView addSubview:view];
        
        
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(60, 10, 100, 20)];
        label1.text=@"每月还款 ";
        label1.font=[UIFont systemFontOfSize:14];
        label1.center=CGPointMake(WIDTH/2-(WIDTH/2-20)/2, label1.center.y);
        label1.textAlignment=NSTextAlignmentCenter;
        [view addSubview:label1];
        
        label2=[[UILabel alloc]initWithFrame:CGRectMake(38, CGRectGetMaxY(label1.frame)+10, 100, 20)];
        label2.text=@"953～1033";
        CGPoint point=CGPointMake(label1.center.x, label2.center.y);
        label2.center=point;
          label2.font=[UIFont systemFontOfSize:14];
            label2.textAlignment=NSTextAlignmentCenter;
        [view addSubview:label2];
        
      UILabel *  label3=[[UILabel alloc]initWithFrame:CGRectMake(60+WIDTH/2, 10, 100, 20)];
        label3.center=CGPointMake(WIDTH/2+(WIDTH/2-20)/2, label3.center.y);
        label3.text=@"还款期限 ";
          label3.font=[UIFont systemFontOfSize:14];
         label3.textAlignment=NSTextAlignmentCenter;
        [view addSubview:label3];
        
        
        label4=[[UILabel alloc]initWithFrame:CGRectMake(60+WIDTH/2, CGRectGetMaxY(label3.frame)+10, 100, 20)];
        label4.text=@"12个月";
        label4.font=[UIFont systemFontOfSize:14];
         label4.textAlignment=NSTextAlignmentCenter;
        label4.center=CGPointMake(label3.center.x, label4.center.y);
        [view addSubview:label4];
        _headView.backgroundColor=[UIColor whiteColor];
        
        UIView *view1 =[[UIView alloc]initWithFrame:CGRectMake(0,  CGRectGetMaxY(whiteView.frame), WIDTH, 210)];
        
        UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(42, 50, 40, 20)];
        lab1.text=@"金额";
        lab1.font=[UIFont systemFontOfSize:14];
        [view1 addSubview:lab1];
        ASValueTrackingSlider *asValue=[[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lab1.frame)+10, 50, 250, 10)];
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
       
        
        UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(42, CGRectGetMaxY(lab1.frame)+50, 40, 20)];
        lab2.text=@"期限";
           lab2.font=[UIFont systemFontOfSize:14];
        [view1 addSubview:lab2];
        
        ASValueTrackingSlider *asValue2=[[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lab2.frame)+10, CGRectGetMaxY(lab1.frame)+50, 250, 20)];
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
        
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(18, CGRectGetMaxY(lab2.frame)+30, WIDTH-36, 50)];
        [but setImage:[UIImage imageNamed:@"ApplyImmediately"] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(applyForLoan) forControlEvents:UIControlEventTouchUpInside];
        [view1 addSubview:but];
        
        UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view1.frame)+15, WIDTH, 5)];
        view2.backgroundColor=AppPageColor;
         [_headView addSubview:view1];
        [_headView addSubview:view2];
       
    }
    return _headView;
}
-(void)applyForLoan
{
    BaseViewController *certification=[[BaseViewController alloc]init];
    certification.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:certification animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;

}
- (NSString *)slider:(ASValueTrackingSlider *)slider stringForValue:(float)value;
{
    return [NSString stringWithFormat:@"%d个月",value2];
}
- (void)sliderValueChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    switch (slider.tag) {
        case 1001:

            value1=slider.value;
            value1=value1/100*100;
            label2.text=[NSString stringWithFormat:@"%d",value1/value2];

            break;
           case 1002:
            value2=slider.value;
            label4.text=[NSString stringWithFormat:@"%d个月",value2];
            label2.text=[NSString stringWithFormat:@"%d",value1/value2];

        default:
            break;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3    ;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    
    [cell.imageView setContentMode:UIViewContentModeScaleAspectFill];
    cell.imageView.clipsToBounds=YES;
    cell.imageView.image=[UIImage imageNamed:arr1[indexPath.row]];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.text=arr2[indexPath.row];
    cell.detailTextLabel.text=arr3[indexPath.row];
    return cell;
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
