//
//  AGDetailDock.m
//  AiGou
//
//  Created by rimi on 14-12-30.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGDetailDock.h"
@interface AGDetailDock()
{
    UIButton *_selectedBtn;
}
@end

@implementation AGDetailDock

- (void)setFrame:(CGRect)frame
{
    frame.size = self.frame.size;
    [super setFrame:frame];
}

+ (id)detailDock
{
    return [[NSBundle mainBundle] loadNibNamed:@"AGDetailDock" owner:nil options:nil][0];
}

- (void)awakeFromNib
{
    [self btnClick:_infoBtn];
}

- (IBAction)btnClick:(UIButton *)sender {
    // 0.通知代理
    if ([_delegate respondsToSelector:@selector(detailDock:btnClickFrom:to:)]) {
        [_delegate detailDock:self btnClickFrom:_selectedBtn.tag to:sender.tag];
    }
    
    // 1.控制按钮状态
    _selectedBtn.enabled = YES;
    sender.enabled = NO;
    _selectedBtn = sender;
    
    // 2.添加被点击的按钮在最上面
    if (sender == _infoBtn) { // 点击了第1个按钮
        [self insertSubview:_merchantBtn atIndex:0];
    } else if (sender == _merchantBtn) { // 点击了第3个按钮
        [self insertSubview:_infoBtn atIndex:0];
    }
    [self bringSubviewToFront:sender];
}
@end


@implementation AGDetailDockItem

- (void)setHighlighted:(BOOL)highlighted {}

@end
