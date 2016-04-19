//
//  AGCategoryMenu.m
//  AiGou
//
//  Created by rimi on 14/12/26.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGCategoryMenu.h"
#import "AGMetaDataTool.h"
#import "AGCategoryMenuItem.h"
#import "AGCategory.h"
#import "AGSubtitlesView.h"
#import "Defines.h"

@interface AGCategoryMenu ()

@end

@implementation AGCategoryMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray * categories = [AGMetaDataTool sharedAGMetaDataTool].totalCategories;
        // 1.往UIScrollView添加内容
        NSInteger count = categories.count;
        for (int i = 0; i < count; i++) {
            // 创建item
            AGCategoryMenuItem * item = [[AGCategoryMenuItem alloc] init];
            [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            item.category = categories[i];
            item.frame = CGRectMake(i * kBottomMenuItemW, 0, 0, 0);
            [_scrollView addSubview:item];
            
            // 默认选中第0个item
            if (i == 0) {
                item.selected = YES;
                _selectedItem = item;
            }
        }
        _scrollView.contentSize = CGSizeMake(count * kBottomMenuItemW, 0);
    }
    return self;
}

//- (void)settingSubtitlesView
//{
//    _subtitlesView.setTitleBlock = ^(NSString *title){
//        [AGMetaDataTool sharedAGMetaDataTool].currentCategory = title;
//    };
//    _subtitlesView.getTitleBlock = ^{
//        return [AGMetaDataTool sharedAGMetaDataTool].currentCategory;
//    };
//}

- (void)subtitlesView:(AGSubtitlesView *)subtitlesView titleClick:(NSString *)title
{
    [AGMetaDataTool sharedAGMetaDataTool].currentCategory = title;
}

- (NSString *)subtitlesViewGetCurrentTitle:(AGSubtitlesView *)subtitlesView
{
    return [AGMetaDataTool sharedAGMetaDataTool].currentCategory;
}

@end
