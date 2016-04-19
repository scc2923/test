//
//  AGMyTableViewCell.h
//  AiGou
//
//  Created by rimi on 14/12/30.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGMyTableViewCell : UITableViewCell

@property (nonatomic, copy)NSString * cellTitleName;
@property (nonatomic, retain)UISwitch * cellSwith;
@property (nonatomic, copy)NSString * isAddToView;

@end