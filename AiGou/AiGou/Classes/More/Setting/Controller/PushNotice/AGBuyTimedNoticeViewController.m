//
//  AGBuyTimedNoticeViewController.m
//  AiGou
//
//  Created by Mac on 15/1/1.
//  Copyright (c) 2015年 AG. All rights reserved.
//

#import "AGBuyTimedNoticeViewController.h"

@interface AGBuyTimedNoticeViewController ()

@end

@implementation AGBuyTimedNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提醒设置";
    AGSettingSwitchItem *notice = [AGSettingSwitchItem itemWithTitle:@"打开提醒"];
    AGSettingGroup *group = [[AGSettingGroup alloc] init];
    group.items = @[notice];
    group.header = @"您可以通过设置，提醒自己在开奖日不要忘了购买彩票";
    [_allGroups addObject:group];
}

@end
