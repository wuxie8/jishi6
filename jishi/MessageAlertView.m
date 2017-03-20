//
//  MessageAlertView.m
//  xiaoyixiu
//
//  Created by 柯南 on 16/6/12.
//  Copyright © 2016年 柯南. All rights reserved.
//

#define SCENTER CGPointMake(WIDTH*0.5, HEIGHT*0.5)
#define SRECT CGRectMake(0, 0, WIDTH, HEIGHT)
#define RectWidth  120

#import "MessageAlertView.h"
static MessageAlertView *alertView;
@implementation MessageAlertView

{
    UIView *contentVw;//背景view
    UILabel *contentLab;//文字lable
    UIImageView *contentImage;//中心的图片
    UIActivityIndicatorView *indicatorVw;//中心的风火轮
    UIWindow *window;
    BOOL showIndicator;
    NSString *mymessage;
    NSInteger timeFlag;
    BOOL isnetWork;
    BOOL nohide;
    CADisplayLink *linkP;
    CADisplayLink *linkP2;
    NSInteger chekcFlag;
    CGFloat tttt;
    UIVisualEffectView *v;
    BOOL isAnimating;
}

-(void)checkHidenLink{
    chekcFlag=200;
    linkP2=[CADisplayLink displayLinkWithTarget:self selector:@selector(hudIshiden)];
    linkP2.preferredFramesPerSecond=6;
//    linkP2.frameInterval=6;
    [linkP2 addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}
#pragma mark - 修改显示和隐藏动画

-(void)hideHudAni{
    contentVw.hidden = YES;
}

-(void)showHudAni{
    contentVw.hidden = NO;
    contentVw.transform = CGAffineTransformMakeScale(0.3, 0.3);
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:7 initialSpringVelocity:4 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         contentVw.transform  = CGAffineTransformMake(1, 0, 0, 1, 0, 0);;
                         
                     } completion:^(BOOL finished) {
                         
                     }];
}

-(void)hudIshiden{
    if (contentVw.hidden==NO) {
        chekcFlag--;
        if (chekcFlag<1) {
            [self hideHudAni];
            linkP2.paused=YES;
            chekcFlag=200;
        }
    }else chekcFlag=200;
}
-(void)initLinkWithTime:(CGFloat)tmm{
    linkP2.paused=NO;
    if (showIndicator==NO) {
        timeFlag=15;
        
    }
    linkP.paused = NO;
    timeFlag=tmm;
    if (linkP) {
        
    }else{
        linkP=[CADisplayLink displayLinkWithTarget:self selector:@selector(jiancount)];
        linkP.preferredFramesPerSecond=6;
        [linkP addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}

-(void)jiancount{
    timeFlag--;
    if (timeFlag==0) {
        timeFlag=tttt;
        nohide=NO;
        linkP.paused=YES;
        [self hideHudAni];
    }
}

+(void)dismissHud{
    [[self shareHud] dismissHud];
}

+(void)showLoading:(NSString *)message{
    [[self shareHud] createHud:message showInd:YES image:nil];
}

+(void)showSuccessMessage:(NSString *)messgae{
    [[self shareHud] initLinkWithTime:15];
    [[self shareHud] createHud:messgae showInd:NO image:SUCCESSIMAGE];
}

-(void)createHUDWhenHide:(NSString *)messgae{
    do {
        
    } while (isAnimating == YES);
    [self initLinkWithTime:15];
    [self createHud:messgae showInd:NO image:SUCCESSIMAGE];
}

+(void)showErrorMessage:(NSString *)messgae{
    [[self shareHud] initLinkWithTime:15];
    [[self shareHud] createHud:messgae showInd:NO image:ERRORIMAGE];
}

+(MessageAlertView *)shareHud{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        alertView = [[self alloc] init];
    });
    
    return alertView;
}

-(instancetype)init{
    self=[super init];
    if (self) {
        [self checkHidenLink];
        [self initView];
        
        contentVw.autoresizesSubviews = YES;
    }
    return self;
}

-(void)dismissHud{
    
    [self initLinkWithTime:1];
}

-(void)hidewithRime{
    [self initLinkWithTime:10];
}

-(void)initView{
    
    //背景
    UIBlurEffect *blu=[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    contentVw= [[UIVisualEffectView alloc]initWithEffect:blu];
    contentVw.layer.cornerRadius=10;
    contentVw.frame=CGRectMake(0, 0, RectWidth, RectWidth);
    contentVw.clipsToBounds=YES;
    window=[UIApplication sharedApplication].keyWindow;
    [window addSubview:contentVw];
    contentVw.alpha=1.0;
    
    //lable
    contentLab=[[UILabel alloc]initWithFrame:CGRectMake(5, 70, RectWidth-10, 40)];
    contentLab.textAlignment=NSTextAlignmentCenter;
    contentLab.textColor=[UIColor whiteColor];
    contentLab.numberOfLines=0;
    contentLab.font=[UIFont systemFontOfSize:15];
    [contentVw addSubview:contentLab];
    
    //等待视图
    indicatorVw = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicatorVw.hidesWhenStopped = YES;
    indicatorVw.tintColor =[UIColor redColor];
    indicatorVw.center=CGPointMake(contentVw.bounds.size.width*0.5, contentVw.bounds.size.height*0.5-15) ;
    [contentVw addSubview:indicatorVw];
    
    //指示图片
    contentImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 28, 28)];
    contentImage.center=CGPointMake(contentVw.bounds.size.width*0.5, contentVw.bounds.size.height*0.5-15) ;
    [contentVw addSubview:contentImage];
}

#pragma mark - 创建hud 设置frame
-(void)createHud:(NSString *)messgae showInd:(BOOL)showInd image:(UIImage *)imagee{
    
    window=[UIApplication sharedApplication].keyWindow;
    [window addSubview:contentVw];
    
    if (showInd==YES) {
        showIndicator=YES;
    }else showIndicator=NO;
    
    contentVw.frame=CGRectMake(0, 0, RectWidth, RectWidth);
    
    if ([messgae isEqualToString:@"令牌过期"]) {
        messgae = @"请登录";
    }
    if ([messgae isEqualToString:@""] || messgae==nil) {
        messgae=@"加载中...";
    }
    contentLab.text=messgae;
    
    CGSize ss=[contentLab.text sizeWithAttributes:@{NSFontAttributeName:contentLab.font}];
    if (ss.width<RectWidth-20) {
        contentVw.frame=CGRectMake(0, 0, RectWidth, RectWidth);
    }
    if (ss.width>RectWidth-20) {
        contentLab.frame=CGRectMake(0, 0, ss.width, 40);
        contentVw.frame=CGRectMake(0, 0, ss.width+20, RectWidth);
    }
    
    if (ss.width>=200) {
        contentLab.numberOfLines=ss.width/200+1;
        contentLab.frame=CGRectMake(10, 0, 180, 20*contentLab.numberOfLines);
        contentVw.frame=CGRectMake(0, 0, 200, RectWidth+20*(contentLab.numberOfLines-2));
        timeFlag=20;
    }
    
    //风火轮
    if (showInd) {
        isnetWork=YES;//网络请求调用的,根据此标志,延时隐藏;
        indicatorVw.hidden=NO;
        [indicatorVw startAnimating];
    }else indicatorVw.hidden=YES;
    
    //指示图片
    contentImage.hidden=YES;
    if (imagee!=nil) {
        contentImage.hidden=NO;
    }
    contentImage.image=imagee;
    
    //整体位置调整
    contentVw.center=SCENTER;
    contentLab.center=CGPointMake(contentVw.bounds.size.width*0.5, contentVw.bounds.size.height-contentLab.bounds.size.height/2.0-7);
    contentImage.center=CGPointMake(contentVw.bounds.size.width*0.5, contentVw.bounds.size.height*0.5-15);
    indicatorVw.center=CGPointMake(contentVw.bounds.size.width*0.5, contentVw.bounds.size.height*0.5-15);
    
    [self showHudAni];
}

@end
