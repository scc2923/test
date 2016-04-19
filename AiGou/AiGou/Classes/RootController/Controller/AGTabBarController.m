//
//  AGTabBarController.m
//  AiGou
//
//  Created by rimi on 14-12-23.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "AGTabBarController.h"
#import "UINavigationItem+AG.h"
#import "AGDealListController.h"
#import "AGMapController.h"
#import "AGMineController.h"
#import "AGMoreController.h"
#import "AGTabBar.h"
#import "Defines.h"

@interface AGTabBarController () <AGTabBarDelegate>

@end

@implementation AGTabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 1.删除默认的tab按钮
        [self.tabBar removeFromSuperview];
        
        // UIRectEdgeNone不要往四周边缘展开
//        if (IOS5) {
//            self.edgesForExtendedLayout = UIRectEdgeNone;
//            for (UIViewController *vc in self.childViewControllers) {
//                vc.edgesForExtendedLayout = UIRectEdgeNone;
//            }
             // NO代表展开的时候不要包含导航条
//            self.extendedLayoutIncludesOpaqueBars = NO;
//        }
        
        // 2.创建tabbar
        CGRect frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y-64, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
        AGTabBar *myTabBar = [[AGTabBar alloc] initWithFrame:frame];
        myTabBar.delegate = self;
        [self.view addSubview:myTabBar];
        
        NSArray * titles = @[@"团购",@"地图",@"我的",@"更多"];
        // 3.添加4个按钮
        for (int i = 0; i < 4; i ++) {
            NSString *normal = [NSString stringWithFormat:@"icon_tabbar_%d.png", i];
            NSString *selected = [NSString stringWithFormat:@"icon_tabbar_selected_%d.png", i];
            [myTabBar addTabBarButton:normal selIcon:selected title:titles[i]];
        }
        AGDealListController *group = [[AGDealListController alloc] init];
        AGMapController *map = [[AGMapController alloc] init];
        AGMineController * mine = [[AGMineController alloc ]init];
        AGMoreController *more = [[AGMoreController alloc] init];
        self.viewControllers = @[group,map,mine,more];
        [self tabBar:(AGTabBar *)self.tabBar didSelectButtonFrom:0 to:0];
    }
    return self;
}

#pragma mark - tabbar代理方法
- (void)tabBar:(AGTabBar *)tabBar didSelectButtonFrom:(NSUInteger)from to:(NSUInteger)to
{
    // 1.根据位置选中某个控制器
    self.selectedIndex = to;
    UIViewController *newVC = self.viewControllers[to];
    //2.将新控制器的navigationItem值转移给TabBarController
    [self.navigationItem copyFromItem:newVC.navigationItem];
}

@end
