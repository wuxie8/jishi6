//
//  YTUIToolbar.h
//  小依休
//
//  Created by yant on 15/12/23.
//  Copyright © 2015年 AnSaiJie. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol YTUIToolbarDelegate <UIToolbarDelegate>

- (void)hiddenKeyboardAndEnsure;
- (void)hiddenKeyboardAndCancel;

@end

@interface YTUIToolbar : UIToolbar

@property(nonatomic, assign)id<YTUIToolbarDelegate> delegate;

@end
