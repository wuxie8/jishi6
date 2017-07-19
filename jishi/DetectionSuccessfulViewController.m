//
//  DetectionSuccessfulViewController.m
//  haitian
//
//  Created by Admin on 2017/4/26.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "DetectionSuccessfulViewController.h"

@interface DetectionSuccessfulViewController ()

@end

@implementation DetectionSuccessfulViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title=@"人脸检测";
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 390)];
    imageView.image=[UIImage imageNamed:@"FaceDetectionSuccess"];
    [self.view addSubview:imageView];
    
    UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView.frame)+10, WIDTH-20, 50)];
    but.clipsToBounds=YES;
    [but setImage:[UIImage imageNamed:@"NextButton"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    but.layer.cornerRadius=20;
    
    [self.view addSubview:but];
    // Do any additional setup after loading the view.
}
-(void)nextClick
{
    UIViewController *viewCtl = self.navigationController.viewControllers[self.navigationController.viewControllers.count-4];
//    Context.idInfo.is_Face=@"1";
//    [NSKeyedArchiver archiveRootObject:Context.idInfo toFile:DOCUMENT_FOLDER(@"iDInfofile")];

    [self.navigationController popToViewController:viewCtl animated:NO];
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
