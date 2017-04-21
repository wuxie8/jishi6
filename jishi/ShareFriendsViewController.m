//
//  ShareFriendsViewController.m
//  jishi
//
//  Created by Admin on 2017/4/20.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ShareFriendsViewController.h"
#import <UShareUI/UShareUI.h>
@interface ShareFriendsViewController ()<UMSocialShareMenuViewDelegate>

@end

@implementation ShareFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"邀请好友";
    self.view.backgroundColor=kColorFromRGBHex(0x3ea2e5);
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 500)];
    [image setImage:[UIImage imageNamed:@"backgroundImageView"]];
    [self.view addSubview:image];
    
    UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(image.frame)+40, WIDTH-20, 60)];
    [but setImage:[UIImage imageNamed:@"ImmediatelyInvited"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(ShareFriendsClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    
    // Do any additional setup after loading the view.
}
-(void)ShareFriendsClick
{
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ)]];
    [UMSocialUIManager setShareMenuViewDelegate:self];

    //加入copy的操作
    //@see http://dev.umeng.com/social/ios/进阶文档#6
    [UMSocialUIManager addCustomPlatformWithoutFilted:UMSocialPlatformType_UserDefine_Begin+2
                                     withPlatformIcon:[UIImage imageNamed:@"icon_circle"]
                                     withPlatformName:@"演示icon"];
    
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_None;
#ifdef UM_Swift
    [UMSocialSwiftInterface showShareMenuViewInWindowWithPlatformSelectionBlockWithSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary* userInfo) {
#else
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
#endif
            //在回调里面获得点击的
            if (platformType == UMSocialPlatformType_UserDefine_Begin+2) {
                NSLog(@"点击演示添加Icon后该做的操作");
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                });
            }
            else{
            }
        }];
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
