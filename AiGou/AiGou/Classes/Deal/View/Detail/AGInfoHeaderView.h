//
//  AGInfoHeaderView.h
//  AiGou
//
//  Created by rimi on 14-12-30.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGRoundRectView.h"
@class AGDeal;
@interface AGInfoHeaderView : AGRoundRectView
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UIButton *anyTimeBack;
@property (weak, nonatomic) IBOutlet UIButton *expireBack;
@property (weak, nonatomic) IBOutlet UIButton *time;
@property (weak, nonatomic) IBOutlet UIButton *purchaseCount;

@property (nonatomic, strong) AGDeal *deal;
+ (id)infoHeaderView;
@end
