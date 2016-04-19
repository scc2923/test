//
//  AGDistrictMenu.m
//  AiGou
//
//  Created by rimi on 14/12/27.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGDistrictMenu.h"
#import "AGDistrictMenuItem.h"
#import "AGMetaDataTool.h"
#import "AGCity.h"
#import "Defines.h"
#import "AGDistrict.h"
#import "AGSubtitlesView.h"

@interface AGDistrictMenu()
{
    NSMutableArray *_menuItems;
}
@end

@implementation AGDistrictMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _menuItems = [NSMutableArray array];
        
        [self cityChange];
        
        // 监听城市改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChange) name:kCityChangeNote object:nil];
    }
    return self;
}

- (void)cityChange
{
    // 1.获取当前选中的城市
    AGCity *city = [AGMetaDataTool sharedAGMetaDataTool].currentCity;
    
    // 2.当前城市的所有区域
    NSMutableArray *districts = [NSMutableArray array];
    // 2.1.全部商区
    AGDistrict *all = [[AGDistrict alloc] init];
    all.name = kAllDistrict;
    [districts addObject:all];
    // 2.2.其他商区
    [districts addObjectsFromArray:city.districts];
    
    // 3.遍历所有的商区
    NSInteger count = districts.count;
    for (int i = 0; i<count; i++) {
        AGDistrictMenuItem *item = nil;
        if (i >= _menuItems.count) { // 不够
            item = [[AGDistrictMenuItem alloc] init];
            [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            [_menuItems addObject:item];
            [_scrollView addSubview:item];
        } else {
            item = _menuItems[i];
        }
        
        item.hidden = NO;
        item.district = districts[i];
        item.frame = CGRectMake(i * kBottomMenuItemW, 0, 0, 0);
        
        // 默认选中第0个item
        if (i == 0) {
            item.selected = YES;
            _selectedItem = item;
        } else {
            item.selected = NO;
        }
    }
    
    // 4.隐藏多余的item
    for (NSInteger i = count; i < _menuItems.count; i++) {
        AGDistrictMenuItem *item = _scrollView.subviews[i];
        item.hidden = YES;
    }
    
    // 5.设置scrollView的内容尺寸
    _scrollView.contentSize = CGSizeMake(count * kBottomMenuItemW, 0);
    
    // 6.隐藏子标题
    [_subtitlesView hide];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//- (void)settingSubtitlesView
//{
//    //设置选中区域的block
//    _subtitlesView.setTitleBlock = ^(NSString *title){
//        [AGMetaDataTool sharedAGMetaDataTool].currentDistrict = title;
//    };
//    _subtitlesView.getTitleBlock = ^{
//        return [AGMetaDataTool sharedAGMetaDataTool].currentDistrict;
//    };
//}

- (void)subtitlesView:(AGSubtitlesView *)subtitlesView titleClick:(NSString *)title
{
    [AGMetaDataTool sharedAGMetaDataTool].currentDistrict = title;
}

- (NSString *)subtitlesViewGetCurrentTitle:(AGSubtitlesView *)subtitlesView
{
    return [AGMetaDataTool sharedAGMetaDataTool].currentDistrict;
}

@end
