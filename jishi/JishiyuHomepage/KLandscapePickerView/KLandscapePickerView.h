//
//  KLandscapePickerView.h
//  KLandscapePickerVIew
//
//  Created by 佟堃 on 14/12/19.
//  Copyright (c) 2014年 . All rights reserved.
//

#import <UIKit/UIKit.h>
@class KLandscapePickerView;
@protocol KLanscapePickerViewDataSource <NSObject>
@required;
- (NSInteger)numberOfRowInPickerView:(KLandscapePickerView *)pickerView;

- (NSInteger)numberOfColumnInPickerView:(KLandscapePickerView *)pickerView row:(NSInteger)row;

- (NSArray *)titleOfColumnInPickerView:(KLandscapePickerView *)pickerView row:(NSInteger)row;

@end

@protocol KLanscapePickerViewDelegate <NSObject>
@optional
- (void)pickerView:(KLandscapePickerView *)pickerView didSelectColumn:(NSInteger)column InRow:(NSInteger)row title:(NSString *)title;

@end

@interface KLandscapePickerView : UIView
{
    
}
@property (assign, nonatomic) id<KLanscapePickerViewDataSource>dataSource;
@property (assign, nonatomic) id<KLanscapePickerViewDelegate>delegate;

- (void)initLandscapePickerView;
- (void)selectColumn:(NSInteger)column inRow:(NSInteger)row;

@end
