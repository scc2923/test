//
//  AGPopController.h
//  AiGou
//
//  Created by Mac on 14/12/28.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGMetaDataTool.h"
#import "AGCity.h"

@interface AGPopController : UIView

- (id)initWithPoint:(CGPoint)point;
- (void)show;
- (void)dismiss;
- (void)dismiss:(BOOL)animated;

//选择一行之后调用Block改变当前城市
@property (nonatomic, copy) void (^selectedCity)(NSString *cityName);

@end
