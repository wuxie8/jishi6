//
//  KLandscapeScrollView.h
//  KLandscapePickerVIew
//
//  Created by 佟堃 on 14/12/19.
//  Copyright (c) 2014年 . All rights reserved.
//

#import <UIKit/UIKit.h>
@class KLandscapeScrollView;
@protocol KLandscapeScrllViewDelegate <NSObject>

- (void)landScapeScrollView:(KLandscapeScrollView *)scrollView didSelectedIndex:(NSInteger)index title:(NSString *)title;

@end

@interface KLandscapeScrollView : UIView
@property (assign, nonatomic) NSInteger rowNum;
@property (assign, nonatomic) id<KLandscapeScrllViewDelegate>delegate;

- (void)setSourceArray:(NSArray *)array;

- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated;
@end

