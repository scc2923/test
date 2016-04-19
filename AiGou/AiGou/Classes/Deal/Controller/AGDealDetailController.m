//
//  AGDealDetailController.m
//  AiGou
//
//  Created by rimi on 14/12/25.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGDealDetailController.h"
#import "AGDeal.h"
#import "UIBarButtonItem+AG.h"

#import "AGBuyDock.h"
#import "Defines.h"
#import "AGDetailDock.h"
#import "AGDealInfoController.h"
#import "AGDealWebController.h"
#import "AGMerchantController.h"
#import "AGCollectTool.h"

@interface AGDealDetailController () <AGDetailDockDelegate>
{
    AGDetailDock *_detailDock;
}

@end

@implementation AGDealDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // 1.基本设置
    [self baseSetting];
    
    // 2.添加底部的购买栏
//    [self addBuyDock];
    
    // 3.添加右边的选项卡栏
    [self addDetailDock];
    
    // 4.初始化子控制器
    [self addAllChildControllers];
    
}

#pragma 添加底部的购买栏
- (void)addBuyDock
{
    AGBuyDock *dock = [AGBuyDock buyDock];
    dock.deal = _deal;
    dock.frame = CGRectMake(0, self.view.frame.size.height - kTabBarH - kNavcBarH, self.view.frame.size.width, kTabBarH);
    [self.view addSubview:dock];
}

#pragma mark 初始化子控制器
- (void)addAllChildControllers
{
    // 1.团购简介
    AGDealInfoController *info = [[AGDealInfoController alloc] init];
    info.deal = _deal;
    [self addChildViewController:info];
    // 默认选中第0个控制器
    [self detailDock:nil btnClickFrom:0 to:0];
    
    // 2.图文详情
    AGDealWebController *web = [[AGDealWebController alloc] init];
    web.deal = _deal;
    [self addChildViewController:web];
    
    // 3.商家详情
    AGMerchantController *merchant = [[AGMerchantController alloc] init];
    merchant.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:merchant];
    
}

#pragma mark - 右边dock的代理方法
- (void)detailDock:(AGDetailDock *)detailDock btnClickFrom:(NSInteger)from to:(NSInteger)to
{
    // 1.移除旧控制器的view
    UIViewController *old = self.childViewControllers[from];
    [old.view removeFromSuperview];
    
    // 2.添加新控制器的view
    UIViewController *new = self.childViewControllers[to];
    CGFloat w = self.view.frame.size.width - _detailDock.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    new.view.frame = CGRectMake(0, 0, w, h);
    [self.view insertSubview:new.view atIndex:0];
}

#pragma 添加右边的选项卡栏
- (void)addDetailDock
{
    AGDetailDock *dock = [AGDetailDock detailDock];
    CGSize size = dock.frame.size;
    CGFloat x = self.view.frame.size.width - size.width;
    CGFloat y = self.view.frame.size.height - size.height - 100;
    dock.frame = CGRectMake(x, y, 0, 0);
    dock.delegate = self;
    [self.view addSubview:dock];
    _detailDock = dock;
}

#pragma 基本设置
- (void)baseSetting
{
    // 1.背景色
    self.view.backgroundColor = kGlobalBg;
    // 2.设置标题
    self.title = _deal.title;
    
    // 3.处理团购的收藏属性
    [[AGCollectTool sharedAGCollectTool] handleDeal:_deal];
    
    // 4.右上角的按钮
    NSString *collectIcon = _deal.collected ? @"ic_collect_suc.png" : @"ic_deal_collect.png";
    self.navigationItem.rightBarButtonItems = @[
                                                [UIBarButtonItem itemWithIcon:@"btn_share.png" highlightedIcon:@"btn_share_pressed.png" target:nil action:nil],
                                                [UIBarButtonItem itemWithIcon:collectIcon highlightedIcon:@"ic_deal_collect_pressed.png" target:self action:@selector(collect)]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"arrow_merchant_detail_map_normal" highlightedIcon:nil target:self action:@selector(back)];
    // 5.监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(collectChange) name:kCollectChangeNote object:nil];
    
}

#pragma mark 收藏
- (void)collect
{
    if (_deal.collected) { // 取消
        [[AGCollectTool sharedAGCollectTool] uncollectDeal:_deal];
    } else { // 收藏
        [[AGCollectTool sharedAGCollectTool] collectDeal:_deal];
    }
    
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kCollectChangeNote object:nil];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    if (_backBlock) {
        _backBlock();
    }
}

#pragma mark 收藏状态改变
- (void)collectChange
{
    [[AGCollectTool sharedAGCollectTool] handleDeal:_deal];
    UIButton *btn = (UIButton *)[self.navigationItem.rightBarButtonItems[1] customView];
    if (_deal.collected) {
        [btn setBackgroundImage:[UIImage imageNamed:@"ic_collect_suc.png"] forState:UIControlStateNormal];
    } else {
        [btn setBackgroundImage:[UIImage imageNamed:@"ic_deal_collect.png"] forState:UIControlStateNormal];
    }
}

@end
