//
//  AGDealBottomMenu.h
//  AiGou
//
//  Created by rimi on 14/12/26.
//  Copyright (c) 2014年 AG. All rights reserved.
//  底部菜单(父类)

#import <UIKit/UIKit.h>
#import "AGSubtitlesView.h"

@class AGDealBottomMenuItem;
@protocol AGSubtitlesViewDelegate;

@interface AGDealBottomMenu : UIView <AGSubtitlesViewDelegate>
{
    UIScrollView *_scrollView;
    AGSubtitlesView *_subtitlesView;
    AGDealBottomMenuItem * _selectedItem;
}

@property (nonatomic, copy)void(^hideBlock)();

- (void)itemClick:(AGDealBottomMenuItem *)item;
// 子类实现，确定选中按钮的类别
//- (void)settingSubtitlesView;

// 通过动画显示出来
- (void)show;
// 通过动画隐藏
- (void)hide;

@end
