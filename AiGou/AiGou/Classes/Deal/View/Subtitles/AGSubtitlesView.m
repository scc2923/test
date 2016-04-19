//
//  AGSubtitlesView.m
//  AiGou
//
//  Created by rimi on 14/12/27.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGSubtitlesView.h"
#import "UIImage+AG.h"
#import "Defines.h"
#import "AGMetaDataTool.h"

@interface SubtitleBtn : UIButton
@end

@implementation SubtitleBtn
- (void)drawRect:(CGRect)rect
{
    if (self.selected) {
        CGRect frame = self.titleLabel.frame;
        frame.origin.x -= 5;
        frame.size.width += 10;
        frame.origin.y -= 5;
        frame.size.height += 10;
        [[UIImage resizedImage:@"slider_filter_bg_active.png"] drawInRect:frame];
    }
}
@end

@interface AGSubtitlesView ()
{
    UIButton *_selectedBtn;
}
@end

@implementation AGSubtitlesView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.image = [UIImage resizedImage:@"bg_subfilter_other.png"];
        // 裁剪掉超出父控件范围内的子控件(超出父控件范围内的子控件不显示)
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
    }
    return self;
}

#pragma mark 监听小标题（按钮）点击
- (void)titleClick:(UIButton *)btn
{
    // 1.控制按钮状态
    _selectedBtn.selected = NO;
    btn.selected = YES;
    _selectedBtn = btn;
    
    // 2.设置当前选中的分类文字
//    if (_setTitleBlock) {
//        _setTitleBlock([btn titleForState:UIControlStateNormal]);
//    }
    if ([_delegate respondsToSelector:@selector(subtitlesView:titleClick:)]) {
        NSString *title = [btn titleForState:UIControlStateNormal];
        if ([title isEqualToString:kAll]) { // 全部 --> 大标题
            title = _mainTitle;
        }
        [_delegate subtitlesView:self titleClick:title];
    }
//    MyLog(@"%@ - %@", [AGMetaDataTool sharedAGMetaDataTool].currentCategory, [AGMetaDataTool sharedAGMetaDataTool].currentDistrict);
}

- (void)setTitles:(NSArray *)titles
{
//    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:kAll];
    [array addObjectsFromArray:titles];
    _titles = array;
    
    NSInteger count = _titles.count;
    // 设置按钮文字
    for (int i = 0; i < count; i++) {
        // 1.取出i位置对应的按钮
        UIButton * btn = nil;
        if (i >= self.subviews.count) {// 2.按钮个数不够
            btn = [SubtitleBtn buttonWithType:UIButtonTypeCustom];
//            btn = [[UIButton alloc] init];
            [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitleColor:kSubTintColorN forState:UIControlStateNormal];
//             [btn setBackgroundImage:[UIImage resizedImage:@"slider_filter_bg_active.png"] forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:kTopFont];
            btn.bounds = CGRectMake(0, 0, kTitleW, kTitleH);
            
            [self addSubview:btn];
        } else {
            btn = self.subviews[i];
        }
        // 2.设置按钮文字
        btn.hidden = NO;
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        // 根据按钮文字来决定要不要选中(block)
//        if (_getTitleBlock) {
//             btn.selected = [titles[i] isEqualToString:_getTitleBlock()];
//        } else {
//             btn.selected = NO;
//        }
        // 根据按钮文字来决定要不要选中
        if ([_delegate respondsToSelector:@selector(subtitlesViewGetCurrentTitle:)]) {
            NSString *current = [_delegate subtitlesViewGetCurrentTitle:self];
            // 选中了主标题，选中第0个按钮（“全部”）
            if ([current isEqualToString:_mainTitle] && i == 0) {
                btn.selected = YES;
                _selectedBtn = btn;
            } else {
                btn.selected = [_titles[i] isEqualToString:current];
                if (btn.selected) {
                    _selectedBtn = btn;
                }
            }
            
        } else {
            btn.selected = NO;
        }
    }
    // 隐藏多余的按钮
    for (NSInteger i = count; i < self.subviews.count; i++) {
        UIButton * btn = self.subviews[i];
        btn.hidden = YES;
    }
     [self layoutSubviews];
}

// 控件本身的宽高发生改变的时候就会调用
- (void)layoutSubviews
{
    // 一定要调用supeer
    [super layoutSubviews];
    NSInteger columns = kMainScreenW / kTitleW;
    for (int i = 0; i < _titles.count; i++) {
        UIButton * btn = self.subviews[i];
        // 3.设置位置
        CGFloat x = i % columns * kTitleW;
        CGFloat y = i / columns * kTitleH;
        btn.frame = CGRectMake(x, y, kTitleW, kTitleH);
    }
    
    NSInteger rows = (_titles.count + columns - 1) / columns;
    CGRect frame = self.frame;
    frame.size.height = rows * kTitleH;
    self.frame = frame;
}

#pragma mark 显示
- (void)show
{
    [self layoutSubviews];
    self.transform = CGAffineTransformMakeTranslation(0, -self.frame.size.height);
    self.alpha = 0;
    [UIView animateWithDuration:kDuration animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}

- (void)hide
{
    [UIView animateWithDuration:kDuration animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -self.frame.size.height);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        CGRect f = self.frame;
        f.size.height = 0;
        self.frame = f;
        
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}

@end
