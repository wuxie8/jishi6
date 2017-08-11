//
//  CertificationCenterViewController.m
//  jishi
//
//  Created by Admin on 2017/8/2.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "CertificationCenterViewController.h"
#import "CertificationCenterCollectionViewCell.h"
#import "JobInformationViewController.h"
#import "IncomeInformationViewController.h"
#import "IdentityInformationViewController.h"
#import "OperatorViewController.h"
#import "ContactVC.h"
#import "AuditViewController.h"
#define kMargin 10


static NSString *const cellId = @"cell";
static NSString *const headerId = @"header";
static NSString *const footerId = @"footer";
@interface CertificationCenterViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UICollectionView *collectionView;
@property(strong, nonatomic)UIView *footView;

@end

@implementation CertificationCenterViewController
{
    NSArray *titleArray;
    NSArray *imageArray;
    NSArray *imageBlueArray;
    NSMutableDictionary *statusDictionary;
}
- (void)viewDidLoad {
    [super viewDidLoad];
  self.title=@"信息认证";
    titleArray=@[@"身份信息",@"工作信息",@"收入信息",@"联系人",@"运营商认证"];
    statusDictionary=[NSMutableDictionary dictionary];
    imageArray=@[@"Identity_Information",@"Job_information",@"Income_Information",@"Contact_Information",@"Operator_Information"];
    imageBlueArray=@[@"Identity_InformationBlue",@"Job_informationBlue",@"Income_InformationBlue",@"Contact_InformationBlue",@"Operator_InformationBlue"];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getStatus:) name:@"CertificationStatus" object:nil];

    self.view.backgroundColor=[UIColor whiteColor];
    [self getList];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, WIDTH, HEIGHT-64-44) collectionViewLayout:[UICollectionViewFlowLayout new]];
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    self.collectionView.alwaysBounceVertical = NO;
    // 注册cell、sectionHeader、sectionFooter
    [_collectionView registerClass:[CertificationCenterCollectionViewCell class] forCellWithReuseIdentifier:cellId];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
    
    [self.view addSubview:_collectionView];
    [self.view addSubview:self.footView];
    // Do any additional setup after loading the view.
}
#pragma mark 实现方法
-(void)complete{
    NSArray *valueArray=[statusDictionary allValues];
    for (NSString *string in valueArray) {
        if (![string isEqualToString:@"1"]) {
            [MessageAlertView showErrorMessage:@"请先补全信息"];
            return;
        }
    }
    [self.navigationController pushViewController:[AuditViewController new] animated:YES];
    
}
-(void)getStatus:(NSNotification *)notification
{
    
    
    int imageIndex=[notification.object intValue];
    UIImageView *image=[self.view viewWithTag:100+imageIndex];
    image.image=[UIImage imageNamed:imageBlueArray[imageIndex]];
    switch (imageIndex) {
        case 0:
            [statusDictionary setValue:@"1" forKey:@"is_identity"];
            break;
        case 1:
            [statusDictionary setValue:@"1" forKey:@"is_work"];
            break;
        case 2:
            [statusDictionary setValue:@"1" forKey:@"is_income"];
            break;
        case 3:
            [statusDictionary setValue:@"1" forKey:@"is_linkman"];
            break;
        case 4:
            [statusDictionary setValue:@"1" forKey:@"is_mobile"];
            break;
        default:
            break;
    }
    
}

-(void)getList
{
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                        Context.currentUser.uid,@"uid",
                        nil];
    [[NetWorkManager sharedManager]postNoTipJSON:[NSString stringWithFormat:@"%@&m=Tempinfo&a=status_list",SERVERE] parameters:dic2 success:^(NSURLSessionDataTask *task, id responseObject) {
        DLog(@"%@",responseObject);

        if ([responseObject[@"code"]isEqualToString:@"0000"]) {
            NSDictionary *dictionary=[[responseObject objectForKey:@"data"]objectForKey:@"data"];
            if (![UtilTools isBlankDictionary:dictionary]) {
                statusDictionary=[NSMutableDictionary dictionaryWithDictionary:dictionary];
                [statusDictionary removeObjectForKey:@"id"];
                [statusDictionary removeObjectForKey:@"uid"];

                if ([dictionary[@"is_identity"] isEqualToString:@"1"]) {
                    UIImageView *image=[self.view viewWithTag:100];
                    image.image=[UIImage imageNamed:@"Identity_InformationBlue"];
                }
                if ([dictionary[@"is_work"] isEqualToString:@"1"]) {
                    UIImageView *image=[self.view viewWithTag:101];
                    image.image=[UIImage imageNamed:@"Job_informationBlue"];
                }
                if ([dictionary[@"is_income"] isEqualToString:@"1"]) {
                    UIImageView *image=[self.view viewWithTag:102];
                    image.image=[UIImage imageNamed:@"Income_InformationBlue"];
                }
                if ([dictionary[@"is_linkman"] isEqualToString:@"1"]) {
                    UIImageView *image=[self.view viewWithTag:103];
                    image.image=[UIImage imageNamed:@"Contact_InformationBlue"];
                }
                if ([dictionary[@"is_mobile"] isEqualToString:@"1"]) {
                    UIImageView *image=[self.view viewWithTag:104];
                    image.image=[UIImage imageNamed:@"Operator_InformationBlue"];
                }
            }
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
    
}

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return titleArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CertificationCenterCollectionViewCell *cell =[_collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.titleLabel.text=titleArray[indexPath.row];
    cell.titleLabel.tag=1000+indexPath.row;
    [cell.bankimageView setImage:[UIImage imageNamed:imageArray[indexPath.row]]];
    cell.bankimageView.tag=100+indexPath.row;
    //    [cell.bankimageView setImage:[UIImage imageNamed:imageArray[indexPath.row]]];
//    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMG_PATH,imageArray[indexPath.row]]];
//    UIImage * result;
//    NSData * data = [NSData dataWithContentsOfURL:url];
//    
//    result = [UIImage imageWithData:data];
//    
//    [cell.bankimageView setImage:result];
//    [cell.titleLabel setText:titleArray[indexPath.row]];
//    [cell.detailLabel setText:describeArray[indexPath.row]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[JobInformationViewController new] animated:YES];

            break;
        case 1:
            [self.navigationController pushViewController:[IdentityInformationViewController new] animated:YES];
            
            break;
        case 2:
            [self.navigationController pushViewController:[IncomeInformationViewController new] animated:YES];
            
            break;
        case 3:
            [self.navigationController pushViewController:[ContactVC new] animated:YES];
            
            break;
        case 4:
            [self.navigationController pushViewController:[OperatorViewController new] animated:YES];
            
            break;
        default:
            break;
    }
//    UILabel *label=[self.view viewWithTag:1000];
//    label.text=@"sn";
    

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
        
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-WIDTH/4, 20, WIDTH/2, 40)];
        lab.text=@"请完善以下资料";
        lab.textAlignment=NSTextAlignmentCenter;
        lab.font=[UIFont boldSystemFontOfSize:18];
        lab.textColor=AppgreenColor;
        [headerView addSubview:lab];
        UILabel *headLabel=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-WIDTH/4, CGRectGetMaxY(lab.frame), WIDTH/2, 40)];
        headLabel.text=@"首次借款需先完成认证哦";
        [headLabel setFont:[UIFont systemFontOfSize:14]];
        headLabel.textAlignment=NSTextAlignmentCenter;

        [headerView addSubview:headLabel];

    }
    else{
        headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerId forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[UICollectionReusableView alloc] init];
        }
        headerView.backgroundColor = [UIColor whiteColor];
        
    
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
    return (CGSize){WIDTH,100};
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return (CGSize){WIDTH,50};

}
-(UIView *)footView
{
    if (!_footView) {
        _footView=[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-64-50, WIDTH, 50)];
        UIButton *   but=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 50 )];
        [but setTitle:@"完成认证" forState:UIControlStateNormal];
        [but addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
//        but.layer.cornerRadius =  20;
//        //            //将多余的部分切掉
//        but.layer.masksToBounds = YES;
        but.backgroundColor=AppgreenColor;
        [_footView addSubview:but];
    }
    return _footView;
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
