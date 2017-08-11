//
//  YTUITextField.h
//  小依休
//
//  Created by yant on 15/12/22.
//  Copyright © 2015年 AnSaiJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTUIToolbar.h"

//简讯的代理
@protocol YTUITextFieldPickerViewDelegate <NSObject>

@optional
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end

typedef void(^FinishBlock)(NSString *);

@interface YTUITextField : UITextField<UIPickerViewDataSource, UIPickerViewDelegate, YTUIToolbarDelegate,UITextFieldDelegate>

@property(nonatomic, strong)UIPickerView *inputPickerView;
@property(nonatomic, strong)UIDatePicker *inputDatePickerView;
@property(nonatomic, strong)UITableView  *tableView;
@property(nonatomic, strong)NSDate *date;

@property(nonatomic, strong)NSDate *minDate;
@property(nonatomic, strong)NSDate *maxDate;

@property(nonatomic, strong)NSArray *dataArr;
@property(nonatomic, strong)NSMutableDictionary *multipleChoiceDic;

@property(nonatomic, assign)id<YTUITextFieldPickerViewDelegate> outerDelegate;          //简讯用
@property(nonatomic, strong)YTUIToolbar *textFieldToolbar;

@property(nonatomic, strong)FinishBlock finishBlock;       //可多选的数组的block

@property(nonatomic, strong)NSDate *currentShowDate;

//status：0 当前日期之前  1 当前日期之后
- (id)initDatePickerWithframe:(CGRect)_frame haveLimit:(int)status;           //日期

- (id)initTimePickerWithframe:(CGRect)_frame;           //时间

- (id)initDicPickerWithframe:(CGRect)_frame data:(NSArray *)_data;      //简讯数组数据

- (id)initMutableSelectPickerWithframe:(CGRect)_frame data:(NSArray *)_data;        //可以多选的数组数据

@end
