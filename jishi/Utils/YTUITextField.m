//
//  YTUITextField.m
//  小依休
//
//  Created by yant on 15/12/22.
//  Copyright © 2015年 AnSaiJie. All rights reserved.
//

#import "YTUITextField.h"
@interface YTUITextField ()<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>

@end

@implementation YTUITextField

-(void)setCurrentShowDate:(NSDate *)currentShowDate{

    _currentShowDate = currentShowDate;
    self.inputDatePickerView.date = _currentShowDate;
    
}

- (void)createDatePicker:(int)status
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSString*dateStartStr=[NSString stringWithFormat:@" 1900 1 1"];
    NSString*dateEndStr=[NSString stringWithFormat:@" 2100 1 1"];
    
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/zh_Hans_CN"]];
    
    _minDate =[dateFormat dateFromString:dateStartStr];
    _maxDate =[dateFormat dateFromString:dateEndStr];
    
    self.inputDatePickerView = [[UIDatePicker alloc] init];
    self.inputDatePickerView.datePickerMode = UIDatePickerModeDate;
//    self.inputDatePickerView.minimumDate = _minDate;
//    self.inputDatePickerView.maximumDate = _maxDate;
    NSDateComponents *dc = [[NSDateComponents alloc] init];
    dc.year = 1966;
//    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    if (status == 0) {
        self.inputDatePickerView.maximumDate = [NSDate date];//最大日期
    } else {
        self.inputDatePickerView.minimumDate = [NSDate date];//最小日期
    }
    
    self.inputDatePickerView.timeZone = [NSTimeZone systemTimeZone];
    [self.inputDatePickerView setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    self.inputView = self.inputDatePickerView;
    
    self.placeholder = @"请选择";
}

- (void)createTimePicker
{
    self.inputDatePickerView = [[UIDatePicker alloc] init];
    self.inputDatePickerView.datePickerMode = UIDatePickerModeCountDownTimer;
    self.inputDatePickerView.timeZone = [NSTimeZone systemTimeZone];
    [self.inputDatePickerView setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    self.inputView = self.inputDatePickerView;
    self.placeholder = @"请选择";
}

- (void)createDicPicker
{
    self.inputPickerView = [[UIPickerView alloc] init];
    self.inputPickerView.delegate = self;
    self.inputPickerView.dataSource = self;
    self.inputView = self.inputPickerView;
}

- (void)createMutableSelectPicker
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_BOUNDS.size.width, 216)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [[UIPickerView alloc] init].backgroundColor;
    self.inputView = _tableView;
    self.placeholder = @"请选择";
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textFieldToolbar = [[YTUIToolbar alloc]init];
        self.textFieldToolbar.delegate = self;
        self.inputAccessoryView = self.textFieldToolbar;
        self.textColor = [[UIColor alloc]initWithRed:142/255.0 green:142/255.0 blue:142/255.0 alpha:1.0];
        self.borderStyle = UITextBorderStyleNone;
        self.returnKeyType = UIReturnKeyDone;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.clearButtonMode = UITextFieldViewModeNever;
        self.textAlignment = NSTextAlignmentRight;
        self.backgroundColor= [UIColor whiteColor];
        
    }
    return self;
}

- (id)initDatePickerWithframe:(CGRect)_frame haveLimit:(int)status
{
    self  = [self initWithFrame:_frame];
    if (self) {
        [self createDatePicker:status];
    }
    return self;
}

- (id)initTimePickerWithframe:(CGRect)_frame
{
    self  = [self initWithFrame:_frame];
    if (self) {
        [self createTimePicker];
    }
    return self;
}

- (id)initDicPickerWithframe:(CGRect)_frame data:(NSArray *)_data
{
    self = [self initWithFrame:_frame];
    if (self) {
        self.dataArr = _data;
        
        [self createDicPicker];
    }
    return self;
}

- (id)initMutableSelectPickerWithframe:(CGRect)_frame data:(NSArray *)_data
{
    self = [self initWithFrame:_frame];
    if (self) {
        self.dataArr = _data;
        _multipleChoiceDic = [NSMutableDictionary dictionary];
        for (int i = 0; i<self.dataArr.count; i++) {
            [_multipleChoiceDic setObject:@"0" forKey:[NSString stringWithFormat:@"%d",i]];
        }
        [self createMutableSelectPicker];
    }
    return self;
}

#pragma mark -UIDatePickerView
- (void)setDateInfo:(UIDatePicker *)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone systemTimeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.date = sender.date;
    self.text = [dateFormatter stringFromDate:self.date];
}

- (void)setTimeInfo:(UIDatePicker *)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone systemTimeZone];
    [dateFormatter setDateFormat:@"HH:mm"];
    self.date = sender.date;
    self.text = [dateFormatter stringFromDate:self.date];
}
#pragma mark -UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataArr.count;
}
#pragma mark -UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.dataArr objectAtIndex:row];
}

#pragma mark -YTUIToolbarDelegate
- (void)hiddenKeyboardAndEnsure
{
    [self resignFirstResponder];
    if ([self.inputView isKindOfClass:[UIDatePicker class] ] ) {
        if (self.inputDatePickerView.datePickerMode == UIDatePickerModeDate) {
            [self setDateInfo:self.inputDatePickerView];
        }
        else if (self.inputDatePickerView.datePickerMode == UIDatePickerModeCountDownTimer)
            [self setTimeInfo:self.inputDatePickerView];
    }
    else if (self.inputPickerView && _outerDelegate && [_outerDelegate respondsToSelector:@selector(pickerView:didSelectRow:inComponent:)]) {
        [_outerDelegate pickerView:self.inputPickerView didSelectRow:[self.inputPickerView selectedRowInComponent:0] inComponent:0];
    }else
    {
     NSInteger row = [self.inputPickerView selectedRowInComponent:0];
      ;

        self.finishBlock(self.dataArr[row]);
    }
    
}
- (void)hiddenKeyboardAndCancel
{
    [self resignFirstResponder];
}

#pragma mark -UITableDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    //if (cell == nil) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    //}
    cell.backgroundColor = [UIColor clearColor];
    
    NSString *chooseFlag = [_multipleChoiceDic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    if ([chooseFlag isEqualToString:@"1"]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.textLabel.textColor=[UIColor orangeColor];
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textColor=[UIColor blackColor];
    }
    
//    id user = [self.dataArr objectAtIndex:indexPath.row];
//    NSString *titleStr =[UtilTools stringFrom:((User *)user)];
//    if ([titleStr isEqualToString:[UtilTools stringFrom:Context.currentUser]]) {
//        titleStr =[NSString stringWithFormat:@"%@(自己)",titleStr];
//    }
//    cell.textLabel.text = titleStr;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //改变数据源
    NSString *key = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    NSString *chooseFlag = [_multipleChoiceDic objectForKey:key];
    
    if ([chooseFlag isEqualToString:@"0"]) {
        [_multipleChoiceDic setObject:@"1" forKey:key];
    } else {
        [_multipleChoiceDic setObject:@"0" forKey:key];
    }
    
    //刷新tableView
    [tableView reloadData];
}

- (void)dealloc
{
    self.outerDelegate = nil;
    self.delegate = nil;
}

@end
