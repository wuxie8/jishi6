//
//  KLandscapeScrollView.m
//  KLandscapePickerVIew
//
//  Created by 佟堃 on 14/12/19.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "KLandscapeScrollView.h"
#import "UIColor+Category.h"

#define VIEW_WIDTH              ((self.frame.size.width) / 3)

@interface KLandscapeScrollView ()<UIScrollViewDelegate, UIGestureRecognizerDelegate>{
    NSMutableArray *_labelArray;
    UIScrollView *_scrollView;
    CGFloat _lastOffset_x;
    NSMutableArray *_sourceArray;
    NSInteger _selectedIndex;
}

@end

@interface KLandscapeLabel : UILabel
@property (assign, nonatomic) NSInteger index;

@end
@implementation KLandscapeScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        _labelArray = [[NSMutableArray alloc]init];
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scrollView.delegate = self;
        _scrollView.scrollEnabled = YES;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
//        [self addLinePosi_Y:0];
//        [self addLinePosi_Y:View_Height(self) - 0.5];
        _selectedIndex = 0;
        
    }
    return self;
}

- (void)addLinePosi_Y:(CGFloat)posi_Y{
    UIView *lineView_top = [[UIView alloc] init];
    lineView_top.frame = CGRectMake(10, posi_Y, ViewWidth(self) - 20, 0.5);
    lineView_top.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [self addSubview:lineView_top];
}

- (void)setSourceArray:(NSArray *)sourceArray{
    _sourceArray = [NSMutableArray arrayWithArray:sourceArray];
    [_sourceArray insertObject:@"" atIndex:0];
    [_sourceArray addObject:@""];
    for (int i = 0; i < [_sourceArray count]; i++) {
        KLandscapeLabel *lable =[[KLandscapeLabel alloc]initWithFrame:CGRectMake(i * VIEW_WIDTH, 0, VIEW_WIDTH, View_Height(self)) ];
        lable.textColor = [UIColor colorWithHexString:@"#666666"];
        lable.textAlignment =  NSTextAlignmentCenter;
        lable.text = _sourceArray[i];
        lable.font = [UIFont systemFontOfSize:14.0f];
        lable.index = i - 1;
        [_scrollView addSubview:lable];
        [_labelArray addObject:lable];
        lable.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        tapGes.delegate = self;
        if (i != 0 && i != [_sourceArray count] - 1) {
            [lable addGestureRecognizer:tapGes];
        }
    }
    _scrollView.contentSize = CGSizeMake(VIEW_WIDTH * [_sourceArray count], 44);

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self resetScrollView:scrollView];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self resetScrollView:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset_x = scrollView.contentOffset.x;
    if (offset_x > _lastOffset_x) {
        //向左滑动
        if ((int)offset_x % (int)VIEW_WIDTH > VIEW_WIDTH / 2.0f) {
            [self resetSelectColor:((int)offset_x / (int)VIEW_WIDTH + 1)];
        }else {
            [self resetSelectColor:((int)offset_x / (int)VIEW_WIDTH)];
        }
    }else {
        //向右滑动
        if (abs((int)offset_x % (int)VIEW_WIDTH) < VIEW_WIDTH / 2.0f) {
            [self resetSelectColor:((int)offset_x / (int)VIEW_WIDTH)];
        }else {
            [self resetSelectColor:((int)offset_x / (int)VIEW_WIDTH + 1)];
        }
    }
    
    _lastOffset_x = offset_x;
}

- (void)resetScrollView:(UIScrollView *)scrollView{
    CGFloat offset_x = scrollView.contentOffset.x;
    if (offset_x > _lastOffset_x) {
        //向左滑动
        if ((int)offset_x % (int)VIEW_WIDTH > VIEW_WIDTH / 2.0f) {
            [self setSelectedIndex:((int)offset_x / (int)VIEW_WIDTH + 1) animated:YES];
        }else {
            [self setSelectedIndex:((int)offset_x / (int)VIEW_WIDTH) animated:YES];
        }
    }else {
        //向右滑动
        if (abs((int)offset_x % (int)VIEW_WIDTH) < VIEW_WIDTH / 2.0f) {
            [self setSelectedIndex:((int)offset_x / (int)VIEW_WIDTH) animated:YES];
        }else {
            [self setSelectedIndex:((int)offset_x / (int)VIEW_WIDTH + 1) animated:YES];
        }
    }
    
    _lastOffset_x = offset_x;
    
}

- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated{
    if (selectedIndex == _selectedIndex) {
        return;
    }
    [self resetSelectColor:selectedIndex];
    [_scrollView setContentOffset:CGPointMake(selectedIndex * VIEW_WIDTH, 0) animated:animated];
    _selectedIndex = selectedIndex;

}

- (void)resetSelectColor:(NSInteger)index{
    for (int i = 0; i < [_labelArray count]; i ++) {
        if (i != index + 1) {
            UILabel *label = _labelArray[i];
            label.textColor = [UIColor colorWithHexString:@"#666666"];
            label.font = [UIFont systemFontOfSize:14.0f];
        }
    }
    UILabel *thisLabel = _labelArray[index + 1];
    thisLabel.textColor = kColorFromRGBHex(0x2591f3);
    thisLabel.font = [UIFont systemFontOfSize:16.0f];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(landScapeScrollView:didSelectedIndex:title:)]) {
        [self.delegate landScapeScrollView:self didSelectedIndex:index title:thisLabel.text];
    }
}


#pragma -mark 点击
- (void)tapAction:(UITapGestureRecognizer *)tapGes{
    KLandscapeLabel *label = (KLandscapeLabel *)[tapGes view];
    [self setSelectedIndex:label.index animated:YES];
}


@end

@implementation KLandscapeLabel



@end
