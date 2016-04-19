//
//  AGBaseSettingViewController.m
//  AiGou
//
//  Created by Mac on 15/1/1.
//  Copyright (c) 2015年 AG. All rights reserved.
//

#import "AGAwardPushViewController.h"

@interface AGAwardPushViewController ()

@end

@implementation AGAwardPushViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"开奖推送设置";
    
    // 1.1.双色球
    AGSettingSwitchItem *ball = [AGSettingSwitchItem itemWithTitle:@"双色球"];
    
    // 1.2.大乐透
    AGSettingSwitchItem *letou = [AGSettingSwitchItem itemWithTitle:@"大乐透"];
    
    AGSettingGroup *group = [[AGSettingGroup alloc] init];
//    group.header = @"打开设置即可在开奖后立即收到推送消息，获知开奖号码";
    group.items = @[ball, letou];
    [_allGroups addObject:group];
}
@end