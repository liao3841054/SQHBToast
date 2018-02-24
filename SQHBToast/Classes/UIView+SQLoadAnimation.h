//
//  UIView+SQLoadAnimation.h
//  SQHBToast_Example
//
//  Created by 曹星星 on 2018/2/24.
//  Copyright © 2018年 251180323@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLoadingView.h"

@interface UIView (SQLoadAnimation)

@property (strong, nonatomic) SQLoadingView *loadingView;

- (void)beginLoading;

- (void)endLoading;

@end
