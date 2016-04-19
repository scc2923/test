//
//  AGNavigationController.m
//  AiGou
//
//  Created by rimi on 14-12-23.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "AGNavigationController.h"

@interface AGNavigationController ()

@end

@implementation AGNavigationController

#pragma mark - 一个类只能调用一次
+ (void)initialize
{
    //取出设置主题的对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    
    //设置导航栏背景
    NSString *navBarBg = @"bg_navigationBar@2x.png";
    [navBar setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:navBarBg]] forBarMetrics:UIBarMetricsDefault];
    
    //设置导航栏标题颜色为白色
    [navBar setTitleTextAttributes:@{
                                     NSForegroundColorAttributeName:[UIColor whiteColor]
                                     }];
    //设置导航栏按钮文字为白色
    [barItem setTitleTextAttributes:@{
                                      NSForegroundColorAttributeName : [UIColor whiteColor],
                                      NSFontAttributeName : [UIFont systemFontOfSize:16]
                                      } forState:UIControlStateNormal];
    
    // 设置导航栏返回按钮的背景图片
//    [barItem setBackButtonBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:@"NavBackButton@2x.png"]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    // 设置导航栏的渐变色为白色（iOS7中返回箭头的颜色变为这个颜色：白色）
    navBar.tintColor = [UIColor whiteColor];
}

#pragma mark 控制状态栏的样式(白色)
- (UIStatusBarStyle)preferredStatusBarStyle
{
    // 白色样式
    return UIStatusBarStyleLightContent;
}

@end
