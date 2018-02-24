//
//  UIView+SQLoadAnimation.m
//  SQHBToast_Example
//
//  Created by 曹星星 on 2018/2/24.
//  Copyright © 2018年 251180323@qq.com. All rights reserved.
//

#import "UIView+SQLoadAnimation.h"
#import <objc/runtime.h>
#import "SQLoadingView.h"

static char LoadingViewKey;

@implementation UIView (SQLoadAnimation)

#pragma mark LoadingView

- (void)setLoadingView:(SQLoadingView *)loadingView{
    [self willChangeValueForKey:@"SQLoadingView"];
    objc_setAssociatedObject(self, &LoadingViewKey,
                             loadingView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"SQLoadingView"];
}

- (SQLoadingView *)loadingView{
    return objc_getAssociatedObject(self, &LoadingViewKey);
}

- (BOOL)isLoading {
    return self.loadingView.isLoading;
}

- (void)beginLoading {
    
    if (!self.loadingView) {
        self.loadingView = [[SQLoadingView alloc] init];
    }
    UIView * containerView = self;
    UIView * loadingView = self.loadingView;
    loadingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [containerView addSubview:self.loadingView];
    self.loadingView.center = loadingView.center;
    [self.loadingView startLoading];
}

- (void)endLoading {
    if (self.loadingView) {
        [self.loadingView stopLoading];
        self.loadingView = nil;
    }
}

@end
