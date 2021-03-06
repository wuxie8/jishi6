//
//  DaikuanViewController.m
//  jishiyu.com
//
//  Created by Admin on 2017/3/6.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "DaikuanViewController.h"
#import "YTUITextField.h"
#import "AFNetworking.h"
#import "JishiyuDetailsViewController.h"
#import "ProductModel.h"
#import "LoanClassification.h"
#import "LoanDetailsViewController.h"
#import "LoginViewController.h"
#define SectionHeight 90

// iPhone5/5c/5s/SE 4英寸 屏幕宽高：320*568点 屏幕模式：2x 分辨率：1136*640像素
#define iPhone5or5cor5sorSE ([UIScreen mainScreen].bounds.size.height == 568.0)

// iPhone6/6s/7 4.7英寸 屏幕宽高：375*667点 屏幕模式：2x 分辨率：1334*750像素
#define iPhone6or6sor7 ([UIScreen mainScreen].bounds.size.height == 667.0)

// iPhone6 Plus/6s Plus/7 Plus 5.5英寸 屏幕宽高：414*736点 屏幕模式：3x 分辨率：1920*1080像素
#define iPhone6Plusor6sPlusor7Plus ([UIScreen mainScreen].bounds.size.height == 736.0)
@interface DaikuanViewController ()<YTUITextFieldPickerViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)NSMutableArray*careerArray;
@property(strong, nonatomic)NSMutableArray*moneyArray;

@property(strong, nonatomic)NSMutableArray*monthArray;

@property(strong, nonatomic)NSMutableDictionary*careerDic;
@property(strong, nonatomic)NSMutableDictionary*moneyDic;

@property(strong, nonatomic)NSMutableDictionary*monthDic;


@property(strong, nonatomic)NSString*business_career;

@property(strong, nonatomic)NSString*business_money;

@property(strong, nonatomic)NSString*business_time;

@property(strong, nonatomic)NSMutableArray *productArray;
@end

@implementation DaikuanViewController
{
    UIButton *but1;
    UIButton *but2;
    UITableView *table;
    
}
#ifdef __IPHONE_7_0
- (UIRectEdge)edgesForExtendedLayout
{
    return UIRectEdgeNone;
}
#endif
- (void)viewDidLoad {
    
   
    [super viewDidLoad];
   
    [self loadData];
    
    self.title=@"小胖钱包";
    
     self.view.backgroundColor=[UIColor whiteColor];
       // Do any additional setup after loading the view.
}

-(void)loadData
{
    
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                       appcode,@"code",
                       @"1.0.0",@"version",
                       @"1",@"page",
                       nil];
   
    [[NetWorkManager sharedManager]postNoTipJSON:exchange parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic=(NSDictionary *)responseObject;
        if ([dic[@"status"]boolValue]) {
            if ([UtilTools isBlankString:dic[@"review"]]) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"review"];
            }else
            {
                [[NSUserDefaults standardUserDefaults] setBool:[dic[@"review"]boolValue] forKey:@"review"];
 
            }
                   }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];

  
    [[NetWorkManager sharedManager]postNoTipJSON:filter_para parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic=(NSDictionary *)responseObject;
        if ([dic[@"status"]boolValue]) {
            NSDictionary *data=dic[@"data"];
            NSArray *careerarr=data[@"career"];
             NSArray *moneyarr=data[@"money"];
            NSArray *timearr=data[@"time"];
            for (NSDictionary *careerdic in careerarr) {
                [self.careerArray addObject:careerdic[@"property_name"]];
                [self.careerDic setObject:careerdic[@"property_id"] forKey:careerdic[@"property_name"]];
            }
       
            for (NSDictionary *money in moneyarr) {
                [self.moneyArray addObject:money[@"property_name"]];
                 [self.moneyDic setObject:money[@"property_id"] forKey:money[@"property_name"]];
            }
            for (NSDictionary *timedic in timearr) {
                [self.monthArray addObject:timedic[@"property_name"]];
                 [self.monthDic setObject:timedic[@"property_id"] forKey:timedic[@"property_name"]];
            }
                       self.business_career=[self.careerDic objectForKey:self.careerArray[0]];
            self.business_money=[self.moneyDic objectForKey:self.moneyArray[0]];
            self.business_time=[self.moneyDic objectForKey:self.monthArray[0]];
            [self configData];
            [self businessFilter];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
      
        DLog(@"%@",error);

        
    }];

}

-(void)configData
{
   
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20 , 20, 80, 40)];
    [label setText:@"职业身份"];
    
    but1=[[UIButton alloc]initWithFrame:CGRectMake(120, 20, 120, 40)];
    [but1 setCenter:CGPointMake(WIDTH/5*2, 40)];
    but1.tag=1;
    but1.selected=YES;
    [but1 setTitleColor:AppBackColor forState:UIControlStateNormal];
    [but1 setTitle:self.careerArray[0] forState:UIControlStateNormal];
    [but1 addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
    but1.clipsToBounds=YES;
    
    but1.layer.cornerRadius=20;
    but2=[[UIButton alloc]init];
    but2 .frame =CGRectMake(240, 20, 120, 40);
    but2.selected=NO;
    [but2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [but2 setCenter:CGPointMake(WIDTH/5*4-20, 40)];
    [but2  setTitle:self.careerArray[1] forState:UIControlStateNormal];
    [but2  addTarget:self action:@selector(butClick: ) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:label];
    [self.view addSubview:but1];
    [self.view addSubview:but2];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(label.frame), 80, 40)];
    [lab setText:@"贷款金额"];
    [self.view addSubview:lab];
    
    YTUITextField *text=[[YTUITextField alloc]initDicPickerWithframe:CGRectMake(CGRectGetMaxX(lab.frame), CGRectGetMaxY(label.frame), WIDTH/2-CGRectGetMaxX(lab.frame), 40) data:self.moneyArray];
    text.font=[UIFont systemFontOfSize:14];

    __block YTUITextField *yt=text;
    [text setFinishBlock:^(NSString *str){
        yt.text=str;
        _business_money=[self.moneyDic objectForKey:[NSString stringWithFormat:@"%@",str]];
        [self businessFilter];
    }];
    text.text=self.moneyArray[0];
    text.textAlignment= iPhone5or5cor5sorSE? NSTextAlignmentLeft:NSTextAlignmentCenter;
    
    [self.view addSubview:text];
    
    UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(text.frame), CGRectGetMaxY(label.frame), 50, 40)];
    [lab2 setText:@"期限"];
    [self.view addSubview:lab2];
    
    
    YTUITextField *text2=[[YTUITextField alloc]initDicPickerWithframe:CGRectMake(CGRectGetMaxX(lab2.frame), CGRectGetMaxY(label.frame), WIDTH-CGRectGetMaxX(lab2.frame), 40) data:self.monthArray];

    text2.text=self.monthArray[0];
    text2.delegate=self;
    __block YTUITextField *yt2=text2;
    [text2 setFinishBlock:^(NSString *str){
        yt2.text=str;
        _business_time=[self.monthDic objectForKey:[NSString stringWithFormat:@"%@",str]];
         [self businessFilter];
    }];
    
    text2.textAlignment= iPhone5or5cor5sorSE? NSTextAlignmentLeft:NSTextAlignmentCenter;
    
   
    [self.view addSubview:text2];

    
  table=[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(text2.frame), WIDTH, HEIGHT-44-5-64-CGRectGetMaxY(text2.frame))];
    table.delegate=self;
    table.dataSource=self;
    table.separatorStyle=NO;
    [self.view addSubview:table];
}

-(void)businessFilter
{
    
    NSDictionary*dic1=@{@"page":@"1",
                        @"count":@"10"};
    NSDictionary *dic2=[NSDictionary dictionaryWithObjectsAndKeys:
                       appcode,@"code",
                       @"1.0.0",@"version",
                       dic1,@"PAGINATION",
                       self.business_career,@"career",
                      self.business_money,@"money",
                       self.business_time,@"time",

                       nil];

   NSArray *array=@[@"小胖钱包-社保贷",@"小胖钱包-公积金贷",@"小胖钱包-保单贷",@"小胖钱包-供房贷",@"小胖钱包-税金贷",@"小胖钱包-学信贷"];
    self.productArray=nil;
        AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer   serializer];
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVERE,filter]  parameters:dic2 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

        if ([dic[@"status"]boolValue]) {
            NSArray *arr=dic[@"list"];
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
                NSArray *tags=diction[@"tags"];
                NSMutableArray *tagsArray=[NSMutableArray array];
                for (NSDictionary *dic in tags) {
                    [tagsArray addObject:dic[@"tag_name"]];
                }
                pro.tagsArray=tagsArray;
                [self.productArray addObject:pro];
            }

            [table reloadData];
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"%@",error);

    }];
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}
-(void)butClick:(UIButton *)sender
{
   
    if ([sender.currentTitle isEqualToString:@"上班族"]) {
        [but1 setTitleColor:AppBackColor forState:UIControlStateNormal];
         [but2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    else
    {
        [but2 setTitleColor:AppBackColor forState:UIControlStateNormal];
        [but1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    _business_career=[self.careerDic objectForKey:[NSString stringWithFormat:@"%@",sender.currentTitle]];
    [self businessFilter];
}
#pragma mark UITableViewDelegate


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    return SectionHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
      if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kIsLogin"])
    {
        ProductModel *pro=[self.productArray objectAtIndex:indexPath.row];
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
                           pro.productID,@"id",
                           Context.currentUser.uid,@"uid",
                           appNo,@"channel",
                           
                           nil];
        
        [[NetWorkManager sharedManager]getJSON:@"http://app.jishiyu11.cn/index.php?g=app&m=product&a=hits" parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            
        }];
        
        LoanDetailsViewController *load=[[LoanDetailsViewController alloc]init];
        load.hidesBottomBarWhenPushed=YES;
        
        load.product=pro;
        [self.navigationController pushViewController:load animated:YES];
        
    }
    else
    {
        LoginViewController *login=[[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        
    }


    
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier                    = @"cell";
    
    LoanClassification *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell=[[LoanClassification alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle=   UITableViewCellSelectionStyleNone;
    }
    ProductModel *pro=[self.productArray objectAtIndex:indexPath.row];
    [cell setProduct:pro];
 
    return cell;
}

#pragma mark 懒加载
-(NSMutableArray *)monthArray
{
    if (!_monthArray) {
       _monthArray=[NSMutableArray array];
    }
    return _monthArray;
}
-(NSMutableArray *)moneyArray
{
    if (!_moneyArray) {
        _moneyArray=[NSMutableArray array];
    }
    return _moneyArray;
}
-(NSMutableArray *)careerArray
{
    if (!_careerArray) {
        _careerArray=[NSMutableArray array];
        
    }
    return _careerArray;
}
-(NSMutableDictionary *)careerDic
{
    if (!_careerDic) {
        _careerDic=[NSMutableDictionary dictionary];
    }
    return _careerDic;
}
-(NSMutableDictionary *)moneyDic
{
    if (!_moneyDic) {
        _moneyDic=[NSMutableDictionary dictionary];
    }
    return _moneyDic;
}
-(NSMutableDictionary *)monthDic
{
    if (!_monthDic) {
        _monthDic=[NSMutableDictionary dictionary];
    }
    return _moneyDic;
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

}



@end
