//
//  AGSettingCell.h
//  AiGou
//
//  Created by rimi on 14/12/31.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AGSettingItem;

@interface AGSettingCell : UITableViewCell

@property (nonatomic, strong)AGSettingItem *item;
@property (nonatomic, strong) NSIndexPath *indexPath;

+ (instancetype)settingCellWithTableView:(UITableView *)tableView;

@end
