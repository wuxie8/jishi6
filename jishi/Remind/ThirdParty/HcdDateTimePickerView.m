//
//  ____    ___   _        ___  _____  ____  ____  ____
// |    \  /   \ | T      /  _]/ ___/ /    T|    \|    \
// |  o  )Y     Y| |     /  [_(   \_ Y  o  ||  o  )  o  )
// |   _/ |  O  || l___ Y    _]\__  T|     ||   _/|   _/
// |  |   |     ||     T|   [_ /  \ ||  _  ||  |  |  |
// |  |   l     !|     ||     T\    ||  |  ||  |  |  |
// l__j    \___/ l_____jl_____j \___jl__j__jl__j  l__j
//
//
//	Powered by Polesapp.com
//
//
//  RBCustomDatePickerView.m
//
//
//  Created by fangmi-huangchengda on 15/10/21.
//
//


#define kDatePickerHeight 320
#define kOKBtnTag 101
#define kCancleBtnTag 100

#import "HcdDateTimePickerView.h"
#import "UIColor+HcdCustom.h"

@interface HcdDateTimePickerView()<UIGestureRecognizerDelegate>
{
    UIView                      *timeBroadcastView;//定时播放显示视图
    UIView                      *topView;
    MXSCycleScrollView          *yearScrollView;//年份滚动视图
    MXSCycleScrollView          *monthScrollView;//月份滚动视图
    MXSCycleScrollView          *dayScrollView;//日滚动视图
    MXSCycleScrollView          *hourScrollView;//时滚动视图
    MXSCycleScrollView          *minuteScrollView;//分滚动视图
    MXSCycleScrollView          *secondScrollView;//秒滚动视图
    UIButton                    *okBtn;//自定义picker上的确认按钮
    UIButton                    *cancleBtn;//
    NSString                    *dateTimeStr;
    BOOL                        clickBool;
}
@end

@implementation HcdDateTimePickerView

- (instancetype)initWithDefaultDatetime:(NSDate *)dateTime
{
    self = [super init];
    if (self) {
        [self setTimeBroadcastView];
    }
    return self;
}

- (instancetype)initWithDatePickerMode:(DatePickerMode)datePickerMode defaultDateTime:(NSDate *)dateTime
{
    self = [super init];
    if (self) {
        self.datePickerMode = datePickerMode;
        [self setTimeBroadcastView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark -custompicker
//设置自定义datepicker界面
- (void)setTimeBroadcastView
{
    
    [self setFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [self setBackgroundColor:[UIColor clearColor]];
    
    
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    dateTimeStr = [dateFormatter stringFromDate:now];
    
    topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
    topView.backgroundColor = [UIColor colorWithHexString:@"0xFFFFFF"];
    
    okBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-60, 0, 60, 30)];
    okBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [okBtn setBackgroundColor:[UIColor clearColor]];
    [okBtn setTitleColor:[UIColor colorWithHexString:@"0x000000"] forState:UIControlStateNormal];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(selectedButtons:) forControlEvents:UIControlEventTouchUpInside];
    okBtn.tag = kOKBtnTag;
    [self addSubview:okBtn];
    
    cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancleBtn setBackgroundColor:[UIColor clearColor]];
    [cancleBtn setTitleColor:[UIColor colorWithHexString:@"0x000000"] forState:UIControlStateNormal];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(selectedButtons:) forControlEvents:UIControlEventTouchUpInside];
    cancleBtn.tag = kCancleBtnTag;
    [self addSubview:cancleBtn];
    
    [topView addSubview:okBtn];
    [topView addSubview:cancleBtn];
    
    timeBroadcastView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT, WIDTH, 190.0)];
    timeBroadcastView.layer.cornerRadius = 0;//设置视图圆角
    timeBroadcastView.layer.masksToBounds = YES;
    CGColorRef cgColor = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0].CGColor;
    timeBroadcastView.layer.borderColor = cgColor;
    timeBroadcastView.layer.borderWidth = 0.0;
    timeBroadcastView.backgroundColor = [UIColor whiteColor];
    [self addSubview:timeBroadcastView];
    UIView *beforeSepLine = [[UIView alloc] initWithFrame:CGRectMake(0, 69, WIDTH, 1.5)];
    [beforeSepLine setBackgroundColor:[UIColor colorWithHexString:@"0xEDEDED"]];
    [timeBroadcastView addSubview:beforeSepLine];
    UIView *middleSepView = [[UIView alloc] initWithFrame:CGRectMake(0, 105, WIDTH, 38)];
    [middleSepView setBackgroundColor:[UIColor colorWithHexString:@"0xEDEDED"]];
    [timeBroadcastView addSubview:middleSepView];
    middleSepView.layer.borderWidth = 1.5;
    middleSepView.layer.borderColor = [UIColor colorWithHexString:@"0xEDEDED"].CGColor;
    UIView *bottomSepLine = [[UIView alloc] initWithFrame:CGRectMake(0, 180.5, WIDTH, 1.5)];
    [bottomSepLine setBackgroundColor:[UIColor colorWithHexString:@"0xEDEDED"]];
    [timeBroadcastView addSubview:bottomSepLine];
    
    if (self.datePickerMode == DatePickerDateMode) {
        [self setYearScrollView];
        [self setMonthScrollView];
        [self setDayScrollView];
    }
    else if (self.datePickerMode == DatePickerTimeMode) {
        [self setHourScrollView];
        [self setMinuteScrollView];
        [self setSecondScrollView];
    }
    else if (self.datePickerMode == DatePickerDatetimeMode) {
        [self setYearScrollView];
        [self setMonthScrollView];
        [self setDayScrollView];
        [self setHourScrollView];
        [self setMinuteScrollView];
//        [self setSecondScrollView];
    }
    
    [timeBroadcastView addSubview:topView];
//    [timeBroadcastView setFrame:CGRectMake(0, HEIGHT-kDatePickerHeight, WIDTH, kDatePickerHeight)];
}
//设置年月日时分的滚动视图
- (void)setYearScrollView
{
    if (self.datePickerMode == DatePickerDatetimeMode) {
        yearScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(0, 30, WIDTH*0.25, 190.0)];
    } else if (self.datePickerMode == DatePickerDateMode) {
        yearScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(0, 30, WIDTH*0.34, 190.0)];
    }
    
    self.curYear = [self setNowTimeShow:0];
    [yearScrollView setCurrentSelectPage:(self.curYear-2002)];
    yearScrollView.delegate = self;
    yearScrollView.datasource = self;
    [self setAfterScrollShowView:yearScrollView andCurrentPage:1];
    [timeBroadcastView addSubview:yearScrollView];
}
//设置年月日时分的滚动视图
- (void)setMonthScrollView
{
    if (self.datePickerMode == DatePickerDatetimeMode) {
        monthScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(WIDTH*0.25, 30, WIDTH*0.18, 190.0)];
    } else if (self.datePickerMode == DatePickerDateMode) {
        monthScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(WIDTH*0.34, 30, WIDTH*0.33, 190.0)];
    }
    self.curMonth = [self setNowTimeShow:1];
    [monthScrollView setCurrentSelectPage:(self.curMonth-3)];
    monthScrollView.delegate = self;
    monthScrollView.datasource = self;
    [self setAfterScrollShowView:monthScrollView andCurrentPage:1];
    [timeBroadcastView addSubview:monthScrollView];
}
//设置年月日时分的滚动视图
- (void)setDayScrollView
{
    if (self.datePickerMode == DatePickerDatetimeMode) {
        dayScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(WIDTH*(0.25+0.18), 30, WIDTH*0.18, 190.0)];
    } else if (self.datePickerMode == DatePickerDateMode) {
        dayScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(WIDTH*0.67, 30, WIDTH*0.33, 190.0)];
    }
    self.curDay = [self setNowTimeShow:2];
    [dayScrollView setCurrentSelectPage:(self.curDay-3)];
    dayScrollView.delegate = self;
    dayScrollView.datasource = self;
    [self setAfterScrollShowView:dayScrollView andCurrentPage:1];
    [timeBroadcastView addSubview:dayScrollView];
}
//设置年月日时分的滚动视图
- (void)setHourScrollView
{
    if (self.datePickerMode == DatePickerDatetimeMode) {
        hourScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(WIDTH*(0.25+0.18*2), 30, WIDTH*0.18, 190.0)];
    } else if (self.datePickerMode == DatePickerTimeMode) {
        hourScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(0, 30, WIDTH*0.34, 190.0)];
    }
    self.curHour = [self setNowTimeShow:3];
    [hourScrollView setCurrentSelectPage:(self.curHour-2)];
    hourScrollView.delegate = self;
    hourScrollView.datasource = self;
    [self setAfterScrollShowView:hourScrollView andCurrentPage:1];
    [timeBroadcastView addSubview:hourScrollView];
}
//设置年月日时分的滚动视图
- (void)setMinuteScrollView
{
    if (self.datePickerMode == DatePickerDatetimeMode) {
        minuteScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(WIDTH*(0.25+0.18*3), 30, WIDTH*0.18, 190.0)];
    } else if (self.datePickerMode == DatePickerTimeMode) {
        minuteScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(WIDTH*0.34, 30, WIDTH*0.33, 190.0)];
    }
    self.curMin = [self setNowTimeShow:4];
    [minuteScrollView setCurrentSelectPage:(self.curMin-2)];
    minuteScrollView.delegate = self;
    minuteScrollView.datasource = self;
    [self setAfterScrollShowView:minuteScrollView andCurrentPage:1];
    [timeBroadcastView addSubview:minuteScrollView];
}
//设置年月日时分的滚动视图
- (void)setSecondScrollView
{
    if (self.datePickerMode == DatePickerDatetimeMode) {
        secondScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(WIDTH*(0.25+0.18*3), 30, WIDTH*0.18, 190.0)];
    } else if (self.datePickerMode == DatePickerTimeMode) {
        secondScrollView = [[MXSCycleScrollView alloc] initWithFrame:CGRectMake(WIDTH*0.67, 30, WIDTH*0.33, 190.0)];
    }
    self.curSecond = [self setNowTimeShow:5];
    [secondScrollView setCurrentSelectPage:(self.curSecond-2)];
    secondScrollView.delegate = self;
    secondScrollView.datasource = self;
    [self setAfterScrollShowView:secondScrollView andCurrentPage:1];
    [timeBroadcastView addSubview:secondScrollView];
}
- (void)setAfterScrollShowView:(MXSCycleScrollView*)scrollview  andCurrentPage:(NSInteger)pageNumber
{
    UILabel *oneLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber];
    [oneLabel setFont:[UIFont systemFontOfSize:14]];
    [oneLabel setTextColor:[UIColor colorWithHexString:@"0xBABABA"]];
    UILabel *twoLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber+1];
    [twoLabel setFont:[UIFont systemFontOfSize:16]];
    [twoLabel setTextColor:[UIColor colorWithHexString:@"0x717171"]];
    
    UILabel *currentLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber+2];
    [currentLabel setFont:[UIFont systemFontOfSize:18]];
    [currentLabel setTextColor:[UIColor blackColor]];
    
    UILabel *threeLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber+3];
    [threeLabel setFont:[UIFont systemFontOfSize:16]];
    [threeLabel setTextColor:[UIColor colorWithHexString:@"0x717171"]];
    UILabel *fourLabel = [[(UILabel*)[[scrollview subviews] objectAtIndex:0] subviews] objectAtIndex:pageNumber+4];
    [fourLabel setFont:[UIFont systemFontOfSize:14]];
    [fourLabel setTextColor:[UIColor colorWithHexString:@"0xBABABA"]];
}
#pragma mark mxccyclescrollview delegate
#pragma mark mxccyclescrollview databasesource
- (NSInteger)numberOfPages:(MXSCycleScrollView*)scrollView
{
    if (scrollView == yearScrollView) {
        return 99;
    }
    else if (scrollView == monthScrollView)
    {
        return 12;
    }
    else if (scrollView == dayScrollView)
    {
        if (self.curMonth == 1 || self.curMonth == 3 || self.curMonth == 5 ||
            self.curMonth == 7 || self.curMonth == 8 || self.curMonth == 10 ||
            self.curMonth == 12) {
            return 31;
        } else if (self.curMonth == 2) {
            if ([self isLeapYear:self.curYear]) {
                return 29;
            } else {
                return 28;
            }
        } else {
            return 30;
        }
    }
    else if (scrollView == hourScrollView)
    {
        return 24;
    }
    else if (scrollView == minuteScrollView)
    {
        return 60;
    }
    return 60;
}

- (UIView *)pageAtIndex:(NSInteger)index andScrollView:(MXSCycleScrollView *)scrollView
{
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, scrollView.bounds.size.width, scrollView.bounds.size.height/5)];
    l.tag = index+1;
    if (scrollView == yearScrollView) {
        l.text = [NSString stringWithFormat:@"%d年",(int)(2000+index)];
    }
    else if (scrollView == monthScrollView)
    {
        l.text = [NSString stringWithFormat:@"%d月",(int)(1+index)];
    }
    else if (scrollView == dayScrollView)
    {
        l.text = [NSString stringWithFormat:@"%d日",(int)(1+index)];
    }
    else if (scrollView == hourScrollView)
    {
        if (index < 10) {
            l.text = [NSString stringWithFormat:@"0%ld时",(long)index];
        }
        else
            l.text = [NSString stringWithFormat:@"%ld时",(long)index];
    }
    else if (scrollView == minuteScrollView)
    {
        if (index < 10) {
            l.text = [NSString stringWithFormat:@"0%ld分",(long)index];
        }
        else
            l.text = [NSString stringWithFormat:@"%ld分",(long)index];
    }
    else
        if (index < 10) {
            l.text = [NSString stringWithFormat:@"0%ld秒",(long)index];
        }
        else
            l.text = [NSString stringWithFormat:@"%ld秒",(long)index];
    
    l.font = [UIFont systemFontOfSize:12];
    l.textAlignment = NSTextAlignmentCenter;
    l.backgroundColor = [UIColor clearColor];
    return l;
}
//设置现在时间
- (NSInteger)setNowTimeShow:(NSInteger)timeType
{
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dateString = [dateFormatter stringFromDate:now];
    switch (timeType) {
        case 0:
        {
            NSRange range = NSMakeRange(0, 4);
            NSString *yearString = [dateString substringWithRange:range];
            return yearString.integerValue;
        }
            break;
        case 1:
        {
            NSRange range = NSMakeRange(4, 2);
            NSString *yearString = [dateString substringWithRange:range];
            return yearString.integerValue;
        }
            break;
        case 2:
        {
            NSRange range = NSMakeRange(6, 2);
            NSString *yearString = [dateString substringWithRange:range];
            return yearString.integerValue;
        }
            break;
        case 3:
        {
            NSRange range = NSMakeRange(8, 2);
            NSString *yearString = [dateString substringWithRange:range];
            return yearString.integerValue;
        }
            break;
        case 4:
        {
            NSRange range = NSMakeRange(10, 2);
            NSString *yearString = [dateString substringWithRange:range];
            return yearString.integerValue;
        }
            break;
        case 5:
        {
            NSRange range = NSMakeRange(12, 2);
            NSString *yearString = [dateString substringWithRange:range];
            return yearString.integerValue;
        }
            break;
        default:
            break;
    }
    return 0;
}

//滚动时上下标签显示(当前时间和是否为有效时间)
- (void)scrollviewDidChangeNumber
{
    UILabel *yearLabel = [[(UILabel*)[[yearScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    UILabel *monthLabel = [[(UILabel*)[[monthScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    UILabel *dayLabel = [[(UILabel*)[[dayScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    UILabel *hourLabel = [[(UILabel*)[[hourScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    UILabel *minuteLabel = [[(UILabel*)[[minuteScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    UILabel *secondLabel = [[(UILabel*)[[secondScrollView subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    
    NSInteger month = monthLabel.tag;
    NSInteger year = yearLabel.tag + 1999;
    if (month != self.curMonth) {
        self.curMonth = month;
        [dayScrollView reloadData];
        [dayScrollView setCurrentSelectPage:(self.curDay-3)];
        [self setAfterScrollShowView:dayScrollView andCurrentPage:1];
    }
    if (year != self.curYear) {
        self.curYear = year;
        [dayScrollView reloadData];
        [dayScrollView setCurrentSelectPage:(self.curDay-3)];
        [self setAfterScrollShowView:dayScrollView andCurrentPage:1];
    }
    
    self.curMonth = monthLabel.tag;
    self.curDay = dayLabel.tag;
    self.curHour = hourLabel.tag - 1;
    self.curMin = minuteLabel.tag - 1;
    self.curSecond = secondLabel.tag - 1;
    
    dateTimeStr = [NSString stringWithFormat:@"%ld-%ld-%ld %02ld:%02ld",(long)self.curYear,(long)self.curMonth,(long)self.curDay,(long)self.curHour,(long)self.curMin];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *selectTimeString = [NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld",(long)self.curYear,(long)self.curMonth,(long)self.curDay,(long)self.curHour,(long)self.curMin];
    NSDate *selectDate = [dateFormatter dateFromString:selectTimeString];
    NSDate *nowDate = [NSDate date];
    NSString *nowString = [dateFormatter stringFromDate:nowDate];
    NSDate *nowStrDate = [dateFormatter dateFromString:nowString];
    if (NSOrderedAscending == [selectDate compare:nowStrDate]) {//选择的时间与当前系统时间做比较
        [okBtn setEnabled:YES];
        clickBool=NO;

    }
    else
    {
        clickBool=YES;

        [okBtn setEnabled:YES];
    }
    
}
//通过日期求星期
- (NSString*)fromDateToWeek:(NSString*)selectDate
{
    NSInteger yearInt = [selectDate substringWithRange:NSMakeRange(0, 4)].integerValue;
    NSInteger monthInt = [selectDate substringWithRange:NSMakeRange(4, 2)].integerValue;
    NSInteger dayInt = [selectDate substringWithRange:NSMakeRange(6, 2)].integerValue;
    int c = 20;//世纪
    NSInteger y = yearInt -1;//年
    NSInteger d = dayInt;
    NSInteger m = monthInt;
    int w =(y+(y/4)+(c/4)-2*c+(26*(m+1)/10)+d-1)%7;
    NSString *weekDay = @"";
    switch (w) {
        case 0:
            weekDay = @"周日";
            break;
        case 1:
            weekDay = @"周一";
            break;
        case 2:
            weekDay = @"周二";
            break;
        case 3:
            weekDay = @"周三";
            break;
        case 4:
            weekDay = @"周四";
            break;
        case 5:
            weekDay = @"周五";
            break;
        case 6:
            weekDay = @"周六";
            break;
        default:
            break;
    }
    return weekDay;
}

- (void)showHcdDateTimePicker
{
    typeof(self) __weak weak = self;
    [UIView animateWithDuration:0.3f delay:0 usingSpringWithDamping:0.8f initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        [weak setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f]];
        [timeBroadcastView setFrame:CGRectMake(0, HEIGHT - kDatePickerHeight, WIDTH, kDatePickerHeight)];

    } completion:^(BOOL finished) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:weak action:@selector(dismiss:)];
        tap.delegate = self;
        [weak addGestureRecognizer:tap];
        
        [timeBroadcastView setFrame:CGRectMake(0, HEIGHT - kDatePickerHeight, WIDTH, kDatePickerHeight)];
    }];
}

-(void)dismissBlock:(DatePickerCompleteAnimationBlock)block{
    
    
    typeof(self) __weak weak = self;
    CGFloat height = kDatePickerHeight;
    
    [UIView animateWithDuration:0.2f delay:0 usingSpringWithDamping:0.8f initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        [timeBroadcastView setFrame:CGRectMake(0, HEIGHT, WIDTH, height)];
        
    } completion:^(BOOL finished) {
        
        block(finished);
        [weak setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0f]];

        [self removeFromSuperview];
        
    }];
    
}

-(void)dismiss:(UITapGestureRecognizer *)tap{
    
    if( CGRectContainsPoint(self.frame, [tap locationInView:timeBroadcastView])) {
    } else{
        
        [self dismissBlock:^(BOOL Complete) {
            
        }];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (touch.view != self) {
        return NO;
    }
    
    return YES;
}

-(void)selectedButtons:(UIButton *)btns{
    
    typeof(self) __weak weak = self;
    [self dismissBlock:^(BOOL Complete) {
        if (btns.tag == kOKBtnTag) {
            if (clickBool) {
                weak.clickedOkBtn(dateTimeStr);

            }
            else{
                [MessageAlertView showErrorMessage:@"请设置有效时间"];
            }
        } else {
            
        }
    }];
    
    
}

-(BOOL)isLeapYear:(NSInteger)year {
    if ((year%4==0 && year %100 !=0) || year%400==0) {
        return YES;
    }else {
        return NO;
    }
    return NO;
}

@end
