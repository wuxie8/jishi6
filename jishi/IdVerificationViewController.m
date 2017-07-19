//
//  IdVerificationViewController.m
//  haitian
//
//  Created by Admin on 2017/4/24.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "IdVerificationViewController.h"
//#import "IDAuthViewController.h"
#import "AVCaptureViewController.h"
#import "IdOpposite ViewController.h"
//#import "FaceStreamDetectorViewController.h"
@interface IdVerificationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong, nonatomic)UIView *headView;

@property(strong, nonatomic)UIView *footView;
@end

@implementation IdVerificationViewController
{
    NSArray *arr;
    UIButton *but;
    NSArray *titleArray;
}
-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];

    
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(complete)];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        self.navigationItem.rightBarButtonItem = backItem;
   
    if (Context.idInfo.IDPositiveImage) {
        UIImageView *imageView1=[self.view viewWithTag:1000];
        imageView1.image=Context.idInfo.IDPositiveImage;
        imageView1.userInteractionEnabled=NO;
    }
    if (Context.idInfo.IDOppositeImage) {
        UIImageView *imageView2=[self.view viewWithTag:1001];
        imageView2.image=Context.idInfo.IDOppositeImage;
        imageView2.userInteractionEnabled=NO;
    }
    if (Context.idInfo.IDPositiveImage&&Context.idInfo.IDOppositeImage) {
        but.enabled=YES;
        but.backgroundColor=AppButtonbackgroundColor;
    }
    
}
-(void)getList
{
//    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
//                      Context.currentUser.uid,@"uid",
//                       nil];
//    [[NetWorkManager sharedManager]postJSON:[NSString stringWithFormat:@"%@&m=userdetail&a=idcard_list",UploadPath] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        if ([responseObject[@"code"]isEqualToString:@"0000"]) {
//            NSArray *idcardArr=[responseObject[@"data"]objectForKey:@"data"];
//            NSDictionary *diction=[idcardArr firstObject];
//            NSString *front_img=diction[@"front_img"];
//            NSString *back_img=diction[@"back_img"];
//            UIImageView *imageView=[self.view viewWithTag:1000];
//            NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",IMG_PATH,front_img]];
//            UIImage * result;
//            NSData * data = [NSData dataWithContentsOfURL:url];
//            
//            result = [UIImage imageWithData:data];
//            Context.idInfo.IDPositiveImage=result;
//            IDInfo *idInfo=[IDInfo new];
//            idInfo.IDPositiveImage=result;
//
//            [imageView setImage:result];
//            NSURL *url1=[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",IMG_PATH,back_img]];
//            UIImage * result1;
//            NSData * data1 = [NSData dataWithContentsOfURL:url1];
//            
//            result1 = [UIImage imageWithData:data1];
//            UIImageView *imageView1=[self.view viewWithTag:1001];
//
//            [imageView1 setImage:result1];
//            idInfo.IDOppositeImage=result1;
//            Context.idInfo=idInfo;
//            [NSKeyedArchiver archiveRootObject:Context.idInfo toFile:DOCUMENT_FOLDER(@"iDInfofile")];
//            Context.idInfo.IDOppositeImage=result1;
//            [NSKeyedArchiver archiveRootObject:Context.idInfo toFile:DOCUMENT_FOLDER(@"iDInfofile")];
//            if (Context.currentUser.idcard_auth) {
//                UIImageView *imageView2=[self.view viewWithTag:1002];
//                [imageView2 setImage:[UIImage imageNamed:@"IdentifySuccessful"]];
//            }
//
//
//
//         }
//        else
//        {}
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@",error);
//        
//        
//    }];



}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"身份认证";
//    arr=@[@"IdPositive",@"IdOpposite",@"FaceRecognition"];
    arr=@[@"IdPositive",@"IdOpposite"];

//   titleArray=@[@"第一步：请拍摄身份证正面照",@"第二步:请拍摄身份证反面照",@"第三步:请根据指示完成人脸识别"];
    titleArray=@[@"第一步：请拍摄身份证正面照",@"第二步:请拍摄身份证反面照"];

  
    UITableView *tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-44) style:UITableViewStyleGrouped ];
    tab.delegate=self;
    tab.dataSource=self;
//    tab.scrollEnabled=NO;
    tab.tableHeaderView=self.headView;
//    tab.tableFooterView=self.footView;
    [self.view addSubview:tab];
    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return titleArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
return [titleArray objectAtIndex:section];

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    UIImageView *cellImageView=[[UIImageView alloc]initWithFrame:CGRectMake(30, 20, WIDTH-30*2, 200)];
    cellImageView.tag=indexPath.section+1000;
    cellImageView.userInteractionEnabled=YES;
    UITapGestureRecognizer *cellImageTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellImageClick:)];
    [cellImageView addGestureRecognizer:cellImageTap];
    if (indexPath.section==0) {
        cellImageView.image=Context.idInfo.IDPositiveImage?Context.idInfo.IDPositiveImage:[UIImage imageNamed:arr[indexPath.section]];
    }
    if (indexPath.section==1) {
        cellImageView.image=Context.idInfo.IDOppositeImage?Context.idInfo.IDOppositeImage:[UIImage imageNamed:arr[indexPath.section]];
    }
//    else
//    {
//         cellImageView.image=[UIImage imageNamed:arr[indexPath.section]];
//    
//    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell.contentView addSubview:cellImageView];


    return cell;
}
-(void)cellImageClick:(UITapGestureRecognizer *)tap
{
    NSInteger row = tap.view.tag;
    switch (row) {
        case 1000:
        {
            AVCaptureViewController *AVCaptureVC = [[AVCaptureViewController alloc] init];
            AVCaptureVC.direction=@"Positive";
            [self.navigationController pushViewController:AVCaptureVC animated:YES];
        }

            break;
        case 1001:
        {
            [self.navigationController pushViewController:[IdOpposite_ViewController new] animated:YES];
        }
            
            break;
        case 1002:
        {
//            FaceStreamDetectorViewController *face=[[FaceStreamDetectorViewController alloc]init];
//            [self.navigationController pushViewController:face animated:YES];
        }
            
            break;
        default:
            break;
    }
}
-(void)complete
{


    if (!Context.idInfo.IDPositiveImage) {
        [MessageAlertView showErrorMessage:@"请上传身份证正面照"];
        return ;
    }
    if (!Context.idInfo.IDOppositeImage) {
        [MessageAlertView showErrorMessage:@"请上传身份证反面照"];

        return ;
    }
//    if (!Context.currentUser.idcard_auth) {
//        return;
//    }

    if (self.clickBlock) {
        self.clickBlock();
    }
    [MessageAlertView showSuccessMessage:@"成功"];
//    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
//                       Context.currentUser.uid,@"uid",
//                      nil];
//    
//    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
//    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
//    [manager POST:[NSString stringWithFormat:@"%@&m=userdetail&a=idcard_add",UploadPath]parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//            //根据当前系统时间生成图片名称
//        
//            NSDate *date = [NSDate date];
//            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//            [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
//            NSString *dateString = [formatter stringFromDate:date];
//            NSString *  _headfileName = [NSString stringWithFormat:@"%@.png",dateString];
//            NSData *     _headImageData = UIImageJPEGRepresentation(Context.idInfo.IDPositiveImage, 1);
//            [formData appendPartWithFileData:_headImageData name:@"photo1" fileName:_headfileName mimeType:@"image/jpg/png/jpeg"];
//        NSDate *date2 = [NSDate date];
//        NSDateFormatter *formatter2 = [[NSDateFormatter alloc]init];
//        [formatter2 setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
//        NSString *dateString2 = [formatter2 stringFromDate:date2];
//        NSString *  _headfileName2 = [NSString stringWithFormat:@"%@.png",dateString2];
//        NSData *     _headImageData2 = UIImageJPEGRepresentation(Context.idInfo.IDOppositeImage, 1);
//        [formData appendPartWithFileData:_headImageData2 name:@"photo2" fileName:_headfileName2 mimeType:@"image/jpg/png/jpeg"];
//        
//       
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSDictionary *resultDic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//
//        if ([resultDic[@"code"]isEqualToString:@"0000"]) {
//            [MessageAlertView showSuccessMessage:@"提交成功"];
//            [self.navigationController popViewControllerAnimated:YES];
//            if (self.clickBlock) {
//                self.clickBlock();
//            }
//            [self.navigationController popViewControllerAnimated:YES];
//
//        }
//        else
//        {
//            [MessageAlertView showErrorMessage:resultDic[@"msg"]];
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
//    

}
#pragma mark 懒加载
-(UIView *)headView
{
    if (_headView==nil) {
        _headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
        UILabel *headLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, WIDTH, 20 )];
        headLabel.text=@"*温馨提示： 请填写真实有效信息以便通过认证";
        headLabel.textAlignment=NSTextAlignmentCenter;
        [_headView addSubview:headLabel];
        
    }
    return _headView;
}
//-(UIView *)footView
//{
//    if (!_footView) {
//        _footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 80)];
//       but=[[UIButton alloc]initWithFrame:CGRectMake(10, 20, WIDTH-20, 40 )];
//        [but setTitle:@"完成" forState:UIControlStateNormal];
//        [but addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
//        but.backgroundColor=AppPageColor;
//        [_footView addSubview:but];
//    }
//    return _footView;
//}

#pragma mark 实现的方法
-(void)nextStep
{
   
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
