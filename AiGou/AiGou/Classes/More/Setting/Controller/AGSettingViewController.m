//
//  AGSettingViewController.m
//  AiGou
//
//  Created by rimi on 14/12/31.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGSettingViewController.h"
#import "AGPushNoticeViewController.h"
#import "AGShareViewController.h"
#import "UIBarButtonItem+AG.h"
#import "Defines.h"

@interface AGSettingViewController () <UIAlertViewDelegate>
{
    UIWebView *_webView;
}
@end

@implementation AGSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.第0组：3个
    [self addZeroSectionItems];
    
    // 2.第1组：6个
    [self addOneSectionItems];
}

#pragma mark 添加第0组模型数据
- (void)addZeroSectionItems
{
    // 1.1推送和提醒
    AGSettingArrowItem *push = [AGSettingArrowItem itemWithIcon:@"MorePush" title:@"推送和提醒"];
    push.showVCClass = [AGPushNoticeViewController class];
    // copy状态下的block(堆里面的block)会对里面所使用的外界变量产生强引用
//    __unsafe_unretained AGSettingViewController *shares = self;
//    push.operation = ^{
//        AGPushNoticeViewController * notic = [[AGPushNoticeViewController alloc] init];
//        notic.title = @"分享";
//        notic.view.backgroundColor = kGlobalBg;
//        [shares.navigationController pushViewController:notic animated:YES];
//    };
    
    // 1.2摇一摇机选
    AGSettingSwitchItem *shake = [AGSettingSwitchItem itemWithIcon:@"handShake" title:@"摇一摇机选"];
    shake.subtitle = @"使劲摇";
    shake.key = AGSettingHandShake;
    // 1.3声音效果
    AGSettingSwitchItem *sound = [AGSettingSwitchItem itemWithIcon:@"sound_Effect" title:@"声音效果"];
    sound.key = AGSettingSoundEffect;
    AGSettingGroup *group = [[AGSettingGroup alloc] init];
    group.items = @[push, shake, sound];
//    group.header = @"基本设置";
    
    [_allGroups addObject:group];
}

#pragma mark 添加第1组模型数据
- (void)addOneSectionItems
{
    // 2.1 检查更新版本
    AGSettingArrowItem *update = [AGSettingArrowItem itemWithIcon:@"MoreUpdate" title:@"检查新版本"];
     __unsafe_unretained AGSettingViewController *setting = self;
    update.operation = ^{
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"目前已是最新版本了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"检测到新版本" message:@"版本新特性如下：\n1.修正了少数BUG\n2.增加了什么模块\n3.增强了用户体验" delegate:setting cancelButtonTitle:@"取消" otherButtonTitles:@"前往下载", nil];
        [alert show];
    };
    
    // 2.2 帮助
    AGSettingArrowItem *help = [AGSettingArrowItem itemWithIcon:@"MoreHelp" title:@"帮助"];
//    __weak AGSettingViewController *helps = self;
//    help.operation = ^{
//        UIViewController *helpVC = [[UIViewController alloc] init];
//        helpVC.title = @"帮助";
//        helpVC.view.backgroundColor = kGlobalBg;
//        [helps.navigationController pushViewController:helpVC animated:YES];
//    };
    
    // 2.3 分享
    AGSettingArrowItem *share = [AGSettingArrowItem itemWithIcon:@"MoreShare" title:@"分享"];
    share.showVCClass = [AGShareViewController class];
//    __unsafe_unretained AGSettingViewController *shares = self;
//    share.operation = ^{
//        AGPushNoticeViewController * notic = [[AGPushNoticeViewController alloc] init];
//        notic.title = @"分享";
//        notic.view.backgroundColor = kGlobalBg;
//        [shares.navigationController pushViewController:notic animated:YES];
//    };
    // 2.4 查看信息
    AGSettingArrowItem *msg = [AGSettingArrowItem itemWithIcon:@"MoreMessage" title:@"查看信息"];
    msg.operation = ^{
        UIApplication *app = [UIApplication sharedApplication];
        [app openURL:[NSURL URLWithString:@"itcastapp://cn.itcast.aigouapp"]];
    };
    // 2.5 产品推荐
    AGSettingArrowItem *product = [AGSettingArrowItem itemWithIcon:@"MoreNetease" title:@"产品推荐"];
    // 2.6 关于
    __unsafe_unretained AGSettingViewController *abouts = self;
    AGSettingArrowItem *about = [AGSettingItem itemWithIcon:@"MoreAbout" title:@"关于"];
    about.operation = ^{
//        NSURL *url = [NSURL URLWithString:@"tel://020-10010"];
//        [[UIApplication sharedApplication] openURL:url];
        [abouts->_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://020-10010"]]];
    };
    
    AGSettingGroup *group = [[AGSettingGroup alloc] init];
    group.items = @[update, help, share, msg, product, about];
//    group.header = @"高级设置";
//    group.footer = @"高级设置尾部";
    
    [_allGroups addObject:group];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        UIApplication *app = [UIApplication sharedApplication];
        NSString *urlStr = [NSString stringWithFormat:@"http://itunes.apple.com/app/id%s?mt=8", AGAppId(719547787@qq.com)];
        MyLog(@"%@", urlStr);
        NSURL *url = [NSURL URLWithString:urlStr];
        if ([app canOpenURL:url]) {
            [app openURL:url];
        }
    }
}

- (void)dealloc
{
    MyLog(@"--------dealloc------");
}

@end