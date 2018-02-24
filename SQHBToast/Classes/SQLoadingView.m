//
//  SQLoadingView.m
//  SQHBToast_Example
//
//  Created by 曹星星 on 2018/2/24.
//  Copyright © 2018年 251180323@qq.com. All rights reserved.
//

#import "SQLoadingView.h"

@implementation SQLoadingView

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = 52.0;
        frame.size.height = 9.0;
    }
    if (![super initWithFrame:frame]) return nil;
   
    [self initLoadingView];
    
    return self;
}

- (void)initLoadingView {
    _loadingView = [[UIImageView alloc] init];
    NSMutableArray *loadingArray  =[NSMutableArray arrayWithCapacity:22];
    
    for (int i = 1; i < 22; i ++) {
        
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"SQHBToast" ofType:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        
        NSString *imageNmae =[NSString stringWithFormat:@"loading%d",i];
        UIImage *image =  [UIImage imageNamed:imageNmae inBundle:bundle compatibleWithTraitCollection:nil];
        if (image) {
            [loadingArray addObject:image];
        }
    }
    
    /**
     *  开始动画
     */
    _loadingView.animationDuration = 1.0;
    //设置重复次数,0表示不重复
    _loadingView.animationRepeatCount = 0;
    //开始动画
    _loadingView.animationImages = loadingArray;
    [self addSubview:_loadingView];
    _loadingView.frame  = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _loadingView.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (BOOL)isLoading
{
    return _loading;
}

- (void)startLoading {
    
    if (_loading) return;
    _loading = YES;
    
    [_loadingView startAnimating];
}

- (void)stopLoading {
    
    _loading = NO;
    
    [_loadingView stopAnimating];
    _loadingView.animationImages = nil;
    [self removeFromSuperview];
}


@end
