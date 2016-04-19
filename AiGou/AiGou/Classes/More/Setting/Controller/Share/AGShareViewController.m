//
//  AGShareViewController.m
//  AiGou
//
//  Created by rimi on 14/12/31.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGShareViewController.h"

@interface AGShareViewController ()

@end

@implementation AGShareViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"分享设置";
    
    // 1.1.新浪微博
    AGSettingArrowItem *weibo = [AGSettingArrowItem itemWithIcon:@"ic_comment_social_share_weibo_normal" title:@"新浪微博"];
    
    // 1.2.短信分享
    AGSettingArrowItem *sms = [AGSettingArrowItem itemWithIcon:@"ic_comment_social_share_qqweibo_normal" title:@"腾讯微博"];
    
    // 1.3.邮件分享
    AGSettingArrowItem *mail = [AGSettingArrowItem itemWithIcon:@"ic_comment_social_share_weixin_normal" title:@"微信"];
    
    AGSettingGroup *group = [[AGSettingGroup alloc] init];
    group.items = @[weibo, sms, mail];
    [_allGroups addObject:group];
}

@end
