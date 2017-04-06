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
 
 

    self.title=@"手机贷上钱";

    
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
                       @"shoujidaikuanjieqiankuai",@"code",
                       @"1.0.0",@"version",
                      [NSString stringWithFormat:@"%d",page],@"page",
                       nil];
   
[[NetWorkManager sharedManager]postNoTipJSON:exchange parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
    NSDictionary *dic=(NSDictionary *)responseObject;
    if ([dic[@"status"]boolValue]) {
      
        NSArray *arr=dic[@"list"];
        page_count=[dic[@"page_count"] intValue];
        ++page;
        if (page>page_count) {
            page=1;
        }
        
        for (int i=0; i<arr.count; i++) {
            NSDictionary *diction=arr[i];
            ProductModel *pro=[[ProductModel alloc]init];
            
            NSString *jsonString=diction[@"smeta"];
            NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *imagedic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:&err];
            
            pro.smeta=imagedic[@"thumb"];
            pro.link=diction[@"link"];
            pro.edufanwei=diction[@"edufanwei"];
            pro.qixianfanwei=diction[@"qixianfanwei"];
            pro.shenqingtiaojian=diction[@"shenqingtiaojian"];
            pro.zuikuaifangkuan=diction[@"zuikuaifangkuan"];
                        pro.post_title=diction[@"post_title"];
//            int location=i%array.count;
//            pro.post_title=array[location];
            pro.post_hits=diction[@"post_hits"];
            pro.feilv=diction[@"feilv"];
            [self.productArray addObject:pro];

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
    pageView.orginPageCount = 3; //原始页数

    pageView.backgroundColor=[UIColor grayColor];
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageView.frame.size.height - 8 - 10, WIDTH, 8)];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageView.pageControl = pageControl;
    [pageView addSubview:pageControl];
    [pageView stopTimer];
    [self.view addSubview:pageView];
    
    return pageView;
}

#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(WSPageView *)flowView {
    return CGSizeMake(WIDTH, ScrollviewHeight);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
   
//    WebVC *vc = [[WebVC alloc] init];
//    [vc setNavTitle:@"及时雨"];
//    [vc loadFromURLStr:@"http://api.51ygdai.com/act/light-loan?source_tag=jsy"];
//    vc.hidesBottomBarWhenPushed=YES;
//    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(WSPageView *)flowView {
    return 3;
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



-(UIScrollView *)scrollview
{
if(_scrollview==nil)
{
_scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 200+ScrollviewWeight)];
    CGFloat imageW = _scrollview.frame.size.width;
    //    CGFloat imageW = 300;
    //    图片高
    CGFloat imageH = _scrollview.frame.size.height;
    //    图片的Y
    CGFloat imageY = 0;
    //    图片中数
    NSInteger totalCount = 5;
    //   1.添加5张图片
    for (int i = 0; i < totalCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        //        图片X
        CGFloat imageX = i * imageW;
        //        设置frame
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        //        设置图片
        NSString *name = [NSString stringWithFormat:@"singInHome"];
        imageView.image = [UIImage imageNamed:name];
        //        隐藏指示条
        _scrollview.showsHorizontalScrollIndicator = NO;
        
        [_scrollview addSubview:imageView];
    }
    
    
    CGFloat contentW = totalCount *imageW;
    //不允许在垂直方向上进行滚动
    _scrollview.contentSize = CGSizeMake(contentW, 0);
    
    //    3.设置分页
    _scrollview.pagingEnabled = YES;
    
    //    4.监听scrollview的滚动
    _scrollview.delegate = self;

}
    return _scrollview;
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
    
    
//    UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-60, 30, 50, 25)];
//    [but setImage:[UIImage imageNamed:@"change"] forState:UIControlStateNormal];
//   
//    [but.imageView setContentMode:UIViewContentModeScaleAspectFit];
//    [but.imageView setClipsToBounds:YES];
//    
//    but.contentHorizontalAlignment= UIControlContentHorizontalAlignmentFill;
//    
//    but.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
//
////    [but addTarget:self action:@selector(getList) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:but];
//    
    
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
    switch (sender.tag) {
        case 0:
        {
            AmountClassificationViewController *amount=[[AmountClassificationViewController alloc]init];
            [self.navigationController pushViewController:amount animated:YES];
        }
            break;
        case 1:
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kIsLogin"])
            {
                LoanClasssificationVC *loanClass=[[ LoanClasssificationVC alloc]init];
                [self.navigationController pushViewController:loanClass animated:YES];
                
            }
            else
            {
                LoginViewController *login=[[LoginViewController alloc]init];
                [self.navigationController pushViewController:login animated:YES];
                
            }

            break;
        case 2:
        {
            
            WebVC *vc = [[WebVC alloc] init];
                [vc setNavTitle:@"信用卡查询"];
                [vc loadFromURLStr:@"http://www.kuaicha.info/mobile/credit/credit.html"];
                vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:NO];
        }
            break;
        default:
            break;
    }

    
  
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kIsLogin"])
    {
        ProductModel *product=(ProductModel *)self.productArray[indexPath.row];
        
        JishiyuDetailsViewController *jishiyuDetail=[[JishiyuDetailsViewController alloc]init];
        jishiyuDetail.product=product;
        jishiyuDetail.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:jishiyuDetail animated:YES];

        
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
