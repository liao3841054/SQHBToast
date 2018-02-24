/************************************************************
 *  * EaseMob CONFIDENTIAL
 * __________________
 * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of EaseMob Technologies.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from EaseMob Technologies.
 */

#import "UIViewController+HUD.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

#define kDefaultOffSet_Y      0
#define kDefaultLableFont     [UIFont systemFontOfSize:15]
#define kDefaultHidenDuration 1.5f
#define kLoadingTintColor     [[UIColor blackColor] colorWithAlphaComponent:0.5]
#define kCompleteTintColor    [[UIColor blackColor] colorWithAlphaComponent:0.65]

#define kNavigationBarAlertHeight  35
#define kNavigationBarIconWidth    4
#define kNavigationBarIconHeight   16

static const void *AssociatedHUDKey = &AssociatedHUDKey;

@interface UIViewController ()

@property (nonatomic, assign) BOOL isNavAlertShowing;

@end

@implementation UIViewController (HUD)



- (MBProgressHUD *)HUD {
    return objc_getAssociatedObject(self, AssociatedHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD {
    [self willChangeValueForKey:@"HUD"];
    objc_setAssociatedObject(self, AssociatedHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"HUD"];
}

UIWindow *keyWindow() {
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (!window || window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    return window;
}

- (void)showHudInView:(UIView *)view hint:(NSString *)hint {
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.labelText = hint;
    HUD.labelFont = kDefaultLableFont;
    HUD.color = kLoadingTintColor;
    [view addSubview:HUD];
    [HUD show:YES];
    [self setHUD:HUD];
}

- (void)showHint:(NSString *)hint {
    //显示提示信息
    UIView *view = keyWindow();
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.labelFont = kDefaultLableFont;
    hud.yOffset = kDefaultOffSet_Y;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:kDefaultHidenDuration];
}

- (void)showHint:(NSString *)hint yOffset:(float)yOffset {
    //显示提示信息
    UIView *view = keyWindow();
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.labelFont = kDefaultLableFont;
    hud.yOffset = kDefaultOffSet_Y;
    hud.yOffset += yOffset;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:kDefaultHidenDuration];
}

- (void)showSucessHint:(NSString *)hint {
    //显示提示信息
    UIView *view = keyWindow();
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"operationbox_successful"]];
    hud.labelText = hint?hint:@"操作成功";
    hud.labelFont = kDefaultLableFont;
    hud.yOffset = kDefaultOffSet_Y;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:kDefaultHidenDuration];
}

- (void)hideHud {
    if (self.HUD) {
        [[self HUD] hide:YES];
    }
}

#pragma makr - 

void MBShowToast(NSString * hint) {
    UIViewController *controller = keyWindow().rootViewController;
    [controller hideHud];
    if (controller.view == nil) {
        return;
    }
    //显示提示信息
    UIView *view = controller.view ;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.color = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    hud.labelText = hint;
    hud.labelFont = kDefaultLableFont;
    hud.yOffset = kDefaultOffSet_Y;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:kDefaultHidenDuration];
}

void MBShowHudInView(UIViewController * self,NSString * hint) {
    [self hideHud];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.color = kLoadingTintColor;
    hud.detailsLabelText = hint;
    hud.detailsLabelFont = kDefaultLableFont;
    [self.view addSubview:hud];
    [hud show:YES];
    [self setHUD:hud];
}

void MBShowHint(UIViewController * self, NSString * hint) {
    [self hideHud];
    // 显示提示信息
    UIView *view = keyWindow();
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.color = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    hud.detailsLabelText = hint;
    hud.detailsLabelFont = kDefaultLableFont;
    hud.yOffset = kDefaultOffSet_Y;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:kDefaultHidenDuration];
}

void MBShowHintInTime(UIViewController * self, NSString * hint, CGFloat duration) {
    MBHideHudFrom(keyWindow());
    MBHideHud(keyWindow().rootViewController);
    MBHideHud(self);
    
    UIViewController *controller = keyWindow().rootViewController;
    if (controller.view == nil) {
        return;
    }
    // 显示提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:controller.view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.color = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    hud.detailsLabelText = hint;
    hud.detailsLabelFont = kDefaultLableFont;
    hud.yOffset = kDefaultOffSet_Y;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:duration];
}

void MBShowProgress(UIViewController * self,NSString * hint) {
    [self hideHud];
    //显示提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.userInteractionEnabled = YES;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.color = kLoadingTintColor;
    hud.labelText = hint;
    hud.labelFont = kDefaultLableFont;
    hud.yOffset = kDefaultOffSet_Y;
    hud.removeFromSuperViewOnHide = YES;
    [self setHUD:hud];
}

void MBSetProgress(UIViewController * self,CGFloat progress) {
    MBProgressHUD *hud = [self HUD];
    if (hud.mode == MBProgressHUDModeAnnularDeterminate) {
        [hud setProgress:progress];
    }
}

void MBShowSucessHint(UIViewController * self,NSString * hint) {
    [self hideHud];
    //显示提示信息
    UIView *view = keyWindow();
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"operationbox_successful"]];
    hud.labelText = hint?hint:@"操作成功";
    hud.labelFont = kDefaultLableFont;
    hud.yOffset = kDefaultOffSet_Y;
    hud.color = kCompleteTintColor;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:kDefaultHidenDuration];
}

void MBShowErrorHint(UIViewController * self,NSString * hint) {
    [self hideHud];
    //显示提示信息
    UIView *view = keyWindow();
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = hint?hint:@"操作失败";
    hud.detailsLabelFont = kDefaultLableFont;
    hud.yOffset = kDefaultOffSet_Y;
    hud.color = kCompleteTintColor;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:kDefaultHidenDuration];
}

void MBHideHud(UIViewController * self) {
    [self hideHud];
}

void MBHideHudFrom(UIView * view) {
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[MBProgressHUD class]]) {
            [(MBProgressHUD *)subView hide:YES];
            break;
        }
    }
}

#pragma mark - Navigation Alert

void ShowNavigationBarAlert(UIViewController * self, NSString * title,BOOL isSucess) {
    if (!self.navigationController) {
        return;
    }
    if (self.isNavAlertShowing) {
        return;
    }
    self.isNavAlertShowing = YES;
    // content bg
    UIImage * image = [UIImage imageNamed:@"nav_alert_sucess"];
    if (!isSucess) {
        image = [UIImage imageNamed:@"nav_alert_error"];
    }
    UIImageView * alertBar = [[UIImageView alloc]initWithImage:image];
    alertBar.contentMode = UIViewContentModeScaleAspectFill;
    CGRect frame = CGRectZero;
    frame.origin = (CGPoint){15, (44 + [UIApplication sharedApplication].statusBarFrame.size.height) - kNavigationBarAlertHeight};
    frame.size.width = [UIScreen mainScreen].bounds.size.width - 2 *15;
    frame.size.height = kNavigationBarAlertHeight;
    alertBar.frame = frame;
    // title
    UILabel * label = [[UILabel alloc]initWithFrame:alertBar.bounds];
    label.text = title;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15.0];
    label.textAlignment = NSTextAlignmentCenter;
    // attribute text
    NSMutableAttributedString * newTitle = [[NSMutableAttributedString alloc]initWithString:title];
    [newTitle addAttributes:@{NSForegroundColorAttributeName:label.textColor,
                             NSFontAttributeName:label.font}
                     range:NSMakeRange(0, title.length)];
    [newTitle insertAttributedString:[[NSMutableAttributedString alloc] initWithString:@"  "] atIndex:0];

    UIImage * iconImage = [UIImage imageNamed:@"nav_alert_top_tips"];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = iconImage;
    attch.bounds = CGRectMake(0, -3, kNavigationBarIconWidth, kNavigationBarIconHeight);

    NSAttributedString * attchString = [NSAttributedString attributedStringWithAttachment:attch];
    [newTitle insertAttributedString:attchString atIndex:0];

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init] ;
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    [newTitle addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, newTitle.length)];

    label.attributedText = newTitle;
    // add subview
    [alertBar addSubview:label];
    [self.navigationController.navigationBar insertSubview:alertBar atIndex:0];
    objc_setAssociatedObject(self, "nav_alert_bar", alertBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // animate show hiden
    CGFloat duration = 0.5f;
    [UIView animateWithDuration:duration animations:^{
        alertBar.transform = CGAffineTransformMakeTranslation(0, alertBar.frame.size.height);
    } completion:^(BOOL finished) {
        CGFloat delay = 1.0f;
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            alertBar.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [alertBar removeFromSuperview];
            self.isNavAlertShowing = NO;
        }];
    }];
}

void HiddenNavigationBarAlertRightNow(UIViewController * self) {
    if (self.isNavAlertShowing) {
        UIView * alertBar = objc_getAssociatedObject(self, "nav_alert_bar");
        [alertBar removeFromSuperview];
        self.isNavAlertShowing = NO;
    }
}

void ShowNavigationBarSucessAlert(UIViewController * self, NSString * title) {
    ShowNavigationBarAlert(self, title, YES);
}

void ShowNavigationBarErrorAlert(UIViewController * self, NSString * title) {
    ShowNavigationBarAlert(self, title, NO);
}

- (BOOL)isNavAlertShowing {
    return [objc_getAssociatedObject(self, "obj_isalerting") boolValue];
}

- (void)setIsNavAlertShowing:(BOOL)isNavAlertShowing {
    [self willChangeValueForKey:@"isNavAlerting"];
    objc_setAssociatedObject(self, "obj_isalerting", @(isNavAlertShowing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"isNavAlerting"];
}


@end
