//
//  AGDealDetailController.h
//  AiGou
//
//  Created by rimi on 14/12/25.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AGDeal;

@interface AGDealDetailController : UIViewController

@property (nonatomic, strong) AGDeal *deal;

@property (nonatomic, copy) void(^backBlock)();

@end
