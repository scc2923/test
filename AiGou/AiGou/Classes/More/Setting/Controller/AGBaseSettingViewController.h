//
//  AGBaseSettingViewController.h
//  AiGou
//
//  Created by rimi on 14/12/31.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGSettingGroup.h"
#import "AGSettingItem.h"
#import "AGSettingArrowItem.h"
#import "AGSettingSwitchItem.h"
#import "AGSettingLabelItem.h"
#import "AGSettingKeys.h"

@interface AGBaseSettingViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_allGroups; // 所有的组模型
}

@property (nonatomic, weak, readonly)UITableView *tableView;

@end
