
//
//  OptionBarController.m
//  SuperMarket
//
//  Created by hanzhanbing on 16/7/15.
//  Copyright © 2016年 柯南. All rights reserved.
//

#import "OptionBarController.h"
#import "OptionsBarView.h"

@interface OptionBarController()<UIScrollViewDelegate,OptionsBarViewDelegate>
@property (nonatomic,strong)NSArray *titles;
@property (nonatomic,weak)OptionsBarView *lhOptionsBarView;
@property (nonatomic,weak)UIScrollView *mainView;
@end

@implementation OptionBarController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self createView];
    [self createTitles:self.controllersArr];
}

-(void)createTitles:(NSArray *)subViewControllers{
    NSMutableArray *temp=[NSMutableArray array];
    for (UIViewController *controller in subViewControllers) {
        NSString *title=controller.title;
        [temp addObject:title];
    }
    self.titles=temp;
    self.lhOptionsBarView.titles=_titles;
}

-(void)createView{
    _linecolor = _linecolor ? _linecolor : [UIColor blackColor];
    OptionsBarView *optionBarView=[[OptionsBarView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
    optionBarView.backgroundColor = [UIColor whiteColor];
    self.lhOptionsBarView=optionBarView;
    [self.view addSubview:optionBarView];
    optionBarView.delegate=self;
    optionBarView.showSeprateLine=_showLineView;
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"review"]) {
//        optionBarView.bottomLineColor=AppgreenColor;
//
//    }
//    else{
        optionBarView.bottomLineColor=AppBackColor;

//    }
    UIScrollView *scrollerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lhOptionsBarView.frame), WIDTH,HEIGHT-44)];
    self.mainView=scrollerView;
    [self.view addSubview:scrollerView];
    _mainView.delegate=self;
    _mainView.pagingEnabled=YES;
    _mainView.showsHorizontalScrollIndicator = NO;
    _mainView.contentSize = CGSizeMake(WIDTH * _controllersArr.count, 0);
    _mainView.bounces=NO;
    [_controllersArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIViewController *viewController = (UIViewController *)_controllersArr[idx];
        viewController.view.frame = CGRectMake(idx * WIDTH, 0, WIDTH, _mainView.bounds.size.height);
        [_mainView addSubview:viewController.view];
    }];
}

- (instancetype)initWithSubViewControllers:(NSArray *)subViewControllers andShow:(BOOL)show
{
    self = [super init];
    if (self)
    {
        _controllersArr = subViewControllers;
        _showLineView=show;
    }
    return self;
}

- (void)addParentController:(UIViewController *)viewController
{
    // Close UIScrollView characteristic on IOS7 and later
    if ([viewController respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [viewController addChildViewController:self];
    [viewController.view addSubview:self.view];
}

/**
 *  设置是否带有分割线
 *
 *  @param showLineView <#showLineView description#>
 */
-(void)setShowLineView:(BOOL)showLineView{
    if(_showLineView!=showLineView){
        _showLineView=showLineView;
    }
}

- (instancetype)initWithSubViewControllers:(NSArray *)controllersArr andParentViewController:(UIViewController *)viewController andshowSeperateLine:(BOOL)showSeperateLine{
    self=[self initWithSubViewControllers:controllersArr andShow:showSeperateLine];
    [self addParentController:viewController];
    return self;
}

#pragma  mark -UICrollerViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger currentIndex=self.mainView.contentOffset.x/WIDTH;
    self.lhOptionsBarView.currentIndex=currentIndex;
    if (self.clickBlock !=nil) {
        self.clickBlock(currentIndex);
    }
    [self.view endEditing:YES];
}

#pragma mark -LHOptionsBarViewDelegate
-(void)lhOptionBarView:(OptionsBarView *)optionBarView didSelectedItemWithCurrentIndex:(NSInteger)currentIndex{
    [self.mainView setContentOffset:CGPointMake(currentIndex*WIDTH, 0) animated:NO];
    if (self.clickBlock !=nil) {
        self.clickBlock(currentIndex);
    }
}

@end
