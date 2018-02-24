//
//  NSObject+UIAlert.h
//  StarProject
//
//  Created by Roy lee on 15/10/16.
//  Copyright © 2015年 WJX_HP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SQHUD)

- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

- (void)hideHud;

- (void)showHint:(NSString *)hint;

// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)showHint:(NSString *)hint yOffset:(float)yOffset;

- (void)showSucessHint:(NSString *)hint;

#pragma mark - 函数 -
/**
 *  .mm C++文件引用问题解决办法
 */
#ifdef __cplusplus
extern "C" {
#endif
    // by liaoyp
    void MBShowToast(NSString * hint);
    
    // 显示HUD占位
    void MBShowHudInView(UIViewController * self,NSString * hint);
    // 显示提示自动消失
    void MBShowHint(UIViewController * self,NSString * hint);
    // 显示提示指定时间消失
    void MBShowHintInTime(UIViewController * self, NSString * hint, CGFloat duration);
    // 显示进度
    void MBShowProgress(UIViewController * self,NSString * hint);
    // 设置进度
    void MBSetProgress(UIViewController * self,CGFloat progress);
    // 显示成功
    void MBShowSucessHint(UIViewController * self,NSString * hint);
    // 显示失败
    void MBShowErrorHint(UIViewController * self,NSString * hint);
    // 隐藏消失
    void MBHideHud(UIViewController * self);
    
    
#pragma mark - Navigation Alert
    // 导航栏提示横幅
    void ShowNavigationBarSucessAlert(UIViewController * self, NSString * title);
    
    void ShowNavigationBarErrorAlert(UIViewController * self, NSString * title);
    
    void HiddenNavigationBarAlertRightNow(UIViewController * self);
    
#ifdef __cplusplus
}
#endif


@end
