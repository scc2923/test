//
//  AGSubtitlesView.h
//  AiGou
//
//  Created by rimi on 14/12/27.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AGSubtitlesView;

@protocol AGSubtitlesViewDelegate <NSObject>

@optional
// 传递点击的按钮文字
- (void)subtitlesView:(AGSubtitlesView *)subtitlesView titleClick:(NSString *)title;
// 得到判断当前按钮是否选中的文字(比如分类菜单，就返回当前选中的分类名称；区域菜单，就返回当前选中的区域名称)
- (NSString *)subtitlesViewGetCurrentTitle:(AGSubtitlesView *)subtitlesView;
@end

@interface AGSubtitlesView : UIImageView

@property (nonatomic, copy) NSString *mainTitle; // 主标题
@property (nonatomic, strong)NSArray * titles;// 所有子标题文字

@property (nonatomic, weak) id<AGSubtitlesViewDelegate> delegate;

//@property (nonatomic, copy)void (^setTitleBlock)(NSString *title);
//@property (nonatomic, copy) NSString *(^getTitleBlock)();

// 通过动画显示出来
- (void)show;
// 通过动画隐藏
- (void)hide;

@end
