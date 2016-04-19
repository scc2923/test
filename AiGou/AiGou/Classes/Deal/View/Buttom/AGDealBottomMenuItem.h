//
//  AGDealBottomMenuItem.h
//  AiGou
//
//  Created by rimi on 14/12/26.
//  Copyright (c) 2014年 AG. All rights reserved.
//  底部菜单项（父类）

#import <UIKit/UIKit.h>

@interface AGDealBottomMenuItem : UIButton
// 专门交个子类去实现
- (NSArray *)titles;
@end
