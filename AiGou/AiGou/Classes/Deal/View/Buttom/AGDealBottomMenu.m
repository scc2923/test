//
//  AGDealBottomMenu.m
//  AiGou
//
//  Created by rimi on 14/12/26.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGDealBottomMenu.h"
#import "AGSubtitlesView.h"
#import "AGDealBottomMenuItem.h"
#import "AGMetaDataTool.h"
#import "Defines.h"
#import "AGCategoryMenuItem.h"
#import "AGDistrictMenuItem.h"
#import "AGOrderMenuItem.h"
#import "AGCover.h"

@interface AGDealBottomMenu ()
{
    UIView * _contentView;
    UIView * _cover;
}
@end

@implementation AGDealBottomMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        // 1.添加蒙板（遮盖）
        _cover = [AGCover coverWithTarget:self action:@selector(hide)];
        _cover.frame = CGRectMake(0, kTopMenuItemH, kMainScreenW, kMainScreenH-kTopMenuItemH);
        [self addSubview:_cover];
        
        // 2.内容view
        _contentView = [[UIView alloc] init];
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _contentView.frame = CGRectMake(0, 0, self.frame.size.width, kBottomMenuItemH);
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_contentView];

        // 3.添加UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        scrollView.frame = CGRectMake(0, 0, self.frame.size.width, kBottomMenuItemH);
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.showsHorizontalScrollIndicator = NO;
        [_contentView addSubview:scrollView];
        _scrollView = scrollView;
    }
    return self;
}

#pragma mark 监听所有菜单项的点击
- (void)itemClick:(AGDealBottomMenuItem *)item
{
    // 1.控制item的状态
    _selectedItem.selected  = NO;
    item.selected = YES;
    _selectedItem = item;
    
    // 2.查看是否有子分类
    if (item.titles.count) {// 显示所有的子标题
        [self showSubtitlesView:item];
    } else {// 隐藏所有的子标题
        [self hideSubtitlesView:item];
    }
}

#pragma mark 显示子标题
- (void)showSubtitlesView:(AGDealBottomMenuItem *)item
{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:kDuration];
    if (_subtitlesView == nil) {
        _subtitlesView = [[AGSubtitlesView alloc] init];
        _subtitlesView.delegate = self;
//        [self settingSubtitlesView];
    }
    
    // 设置子标题的frame
    _subtitlesView.frame = CGRectMake(0, kBottomMenuItemH, self.frame.size.width, _subtitlesView.frame.size.height);
    // 设置子标题的主标题
    _subtitlesView.mainTitle = [item titleForState:UIControlStateNormal];
    // 设置子标题需要显示的内容
    _subtitlesView.titles = item.titles;
    
    // 当前子标题没有正在展示的时候，就需要执行动画
    if (_subtitlesView.superview == nil) { // 没有父控件
        [_subtitlesView show];
    }
    // 添加子标题到内容view-scrollView底部
    [_contentView insertSubview:_subtitlesView belowSubview:_scrollView];
    
    // 调整contentView的高度
    // 调整整个内容view的内容
    CGRect cf = _contentView.frame;
    cf.size.height = CGRectGetMaxY(_subtitlesView.frame);
    _contentView.frame = cf;
    
//     [UIView commitAnimations];
}

#pragma mark 隐藏子标题
- (void)hideSubtitlesView:(AGDealBottomMenuItem *)item
{
    // 1.通过动画隐藏子标题
    [_subtitlesView hide];
    
    // 2.调整contentView的高度
    CGRect cf = _contentView.frame;
    cf.size.height = kBottomMenuItemH;
    _contentView.frame = cf;
    
    // 3.设置当前数据
    NSString *title = [item titleForState:UIControlStateNormal];
    if ([item isKindOfClass:[AGCategoryMenuItem class]]) { // 分类
        [AGMetaDataTool sharedAGMetaDataTool].currentCategory = title;
    } else if ([item isKindOfClass:[AGDistrictMenuItem class]]) { // 区域
        [AGMetaDataTool sharedAGMetaDataTool].currentDistrict = title;
    } else { // 排序
        [AGMetaDataTool sharedAGMetaDataTool].currentOrder = [[AGMetaDataTool sharedAGMetaDataTool] orderWithName:title];
    }
}

#pragma mark 显示
- (void)show
{
    _contentView.transform = CGAffineTransformMakeTranslation(0, -_contentView.frame.size.height);
    _contentView.alpha = 0;
    _cover.alpha = 0;
    [UIView animateWithDuration:kDuration animations:^{
        // 1.scrollView从上面 -> 下面
        _contentView.transform = CGAffineTransformIdentity;
        _contentView.alpha = 1;
        // 2.遮盖（0 -> 0.4）
        _cover.alpha = kCoverAlpha;
    }];
}

- (void)hide
{
    if (_hideBlock) {
        _hideBlock();
    }
    [UIView animateWithDuration:kDuration animations:^{
        // 1.scrollView从下面 -> 上面
        _contentView.transform = CGAffineTransformMakeTranslation(0, -_contentView.frame.size.height);
         _contentView.alpha = 0;
        // 2.遮盖（0.4 -> 0）
        _cover.alpha = 0;
    } completion:^(BOOL finished) {
        // 从父控件中移除
        [self removeFromSuperview];
        // 恢复属性
        _contentView.transform = CGAffineTransformIdentity;
        _contentView.alpha = 1;
        _cover.alpha = kCoverAlpha;
    }];
}

@end
