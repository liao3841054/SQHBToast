//
//  SQLoadingView.h
//  SQHBToast_Example
//
//  Created by 曹星星 on 2018/2/24.
//  Copyright © 2018年 251180323@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQLoadingView : UIView
{
    UIImageView *_loadingView;
}
@property(nonatomic ,strong, readonly) UIImageView *loadingView;

@property(nonatomic ,getter=isLoading) BOOL loading;

- (void)startLoading;
- (void)stopLoading;

@end
