//
//  AGInfoTextView.h
//  AiGou
//
//  Created by rimi on 14-12-30.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGRoundRectView.h"

@interface AGInfoTextView : AGRoundRectView
@property (weak, nonatomic) IBOutlet UIButton *titleView;
@property (weak, nonatomic) IBOutlet UILabel *contentView;

@property (nonatomic, copy) NSString *icon; // 图标
@property (nonatomic, copy) NSString *title; // 标题
@property (nonatomic, copy) NSString *content; // 内容

+ (id)infoTextView;

@end
