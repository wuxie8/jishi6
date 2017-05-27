//
//  FastHandleCardViewController.m
//  haitian
//
//  Created by Admin on 2017/4/12.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "FastHandleCardViewController.h"
#import "WSPageView.h"
#import "WSIndexBanner.h"
#import "FastHandleCardCollectionViewCell.h"
#define pageHeight 160
#define kMargin 10


static NSString *const cellId = @"cellId";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";
@interface FastHandleCardViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,WSPageViewDelegate,WSPageViewDataSource>

@property (nonatomic, strong)UICollectionView *collectionView;
@end

@implementation FastHandleCardViewController

{
    NSArray *imageArray;
       NSArray *titleArray;
     NSArray *describeArray;
    
}
#ifdef __IPHONE_7_0
- (UIRectEdge)edgesForExtendedLayout
{
    return UIRectEdgeNone;
}
#endif
- (void)viewDidLoad {
    [super viewDidLoad];
    imageArray=@[@"pudongBank",@"everBrighBank",@"MinshengBank",@"zhaoshangBank",@"zhongxinbank",@"peaceBank",@"xingyeBank",@"zheshangBank",@"jiaotongbank"];
    titleArray=@[@"浦发银行",@"光大银行",@"民生银行",@"招商银行",@"中信银行",@"平安银行",@"兴业银行",@"浙商银行",@"交通银行"];
    describeArray=@[@"刷卡得3888元大奖",@"10元吃哈根达斯",@"最快3秒核发",@"玩卡必备 优惠多",@"1元带你看大片",@"周三享5折",@"最快当天下卡",@"5元看电影",@"日日刷 日日返"];
    self.title=@"快速办卡";
    self.view.backgroundColor=[UIColor whiteColor];
    WSPageView *pageView = [[WSPageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH,pageHeight)];
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
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(pageView.frame), WIDTH, HEIGHT-64-44-pageHeight) collectionViewLayout:[UICollectionViewFlowLayout new]];
    [_collectionView setBackgroundColor:kColorFromRGBHex(0xEBEBEB)];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    self.collectionView.alwaysBounceVertical = YES;
    // 注册cell、sectionHeader、sectionFooter
    [_collectionView registerClass:[FastHandleCardCollectionViewCell class] forCellWithReuseIdentifier:cellId];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
    
    [self.view addSubview:_collectionView];
    // Do any additional setup after loading the view.
}
#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(WSPageView *)flowView {
    return CGSizeMake(WIDTH, pageHeight);
}
#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(WSPageView *)flowView {
    return 1;
}

- (UIView *)flowView:(WSPageView *)flowView cellForPageAtIndex:(NSInteger)index{
    WSIndexBanner *bannerView = (WSIndexBanner *)[flowView dequeueReusableCell];
    if (!bannerView) {
        
        bannerView = [[WSIndexBanner alloc] initWithFrame:CGRectMake(0, 0,  WIDTH , pageHeight)];
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    [bannerView.mainImageView setImage:[UIImage imageNamed:@"FasthandleBanner"]];
    //    bannerView.mainImageView.image = self.imageArray[index];
    //    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:ImgURLArray[index]]];
    
    return bannerView;
}


#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FastHandleCardCollectionViewCell *cell = (FastHandleCardCollectionViewCell *)[_collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    [cell.bankimageView setImage:[UIImage imageNamed:imageArray[indexPath.row]]];
    [cell.titleLabel setText:titleArray[indexPath.row]];
    [cell.detailLabel setText:describeArray[indexPath.row]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{


}
// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView;
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
       headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[UICollectionReusableView alloc] init];
        }
        headerView.backgroundColor = [UIColor whiteColor];
    
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
        lab.text=@"快速办卡";
        [headerView addSubview:lab];
        
    }
        
   return headerView;
}
#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((WIDTH-kMargin*5)/3, (WIDTH-kMargin*5)/3);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return kMargin;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kMargin;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){WIDTH,44};
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



