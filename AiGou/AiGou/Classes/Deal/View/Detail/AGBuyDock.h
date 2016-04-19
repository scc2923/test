//
//  AGBuyDock.h
//  AiGou
//
//  Created by rimi on 14-12-30.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AGDeal, AGCenterLineLabel;
@interface AGBuyDock : UIView
@property (weak, nonatomic) IBOutlet AGCenterLineLabel *listPrice;
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;

- (IBAction)buy;
@property (nonatomic, strong) AGDeal *deal;

+ (id)buyDock;
@end
