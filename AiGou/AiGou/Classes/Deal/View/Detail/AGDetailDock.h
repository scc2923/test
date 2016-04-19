//
//  AGDetailDock.h
//  AiGou
//
//  Created by rimi on 14-12-30.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import <UIKit/UIKit.h>


@class AGDetailDockItem, AGDetailDock;

// 协议
@protocol AGDetailDockDelegate <NSObject>

@optional
- (void)detailDock:(AGDetailDock *)detailDock btnClickFrom:(NSInteger)from to:(NSInteger)to;
@end

// TGDetailDock类
@interface AGDetailDock : UIView

@property (weak, nonatomic) IBOutlet AGDetailDockItem *infoBtn;
@property (weak, nonatomic) IBOutlet AGDetailDockItem *merchantBtn;

@property (nonatomic, weak) id <AGDetailDockDelegate> delegate;

+ (id)detailDock;
- (IBAction)btnClick:(UIButton *)sender;

@end

// TGDetailDockItem类
@interface AGDetailDockItem : UIButton

@end
