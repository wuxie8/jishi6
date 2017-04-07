//
//  JishiyuDetailsViewController.m
//  jishi
//
//  Created by Admin on 2017/3/10.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "JishiyuDetailsViewController.h"
#import "WebVC.h"
@interface JishiyuDetailsViewController ()

@property(strong, nonatomic)UIView *headView;

@property(strong, nonatomic)UIView*footView;
@property(strong, nonatomic)UIImageView*headImageView;
@end

@implementation JishiyuDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.product.post_title;
    UITableView *tab=[[UITableView alloc]initWithFrame:self.view.bounds];
    tab.delegate=self;
    tab.dataSource=self;
    tab.tableHeaderView=self.headView;
   if (![[NSUserDefaults standardUserDefaults] boolForKey:@"review"]) {
    tab.tableFooterView=self.footView;
   }
    tab.separatorStyle= UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tab];
    // Do any additional setup after loading the view.
}

- (UIView *)headView
{
    if (_headView==nil) {
        _headView                                          = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 180)];
        _headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        [_headImageView setContentMode:UIViewContentModeScaleAspectFill];
        _headImageView.clipsToBounds=YES;
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"review"]) {
            [_headImageView setImage:[UIImage imageNamed:self.product.smeta]];
            
        }
        else
        {
            [_headImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMG_PATH,self.product.smeta]]];
        }
  
        [_headView addSubview:_headImageView];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImageView.frame)+20, 10, 150, 50)];
        label.textColor=[UIColor blueColor];
        label.text=self.product.post_title;
        [_headView addSubview:label];
        NSArray *arr=@[@"额度范围：",@"费率：",@"期限范围：",@"最快放款："];
        for (int i=0; i<4; i++) {
            UILabel *_label=[[UILabel alloc]initWithFrame:CGRectMake(20+i%2*(WIDTH/2-20), CGRectGetMaxY(_headImageView.frame)+10+i/2*40, (WIDTH/2-40), 40)];
            _label.font=[UIFont systemFontOfSize:14];
           
            [_label setTextColor:[UIColor grayColor]];
            switch (i) {
                case 0:
                {NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",arr[i],self.product.edufanwei]];
                    
                    [AttributedStr addAttribute:NSFontAttributeName
                     
                                          value:[UIFont systemFontOfSize:12]
                     
                                          range:NSMakeRange(5, [AttributedStr length]-5)];
                    
                  
                    _label.attributedText = AttributedStr;}
                    break;
                case 1:
                    
                {NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",arr[i],self.product.feilv]];
                    
                    [AttributedStr addAttribute:NSFontAttributeName
                     
                                          value:[UIFont systemFontOfSize:12]
                     
                                          range:NSMakeRange(3, [AttributedStr length]-3)];
                    
                    
                    _label.attributedText = AttributedStr;}
                   
                    break;
                case 2:
                {NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",arr[i],self.product.qixianfanwei]];
                    
                    [AttributedStr addAttribute:NSFontAttributeName
                     
                                          value:[UIFont systemFontOfSize:12]
                     
                                          range:NSMakeRange(5, [AttributedStr length]-5)];
                    
                    
                    _label.attributedText = AttributedStr;
                    _label.numberOfLines=0;
                }
                    break;
                case 3:
                {NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",arr[i],self.product.zuikuaifangkuan]];
                    
                    [AttributedStr addAttribute:NSFontAttributeName
                     
                                          value:[UIFont systemFontOfSize:12]
                     
                                          range:NSMakeRange(5, [AttributedStr length]-5)];
                    
                    _label.attributedText = AttributedStr;}
                    break;
                default:
                    break;
            }
            [_headView addSubview:_label];
        }
    
    }
    return _headView;
    
}
-(UIView *)footView

{
    if (_footView==nil) {
        _footView                     = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 180)];
        
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(20, 50, WIDTH-40, 30)];
        but.clipsToBounds=YES;
        [but addTarget:self action:@selector(jumplanding) forControlEvents:UIControlEventTouchUpInside];
        but.layer.cornerRadius=5;
        but.backgroundColor=AppBackColor;
        [but setTitle:@"马上申请" forState:UIControlStateNormal];
        [_footView addSubview:but];
    }
    return _footView;
    
}
-(void)jumplanding
{
        WebVC *vc = [[WebVC alloc] init];
        [vc setNavTitle:self.product.post_title];
        [vc loadFromURLStr:self.product.link];
        vc.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:NO];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    NSString * labelStr = self.product.shenqingtiaojian;
  
   CGSize labelSize=[UtilTools getTextHeight:labelStr width:WIDTH font:[UIFont systemFontOfSize:14]];
    
    return labelSize.height+10;

}

#pragma mark 返回每组头标题名称
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
  
   
    return @"申请条件";
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle=   UITableViewCellSelectionStyleNone;
    }
    NSString * labelStr = self.product.shenqingtiaojian;

     CGSize labelSize =[UtilTools getTextHeight:labelStr width:WIDTH font:[UIFont systemFontOfSize:14]];
    

    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 20 , WIDTH-40, labelSize.height)];
    label.text=self.product.shenqingtiaojian;
    label.numberOfLines=0;
    label.font=[UIFont systemFontOfSize:15];
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:self.product.shenqingtiaojian];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:10];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [self.product.shenqingtiaojian length])];
    [label setAttributedText:attributedString1];
    [label sizeToFit];
//    cell.textLabel.text=self.product.shenqingtiaojian;
//    cell.textLabel.numberOfLines=0;
    [cell.contentView addSubview:label];
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
