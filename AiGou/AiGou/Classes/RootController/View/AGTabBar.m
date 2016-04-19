//
//  AGTabBar.m
//  AiGou
//
//  Created by rimi on 14-12-23.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "AGTabBar.h"
#import "AGTabBarButton.h"

@interface AGTabBar ()
{
    AGTabBarButton *_selectedButton;
}

@end

@implementation AGTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tabbar@2x.png"]];
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

#pragma mark 添加一个按钮
- (void)addTabBarButton:(NSString *)icon selIcon:(NSString *)selIcon title:(NSString *)title
{
    // 1.创建按钮
    AGTabBarButton *button = [[AGTabBarButton alloc] init];

    // 2.设置背景
    
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selIcon] forState:UIControlStateSelected];
    
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    button.imageView.contentMode = UIViewContentModeCenter; // 让图片在按钮内居中
    button.titleLabel.textAlignment = NSTextAlignmentCenter; // 让标题在按钮内居中
    button.titleLabel.font = [UIFont systemFontOfSize:11]; // 设置标题的字体大小
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:20/255.0 green:190/255.0 blue:168/255.0 alpha:1] forState:UIControlStateSelected];
    // 3.添加
    [self addSubview:button];
    
    // 4.重新调整所有按钮的frame
    [self adjustButtonFrames];
    
    // 5.默认选中第0个按钮
    button.tag = self.subviews.count - 1;
    if (self.subviews.count == 1) {
        [self buttonClick:button];
    }
}

#pragma mark 重新调整所有按钮的frame
- (void)adjustButtonFrames
{
    NSInteger btnCount = self.subviews.count;
    for (int i = 0; i < btnCount; i++) {
        AGTabBarButton *button = self.subviews[i];
        
        // 设置frame
        CGFloat buttonY = 0;
        CGFloat buttonW = self.frame.size.width / btnCount;
        CGFloat buttonX = i * buttonW;
        CGFloat buttonH = self.frame.size.height;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}

#pragma mark 监听按钮点击
- (void)buttonClick:(AGTabBarButton *)button
{
    // 1.通知代理
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectButtonFrom:to:)]) {
        [_delegate tabBar:self didSelectButtonFrom:_selectedButton.tag to:button.tag];
    }
    
    // 2.切换按钮状态
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
}

@end
