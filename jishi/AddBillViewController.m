//
//  AddBillViewController.m
//  haitian
//
//  Created by Admin on 2017/5/15.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "AddBillViewController.h"
#import "NewRemindViewController.h"
#import "WebVC.h"
#define  APIKEY         @"9073253582026649"
#define  UID            @"u123456"
//#define  CALLBACKURL    @"http://192.168.117.239:8080/credit_callback.php"


#define  APISECRET @"wTCzqpY30jF9DHd8saT3E2tQU0q7aUhK"
#define  lm_url @"https://api.limuzhengxin.com"
// UID: 区分不同的用户
#define  UID            @"u123456"
#define  CALLBACKURL    @"http://www.baidu.com"
#define kMargin 10
static NSString *const cellId = @"cellId1";
static NSString *const headerId = @"headerId1";

@interface AddBillViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UICollectionView *LoadcollectionView;

@end

@implementation AddBillViewController
{NSArray *arr;
NSArray *imageArr;
    NSArray *titleArr;

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"添加我的账单";
//    NSArray *arr1=@[@"支付宝",@"京东白条",@"信用卡",@"公积金"];
//    NSArray *arr2=@[@"宜人贷",@"我来贷",@"现金贷",@"简单借款"];
    NSArray *arr3=@[@"房贷",@"车贷",@"水电费",@"燃气费",@"房租",@"自定义"];

    arr=@[arr3];
 imageArr=@[@[@"PayTreasure",@"JD",@"CreditCard",@"AccumulationFund"],@[@"PayTreasure",@"JD",@"CreditCard",@"AccumulationFund"],@[@"mortgage",@"CarLoans",@"ElectricityAndWater",@"CreditCard"
                                                                                                                                     ,@"Rent",@"Custom"]];
    

    imageArr=@[@[@"mortgage",@"CarLoans",@"ElectricityAndWater",@"CreditCard"
                                                                                                                                     ,@"Rent",@"Custom"]];
    titleArr=@[@"生活账单"];
    _LoadcollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64) collectionViewLayout:[UICollectionViewFlowLayout new]];
    [_LoadcollectionView setBackgroundColor:kColorFromRGBHex(0xEBEBEB)];
    _LoadcollectionView.delegate = self;
    _LoadcollectionView.dataSource = self;
    // 注册cell、sectionHeader、sectionFooter
    [_LoadcollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
    [_LoadcollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    self.LoadcollectionView.alwaysBounceVertical = YES;
    [self.view addSubview:_LoadcollectionView];
    // Do any additional setup after loading the view.
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return arr.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[arr objectAtIndex:section] count];
}
// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView;
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
       headerView = [collectionView  dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[UICollectionReusableView alloc] init];
        }
        headerView.backgroundColor = AppPageColor;
        
       
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 100, 20)];
        lab.text=titleArr[indexPath.section];
        [headerView addSubview:lab];
    }
    
    return headerView;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell =[_LoadcollectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundView=[[UIImageView alloc]initWithImage:
                         [UIImage imageNamed:[[imageArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]]];
//    [cell.imageView setImage:[UIImage imageNamed:[[arr4 objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]]];
//    [cell.titleLabel setText:[[arr2 objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
//    [cell.detailLabel setText:[[arr3 objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    return cell;
}
#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((WIDTH-kMargin*3)/2, HEIGHT/8);
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
    return (CGSize){WIDTH,40};
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            NewRemindViewController *newRemind=[[NewRemindViewController alloc]init];
            newRemind.remindTitle=[[arr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:newRemind animated:YES];
       
        }
            break;
        
        default:
            break;
    }
   

}
#pragma mark 自定义全局通用的 SDK

- (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure{
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    
    [request setHTTPMethod:@"POST"];
    
    NSMutableArray *array = [NSMutableArray array];
    if (params) {
        for (NSString *key in params) {
            NSString *value = [params objectForKey:key];
            [array addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
        }
        NSString *body = [array componentsJoinedByString:@"&"];
        request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    }else{
        request.HTTPBody = nil;
    }
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                if (failure) {
                    failure(error);
                }
            } else {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
                if (dict) {
                    if (success) {
                        success(dict);
                    }
                } else {
                    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    if (success) {
                        success(jsonStr);
                    }
                    
                }
            }
        });
        
    }];
    [dataTask resume];
    
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