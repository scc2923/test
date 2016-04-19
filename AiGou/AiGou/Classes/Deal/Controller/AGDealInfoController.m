//
//  AGDealInfoController.m
//  AiGou
//
//  Created by rimi on 14-12-31.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGDealInfoController.h"
#import "AGRestriction.h"
#import "AGInfoTextView.h"
#import "AGInfoHeaderView.h"
#import "AGDealTool.h"
#import "AGBuyDock.h"
#import "Defines.h"
#import "AGDeal.h"

#define kVMargin 15

@interface AGDealInfoController ()
{
    UIScrollView *_scrollView;
    AGInfoHeaderView *_header;
    //    CGFloat _currentY;
}

@end

@implementation AGDealInfoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.添加滚动视图
    [self addScrollView];
    
    // 2.添加头部控件
    [self addHeaderView];
    
    // 3.加载更详细的团购数据
    [self loadDetailDeal];
    
    // 4.添加底部的购买栏
    [self addBuyDock];
}

#pragma 添加底部的购买栏
- (void)addBuyDock
{
    AGBuyDock *dock = [AGBuyDock buyDock];
    dock.deal = _deal;
    dock.frame = CGRectMake(0, self.view.frame.size.height - kTabBarH - kNavcBarH, self.view.frame.size.width, kTabBarH+2);
    [self.view addSubview:dock];
}

#pragma mark 加载更详细的团购数据
- (void)loadDetailDeal
{
    // 1.添加指示器
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    CGFloat x = _scrollView.frame.size.width * 0.5;
    CGFloat y = CGRectGetMaxY(_header.frame) + kVMargin;
    indicator.center = CGPointMake(x, y);
    [_scrollView addSubview:indicator];
    [indicator startAnimating];
    
    // 2.发送请求
    [[AGDealTool sharedAGDealTool] dealWithID:_deal.deal_id success:^(AGDeal *deal) {
        _deal = deal;
        _header.deal = deal;
        
        // 添加详情数据
        [self addDetailViews];
        
        // 移除圈圈
        [indicator removeFromSuperview];
    } error:nil];
}

#pragma mark 添加详情数据（其他控件）
- (void)addDetailViews
{
    _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_header.frame) + kVMargin);
    
    // 1.团购详情
    [self addTextView:@"ic_content.png" title:@"团购详情" content:_deal.details];
    
    // 2.购买须知
    [self addTextView:@"ic_tip.png" title:@"购买须知" content:_deal.restrictions.special_tips];
    
    // 3.重要通知
    [self addTextView:@"ic_tip.png" title:@"重要通知" content:_deal.notice];
}

#pragma mark 添加一个TGInfoTextView
- (void)addTextView:(NSString *)icon title:(NSString *)title content:(NSString *)content
{
    if (content.length == 0) return;
    
    // 0.创建TextView
    AGInfoTextView *textView = [AGInfoTextView infoTextView];
    
    CGFloat y = _scrollView.contentSize.height;
    CGFloat w = _scrollView.frame.size.width;
    CGFloat h = textView.frame.size.height;
    textView.frame = CGRectMake(0, y, w, h);
    
    // 2.基本文字属性
    textView.title = title;
    textView.content = content;
    textView.icon = icon;
    
    // 3.添加
    [_scrollView addSubview:textView];
    
    // 4.设置scrollView的内容尺寸
    _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(textView.frame) + kVMargin);
}

#pragma mark 添加头部控件
- (void)addHeaderView
{
    AGInfoHeaderView *header = [AGInfoHeaderView infoHeaderView];
    header.frame = CGRectMake(0, 0, _scrollView.frame.size.width, header.frame.size.height);
    header.deal = _deal;
    [_scrollView addSubview:header];
    _header = header;
}

#pragma mark 添加滚动视图
- (void)addScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 45, kMainScreenH-40)];
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
}
@end
