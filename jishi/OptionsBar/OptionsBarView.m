//
//  OptionsBarView.m
//  SuperMarket
//
//  Created by hanzhanbing on 16/7/15.
//  Copyright © 2016年 柯南. All rights reserved.
//

#import "OptionsBarView.h"
#import "OptionsBarItem.h"
#import "BottomLineView.h"

@interface OptionsBarView()<UIScrollViewDelegate>{
    NSMutableArray *itemWidths;
    CGFloat totalWidth;
    NSMutableArray *lineXArr;
}
@property (nonatomic,weak)UIScrollView *mainView;
@property (nonatomic,weak)BottomLineView *bottonLineView;
@end

@implementation OptionsBarView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        UIScrollView *mainView=[[UIScrollView alloc]initWithFrame:CGRectZero];
        self.mainView=mainView;
        mainView.delegate=self;
        mainView.showsHorizontalScrollIndicator=NO;
        [self addSubview:mainView];
    }
    return self;
}

/**
 *  设置是否带分割线
 */
-(void)setShowSeprateLine:(BOOL)showSeprateLine{
    if(_showSeprateLine!=showSeprateLine){
        _showSeprateLine=showSeprateLine;
    }
}


/**
 *  获取字符串的长度
 *
 *  @param title 获取字符串的长度
 *
 *  @return size
 */
-(CGSize)widthWithTitle:(NSString *)title{
    NSDictionary *attribute=[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:14] forKey:NSFontAttributeName];
    return [title sizeWithAttributes:attribute];
}

/**
 *  设置titles
 *
 *  @param titles 设置titles
 */
-(void)setTitles:(NSArray *)titles{
    if(_titles!=titles){
        _titles=titles;
    }
    [self setItemWidthsWith:titles];
}

/**
 *  设置ItemWidths
 *
 *  @param titles 设置titles
 */
-(void)setItemWidthsWith:(NSArray *)titles{
    itemWidths=[NSMutableArray array];
    for (NSString *titleStr in titles) {
        CGSize size = [self widthWithTitle:titleStr];
        NSNumber *width=[NSNumber numberWithFloat:size.width+16];
        [itemWidths addObject:width];
    }
    BOOL result=[self adjustTotalWidth];
    [self setActualItemWidth:result];
}

/**
 *  判断itemWidths是否超过整个屏幕的宽度
 */
-(BOOL)adjustTotalWidth{
    totalWidth=0.0;
    for (NSNumber *number in itemWidths) {
        CGFloat width=[number floatValue];
        totalWidth+=width;
    }
    if(totalWidth<=WIDTH){
        return NO;
    }else{
        return YES;
    }
}

/**
 *  设置每一个item具体的长度
 */
-(void)setActualItemWidth:(BOOL)result{
    NSMutableArray *temp=[NSMutableArray array];
    if(!result){
        [itemWidths enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSNumber *width=(NSNumber *)obj;
            CGFloat new=[width floatValue]/totalWidth*WIDTH;
            NSNumber *newWidth=[NSNumber numberWithFloat:new];
            [temp addObject:newWidth];
        }];
        itemWidths=temp;
        totalWidth=WIDTH;
    }
    self.mainView.contentSize=CGSizeMake(totalWidth, 44);
    [self setUpAllItems];
}

/**
 *  生成所有的Items和下划线
 */
-(void)setUpAllItems{
    CGFloat itemX=0.0;
    lineXArr=[NSMutableArray array];
    for (NSInteger i=0; i<self.titles.count; i++) {
        if(i==self.titles.count-1&&_showSeprateLine){
            _showSeprateLine=!_showSeprateLine;
        }
        [lineXArr addObject:[NSNumber numberWithFloat:itemX]];
        OptionsBarItem *item=[[OptionsBarItem alloc]initWithFrame:CGRectMake(itemX, 0, [itemWidths[i] floatValue], 44)];
        item.tag = 10000+i;
        if (i==0) {
            item.textColor = _bottomLineColor;
        }
        item.title=self.titles[i];
        item.showSeprateLine=_showSeprateLine;
        item.index=i;
        itemX+=[itemWidths[i] floatValue];
        [self.mainView addSubview:item];
        [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    //定义初始的index
    _currentIndex=0;
    CGFloat lineWidth=[itemWidths[_currentIndex]floatValue];
    BottomLineView *line=[[BottomLineView alloc]initWithFrame:CGRectMake(0, 44-3, lineWidth, 3)];
    line.lineColer = _bottomLineColor;
    self.bottonLineView=line;
    [self.mainView addSubview:line];
}

/**
 *  按钮的响应事件(重点)
 */
-(void)clickItem:(OptionsBarItem *)item{
    //    self.currentIndex=item.index;
    
    for (int i = 0; i<self.titles.count; i++) {
        OptionsBarItem *barItem = [self viewWithTag:10000+i];
        if (barItem.tag == item.tag) {
            barItem.textColor = _bottomLineColor;
        } else {
            barItem.textColor = [UIColor colorWithRed:0.584 green:0.600 blue:0.641 alpha:1.000];
        }
    }
    
    if([self.delegate respondsToSelector:@selector(lhOptionBarView:didSelectedItemWithCurrentIndex:)]){
        [self.delegate lhOptionBarView:self didSelectedItemWithCurrentIndex:item.index];
    }
}

/**
 *  判断点击的方向
 *
 *  @param item <#item description#>
 */
-(void)adjustSelectedCurrentIndex:(NSInteger)index{
    if(index>_currentIndex){
        _currentIndex=index;
        if(self.currentIndex<self.titles.count-1){
            CGFloat lineX=[lineXArr[_currentIndex+1]floatValue];
            CGFloat width=[itemWidths[_currentIndex+1]floatValue];
            if((lineX+width)>WIDTH){
                CGFloat temp= lineX+width-WIDTH;
                [self.mainView setContentOffset:CGPointMake(temp, 0) animated:YES];
            }
        }
    }
    if(index<_currentIndex){
        _currentIndex=index;
        if(_currentIndex>1){
            CGFloat lineX=[lineXArr[_currentIndex]floatValue];
            CGFloat width=[itemWidths[_currentIndex-1]floatValue];
            if((lineX-width)>WIDTH){
                CGFloat temp= lineX+width-WIDTH;
                [self.mainView setContentOffset:CGPointMake(temp, 0) animated:YES];
            }
            if(lineX>WIDTH&&(lineX-width)<WIDTH){
                [self.mainView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
            if(lineX<WIDTH){
                [self.mainView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
        }
    }
}

-(void)setCurrentIndex:(NSInteger)currentIndex{
    [self adjustSelectedCurrentIndex:currentIndex];
    [UIView animateWithDuration:0.2 animations:^{
        CGFloat lineWidth=[itemWidths[_currentIndex]floatValue];
        CGFloat lineX=[lineXArr[_currentIndex]floatValue];
        self.bottonLineView.frame=CGRectMake(lineX, 44-3, lineWidth, 3);
    }];
    for (int i = 0; i<self.titles.count; i++) {
        OptionsBarItem *barItem = [self viewWithTag:10000+i];
        if (barItem.tag == 10000+currentIndex) {
            barItem.textColor = _bottomLineColor;
        } else {
            barItem.textColor = [UIColor colorWithRed:0.584 green:0.600 blue:0.641 alpha:1.000];
        }
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.mainView.frame=self.bounds;
}

@end
