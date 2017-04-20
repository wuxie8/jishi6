//
//  ShareFriendsViewController.m
//  jishi
//
//  Created by Admin on 2017/4/20.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ShareFriendsViewController.h"
#import <UShareUI/UShareUI.h>
@interface ShareFriendsViewController ()

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
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        // 根据获取的platformType确定所选平台进行下一步操作
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
