//
//  AGAwardAnimViewController.m
//  AiGou
//
//  Created by Mac on 15/1/1.
//  Copyright (c) 2015年 AG. All rights reserved.
//

#import "AGAwardAnimViewController.h"

@interface AGAwardAnimViewController ()

@end

@implementation AGAwardAnimViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"中奖动画";
    AGSettingSwitchItem *anim = [AGSettingSwitchItem itemWithTitle:self.title];
    AGSettingGroup *group = [[AGSettingGroup alloc] init];
    group.header = @"当您有新中奖订单，启动程序时通过动画提醒你。为了避免过于频繁，高频彩不会提醒您。";
    group.items = @[anim];
    [_allGroups addObject:group];
}

@end
