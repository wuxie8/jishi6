//
//  KLandscapePickerView.m
//  KLandscapePickerVIew
//
//  Created by 佟堃 on 14/12/19.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "KLandscapePickerView.h"
#import "KLandscapeScrollView.h"
#import "UIColor+Category.h"
#define VIEW_WIDTH              64
#define ROW_HEIGHT              44

#define MAX_FONT_SIZE           16.0f
#define MIN_FONT_SIZE           13.0f


@interface KLandscapePickerView ()<UIScrollViewDelegate, KLandscapeScrllViewDelegate>{
    NSMutableArray *_scrollArray;
    CGFloat _lastOffset_x;
    NSArray *_sourceArray;;
}

@end


@implementation KLandscapePickerView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _scrollArray = [[NSMutableArray alloc]init];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initLandscapePickerView{
    NSInteger rowNum = [self.dataSource numberOfRowInPickerView:self];
    for (int i = 0 ; i < rowNum; i ++) {
        [self addScrollViewInRow:i];
    }
}

- (void)addScrollViewInRow:(NSInteger)row{
    
    KLandscapeScrollView *scrollView = [[KLandscapeScrollView alloc]initWithFrame:CGRectMake(0, ROW_HEIGHT * row + 30 * (row + 1), self.frame.size.width, ROW_HEIGHT)];
    scrollView.rowNum = row;
    scrollView.delegate = self;
    [scrollView setSourceArray:[self.dataSource titleOfColumnInPickerView:self row:row]];
    scrollView.userInteractionEnabled = YES;
    [_scrollArray addObject:scrollView];
    [self addSubview:scrollView];
}




- (void)selectColumn:(NSInteger)column inRow:(NSInteger)row{
    KLandscapeScrollView *scrollView = _scrollArray[row];
    [scrollView setSelectedIndex:column animated:NO];
}


- (void)landScapeScrollView:(KLandscapeScrollView *)scrollView didSelectedIndex:(NSInteger)index title:(NSString *)title{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerView:didSelectColumn:InRow:title:)]) {
        [self.delegate pickerView:self didSelectColumn:index InRow:scrollView.rowNum title:title];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
