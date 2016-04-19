//
//  AGBuyTimedNoticeViewController.m
//  AiGou
//
//  Created by Mac on 15/1/1.
//  Copyright (c) 2015年 AG. All rights reserved.
//

#import "AGPushNoticeViewController.h"
#import "AGAwardPushViewController.h"
#import "AGAwardAnimViewController.h"
#import "AGBuyTimedNoticeViewController.h"
#import "AGScoreShowNoticeViewController.h"
#import <ShareSDK/ShareSDK.h>

@interface AGPushNoticeViewController ()

@end

@implementation AGPushNoticeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.1
    AGSettingArrowItem *push = [AGSettingArrowItem itemWithTitle:@"开奖号码推送"];
    push.showVCClass = [AGAwardPushViewController class];
    
    // 1.2
    AGSettingArrowItem *anim = [AGSettingArrowItem itemWithTitle:@"中奖动画"];
    anim.showVCClass = [AGAwardAnimViewController class];
    // 1.3
    AGSettingArrowItem *score = [AGSettingArrowItem itemWithTitle:@"比分直播提醒"];
    score.showVCClass = [AGScoreShowNoticeViewController class];
//    AGSettingArrowItem *item3 = [AGSettingArrowItem itemWithTitle:@"新浪微博"];
//    item3.operation = ^{
//        [ShareSDK authWithType:ShareTypeSinaWeibo options:nil result:^(SSAuthState state, id<ICMErrorInfo> error) {
//        }];
//    };
    // 1.4
    AGSettingArrowItem *time = [AGSettingArrowItem itemWithTitle:@"购彩定时提醒"];
    time.showVCClass = [AGBuyTimedNoticeViewController class];
//    AGSettingArrowItem *item4 = [AGSettingArrowItem itemWithTitle:@"腾讯微博"];
//    item4.operation = ^{
//        [ShareSDK authWithType:ShareTypeTencentWeibo options:nil result:^(SSAuthState state, id<ICMErrorInfo> error) {
//        }];
//    };
    AGSettingGroup *group = [[AGSettingGroup alloc] init];
    group.items = @[push, anim, score, time];
    [_allGroups addObject:group];
}

@end
