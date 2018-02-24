//
//  SQViewController.m
//  SQHBToast
//
//  Created by 251180323@qq.com on 02/24/2018.
//  Copyright (c) 2018 251180323@qq.com. All rights reserved.
//

#import "SQViewController.h"
#import <SQHBToast/UIViewController+HUD.h>
#import <SQHBToast/UIView+SQLoadAnimation.h>

@interface SQViewController ()

@end

@implementation SQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    MBShowToast(@"OKOK");
    
    [self.view beginLoading];    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    BOOL isLoading = [self.view.loadingView isLoading];
    if (isLoading) {
        [self.view endLoading];
    }
    else
    {
        [self.view beginLoading];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
