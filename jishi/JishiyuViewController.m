//
//  JishiyuViewController.m
//  jishiyu.com
//
//  Created by Admin on 2017/3/6.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "JishiyuViewController.h"
#import "WSPageView.h"
#import "WSIndexBanner.h"
#import <QuartzCore/CALayer.h>
#import "WebVC.h"
#import "JishiyuDetailsViewController.h"
#import "JishiyuTableViewCell.h"
#import "LoanClasssificationVC.h"
#import "LoginViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "AmountClassificationViewController.h"
#import <UShareUI/UShareUI.h>
#import "LoanDetailsViewController.h"
#define  ScrollviewWeight 50
#define  ScrollviewHeight 180
#define SectionHeight 110
#define SectionHeadHeight 60
@interface JishiyuViewController ()<UITableViewDelegate,UITableViewDataSource,WSPageViewDelegate,WSPageViewDataSource>
@property(strong, nonatomic) UIScrollView *scrollview;
@property(strong, nonatomic)NSMutableArray *productArray;

@end

@implementation JishiyuViewController
{
   UITableView*tab;
    int page;
    int page_count;
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
 

    self.title=@"曹操贷款王";

    
     page=1;
    
    self.view.backgroundColor=[UIColor grayColor];
    
    [self getList];

  tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64-40)];
tab.delegate=self;
tab.dataSource=self;
    tab.backgroundColor=AppPageColor;
    tab.tableHeaderView=[self creatUI];
    
[self.view addSubview:tab];
// Do any additional setup after loading the view.
}

-(void)getList
{
     self.productArray=nil;
  

    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                       appcode,@"code",
                       @"1.0.0",@"version",
                      [NSString stringWithFormat:@"%d",page],@"page",
                       nil];
    NSArray *array=@[@"小僧-社保贷",@"小僧-公积金贷",@"小僧-保单贷",@"小僧-供房贷",@"小僧-税金贷",@"小僧-学信贷"];
[[NetWorkManager sharedManager]postNoTipJSON:exchange parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
    NSDictionary *dic=(NSDictionary *)responseObject;
    if ([dic[@"status"]boolValue]) {
      
        NSArray *arr=dic[@"list"];
        page_count=[dic[@"page_count"] intValue];
        ++page;
        if (page>page_count) {
            page=1;
        }
        if ([UtilTools isBlankString:dic[@"review"]]) {
             [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"review"];
        }else
        {
            [[NSUserDefaults standardUserDefaults] setBool:[dic[@"review"]boolValue] forKey:@"review"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"review"];

     
        }
        
                 if (![UtilTools isBlankArray:arr]) {
            for (int i=0; i<arr.count; i++) {
                NSDictionary *diction=arr[i];
                ProductModel *pro=[[ProductModel alloc]init];
                if ([[NSUserDefaults standardUserDefaults] boolForKey:@"review"]) {
                    pro.smeta=@"icon";
                    
                    int location=i%array.count;
                    pro.post_title=array[location];
                }
                else
                {
                    NSString *jsonString=diction[@"smeta"];
                    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
                    NSError *err;
                    NSDictionary *imagedic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                             options:NSJSONReadingMutableContainers
                                                                               error:&err];
                    pro.smeta=imagedic[@"thumb"];
                    pro.post_title=diction[@"post_title"];
                }
                pro.link=diction[@"link"];
                pro.edufanwei=diction[@"edufanwei"];
                pro.qixianfanwei=diction[@"qixianfanwei"];
                pro.shenqingtiaojian=diction[@"shenqingtiaojian"];
                pro.zuikuaifangkuan=diction[@"zuikuaifangkuan"];
              
                pro.post_hits=diction[@"post_hits"];
                pro.feilv=diction[@"feilv"];
                pro.productID=diction[@"id"];
                pro.post_excerpt=diction[@"post_excerpt"];

                pro.fv_unit=diction[@"fv_unit"];

                pro.qx_unit=diction[@"qx_unit"];

                [self.productArray addObject:pro];
                
            }

        }
        
        [tab reloadData];
        
    }
} failure:^(NSURLSessionDataTask *task, NSError *error) {
    

}];
  
    
}
- (UIView *)creatUI {
    
    WSPageView *pageView = [[WSPageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH,ScrollviewHeight)];
    pageView.delegate = self;
    pageView.dataSource = self;
    pageView.minimumPageAlpha = 0.4;   //非当前页的透明比例
    pageView.minimumPageScale = 0.85;  //非当前页的缩放比例
    pageView.orginPageCount = 1; //原始页数

    pageView.backgroundColor=[UIColor grayColor];
    //初始化pageControl
//    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageView.frame.size.height - 8 - 10, WIDTH, 8)];
//    pageControl.pageIndicatorTintColor = [UIColor grayColor];
//    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
//    pageView.pageControl = pageControl;
//    [pageView addSubview:pageControl];
//    [pageView stopTimer];
    [self.view addSubview:pageView];
    
    return pageView;
}

#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(WSPageView *)flowView {
    return CGSizeMake(WIDTH, ScrollviewHeight);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"review"]) {
  
        switch (subIndex) {
            case 0:
            {   WebVC *vc = [[WebVC alloc] init];
                [vc setNavTitle:@"融360"];
                [vc loadFromURLStr:@"http://m.rong360.com/express?from=sem21&utm_source=union1&utm_medium=jsy"];
                vc.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:vc animated:NO];
                
            }
                break;
            case 1:
            {WebVC *vc = [[WebVC alloc] init];
                [vc setNavTitle:@"现金巴士"];
                [vc loadFromURLStr:@"https://weixin.cashbus.com/#/events/promo/13201"];
                vc.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:vc animated:NO];
                
            }
                break;
            case 2:
            {
                WebVC *vc = [[WebVC alloc] init];
                [vc setNavTitle:@"简单借款"];
                [vc loadFromURLStr:@"https://activity.jiandanjiekuan.com/html/register_getNewUser.html?channelCode=98a33dcdc909492b9eb0b5cffb5d7d80"];
                vc.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:vc animated:NO];
            }
                break;
            default:
                break;
        }
    }
   
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(WSPageView *)flowView {
    return 1;
}



- (UIView *)flowView:(WSPageView *)flowView cellForPageAtIndex:(NSInteger)index{
    WSIndexBanner *bannerView = (WSIndexBanner *)[flowView dequeueReusableCell];
    if (!bannerView) {
       
        bannerView = [[WSIndexBanner alloc] initWithFrame:CGRectMake(0, 0,  WIDTH , ScrollviewHeight)];
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    [bannerView.mainImageView setImage:[UIImage imageNamed:@"WechatIMG2"]];
    //    bannerView.mainImageView.image = self.imageArray[index];
//    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:ImgURLArray[index]]];
    
    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(WSPageView *)flowView {
    
}


#pragma mark


//指定有多少个分区(Section)，默认为1

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;//返回标题数组中元素的个数来确定分区的个数
    
}

//指定每个分区中有多少行，默认为1

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
            
        case 0:
            
            return  1;//每个分区通常对应不同的数组，返回其元素个数来确定分区的行数
            
            break;
            
        case 1:
            
            return  [self.productArray count];
            
            break;
            
        default:
            
            return 0;  
            
            break;  
            
    }  
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320,  SectionHeadHeight)] ;
    
    [view setBackgroundColor:[UIColor whiteColor]];//改变标题的颜色，也可用图片
    view .backgroundColor=AppPageColor;
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2-100, 10, 200, 40)];
    [image setContentMode:UIViewContentModeScaleAspectFit];
    [image setClipsToBounds:YES];
    
    [image setImage:[UIImage imageNamed:@"PopularFastloan"]];
    [view addSubview:image];
    
    
    UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-60, 30, 50, 25)];
    [but setImage:[UIImage imageNamed:@"change"] forState:UIControlStateNormal];
   
    [but.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [but.imageView setClipsToBounds:YES];
    
    but.contentHorizontalAlignment= UIControlContentHorizontalAlignmentFill;
    
    but.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;

    [but addTarget:self action:@selector(getList) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:but];
    
    
    UIView *backgroundview=[[UIView alloc]initWithFrame:CGRectMake(0, 58, WIDTH, 2)];
    backgroundview.backgroundColor=kColorFromRGB(245, 245, 243);
    [view addSubview:backgroundview];
    
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return  SectionHeadHeight;
    }
    else
    {
        return 0;
    }
   
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.section==0 ) {
        return SectionHeight;
    }
    else
    return 80;
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if ([tab respondsToSelector:@selector(setSeparatorInset:)]) {
        [tab setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tab respondsToSelector:@selector(setLayoutMargins:)]) {
        [tab setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==1) {
        ProductModel *pro=(ProductModel *)[self.productArray objectAtIndex: indexPath.row];
        
        static NSString *HealthBroadcastCellID=@"HealthBroadcastCellID";
        JishiyuTableViewCell *jishiyu=[tableView dequeueReusableCellWithIdentifier:HealthBroadcastCellID];
        if (!jishiyu) {
            jishiyu=[[JishiyuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HealthBroadcastCellID];
            //取消选中状态
            jishiyu.selectionStyle = UITableViewCellSelectionStyleNone;
            jishiyu.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        }
        
        
        [jishiyu setModel:pro];
        return jishiyu;

    }
    else
    {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSArray *images=@[@"Fastloan",@"recommend",@"Creditcardreport"];
        for (int i=0; i<images.count; i++) {
            UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH/images.count*i, 10, WIDTH/images.count, SectionHeight-20)];
               [but setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];

            [but.imageView setContentMode:UIViewContentModeScaleAspectFit];
            [but.imageView setClipsToBounds:YES];
         
             but.contentHorizontalAlignment= UIControlContentHorizontalAlignmentFill;
            
            but.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
            [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
            but.tag=i;

            [cell.contentView addSubview:but];
        }
//        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, SectionHeight-10, WIDTH, 10)];
//        view.backgroundColor=kColorFromRGB(245, 245, 243);
//        [cell.contentView addSubview:view];
        return cell;
    }
}
-(void)butClick:(UIButton *)sender
{
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kIsLogin"]) {
        switch (sender.tag) {
            case 0:
            {
                AmountClassificationViewController *amount=[[AmountClassificationViewController alloc]init];
                amount.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:amount animated:YES];
            }
                break;
            case 1:
               
            { LoanClasssificationVC *loanClass=[[ LoanClasssificationVC alloc]init];
                    loanClass.hidesBottomBarWhenPushed=YES;
                    [self.navigationController pushViewController:loanClass animated:YES];
            }
                break;
            case 2:
            {
                if (![[NSUserDefaults standardUserDefaults] boolForKey:@"review"]) {
                    WebVC *vc = [[WebVC alloc] init];
                    [vc setNavTitle:@"信用卡查询"];
                    [vc loadFromURLStr:@"http://www.kuaicha.info/mobile/credit/credit.html"];
                    vc.hidesBottomBarWhenPushed=YES;
                    [self.navigationController pushViewController:vc animated:NO];
                }
                else
                {
                    [MessageAlertView showErrorMessage:@"服务器维护中"];
                }
                
            
              
            }
                break;
            default:
                break;
        }
    }
    else
    {
        LoginViewController *login=[[LoginViewController alloc]init];
        login.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:login animated:YES];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kIsLogin"])
    {
        ProductModel *product=(ProductModel *)self.productArray[indexPath.row];
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                           product.productID,@"id",
                           nil];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        [manager.requestSerializer setValue:@"text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        NSString *urlStr = [NSString stringWithFormat:@"%@&m=toutiao&a=redirect",SERVERE];
        [manager GET:urlStr parameters:dic progress:nil success:^(NSURLSessionDataTask *  task, id   responseObject) {
            NSDictionary *imagedic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:nil];
            DLog(@"%@",imagedic);
            
        } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
            DLog(@"%@",error);
            
        }];

//        JishiyuDetailsViewController *jishiyuDetail=[[JishiyuDetailsViewController alloc]init];
//        jishiyuDetail.product=product;
//        jishiyuDetail.hidesBottomBarWhenPushed=YES;
//        [self.navigationController pushViewController:jishiyuDetail animated:YES];
        LoanDetailsViewController *load=[[LoanDetailsViewController alloc]init];
        load.hidesBottomBarWhenPushed=YES;
        
        load.product=product;
        [self.navigationController pushViewController:load animated:YES];
        
    }
    else
    {
        LoginViewController *login=[[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        
    }
}

-(NSMutableArray *)productArray
{
    if (!_productArray) {
        _productArray=[NSMutableArray array];
        
    }
    return _productArray;
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
