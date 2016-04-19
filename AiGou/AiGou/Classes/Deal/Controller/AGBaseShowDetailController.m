//
//  AGBaseShowDetailController.m
//  AiGou
//
//  Created by rimi on 14/12/25.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGBaseShowDetailController.h"
#import "AGDealDetailController.h"
#import "UIBarButtonItem+AG.h"
#import "AGNavigationController.h"
#import "Defines.h"
#import "AGCover.h"

#define kDetailWidth kMainScreenW

@interface AGBaseShowDetailController ()
{
    AGCover *_cover;
}
@end

@implementation AGBaseShowDetailController

- (void)showDetail:(AGDeal *)deal
{
    // 1.显示遮盖
    if (_cover == nil) {
        _cover = [AGCover coverWithTarget:self action:@selector(hideDetail)];
    }
    _cover.frame = self.navigationController.view.bounds;
    _cover.alpha = 0;
    [UIView animateWithDuration:kDuration animations:^{
        [_cover reset];
    }];
    [self.navigationController.view addSubview:_cover];
    // 2.展示团购详情控制器
    AGDealDetailController *detail = [[AGDealDetailController alloc] init];
    detail.backBlock = ^{
        [self hideDetail];
    };
    
//    detail.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"btn_nav_close.png" highlightedIcon:@"btn_nav_close_hl.png" target:self action:@selector(hideDetail)];
    
    detail.deal = deal;
    AGNavigationController *nav = [[AGNavigationController alloc] initWithRootViewController:detail];
    // 监听拖拽
    [nav.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(drag:)]];
//    nav.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
    nav.view.frame = CGRectMake(_cover.frame.size.width, 0, kDetailWidth, _cover.frame.size.height);
    // 当2个控制器互为父子关系时，它们的view也是互为父子关系
    [self.navigationController.view addSubview:nav.view];
    [self.navigationController addChildViewController:nav];
    
    [UIView animateWithDuration:kDuration animations:^{
        CGRect f = nav.view.frame;
        f.origin.x -= kDetailWidth;
        nav.view.frame = f;
    }];
}

#pragma mark 隐藏详情控制器
- (void)hideDetail
{
    UIViewController *nav = [self.navigationController.childViewControllers lastObject];
    [UIView animateWithDuration:0.3 animations:^{
        // 1.隐藏遮盖
        _cover.alpha = 0;
        
        // 2.隐藏控制器
        CGRect f = nav.view.frame;
        f.origin.x += kDetailWidth;
        nav.view.frame = f;
    } completion:^(BOOL finished) {
        [_cover removeFromSuperview];
        
        [nav.view removeFromSuperview];
        [nav removeFromParentViewController];
    }];
}

- (void)drag:(UIPanGestureRecognizer *)pan
{
    CGFloat tx = [pan translationInView:pan.view].x;
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        CGFloat halfW = pan.view.frame.size.width * 0.5;
        if (tx >= halfW) { // 已经往右边挪动超过一半了
            [self hideDetail];
        } else {
            [UIView animateWithDuration:kDuration animations:^{
                pan.view.transform = CGAffineTransformIdentity;
            }];
        }
    } else { // 移动控制器的view
        if (tx < 0) { // 向左边拽
            tx *= 0.4;
        }
        pan.view.transform = CGAffineTransformMakeTranslation(tx, 0);
    }
}

@end
