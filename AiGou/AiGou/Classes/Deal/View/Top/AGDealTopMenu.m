//
//  AGDealTopMenu.m
//  AiGou
//
//  Created by rimi on 14/12/26.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGDealTopMenu.h"
#import "AGDealTopMenuItem.h"
#import "AGMetaDataTool.h"
#import "Defines.h"
#import "AGOrder.h"
#import "AGCategoryMenu.h"
#import "AGDistrictMenu.h"
#import "AGOrderMenu.h"

@interface AGDealTopMenu ()
{
    AGDealTopMenuItem *_selectedItem;
    
    AGCategoryMenu *_cMenu; // 分类菜单
    AGDistrictMenu *_dMenu; // 区域菜单
    AGOrderMenu *_oMenu; // 排序菜单

    AGDealBottomMenu *_showingMenu; // 正在展示的底部菜单
    
    AGDealTopMenuItem *_cItem;
    AGDealTopMenuItem *_dItem;
    AGDealTopMenuItem *_oItem;
}
@end

@implementation AGDealTopMenu


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.全部分类
        _cItem = [self addMenuItem:kAllCategory index:0];
        
        // 2.全部商区
        _dItem = [self addMenuItem:kAllDistrict index:1];

        // 3.默认排序
        _oItem = [self addMenuItem:kDefaultSort index:2];

        // 4.监听通知
        kAddAllNotes(dataChange)
    }
    return self;
}

- (void)dataChange
{
    _selectedItem.selected = NO;
    _selectedItem = nil;
    
    // 1.分类按钮
    NSString *c = [AGMetaDataTool sharedAGMetaDataTool].currentCategory;
    if (c) {
        _cItem.title = c;
    }
    
    // 2.商区按钮
    NSString *d = [AGMetaDataTool sharedAGMetaDataTool].currentDistrict;
    if (d) {
        _dItem.title = d;
    }
    
    // 3.排序按钮
    NSString *o = [AGMetaDataTool sharedAGMetaDataTool].currentOrder.name;
    if (o) {
        _oItem.title = o;
    }
    
    // 4.隐藏底部菜单
    [_showingMenu hide];
    _showingMenu = nil;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 添加一个菜单项
- (AGDealTopMenuItem *)addMenuItem:(NSString *)title index:(int)index
{
    AGDealTopMenuItem *item = [[AGDealTopMenuItem alloc] init];
    item.title = title;
    item.tag = index;
    item.frame = CGRectMake(kTopMenuItemW * index, 0, 0, 0);
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:item];
    return item;
}

#pragma mark 监听顶部item的点击
// _selectedItem -》 默认排序
// item -》默认排序
- (void)itemClick:(AGDealTopMenuItem *)item
{
    // 没有选择城市，不允许点击顶部菜单
    if ([AGMetaDataTool sharedAGMetaDataTool].currentCity == nil) return;
    // 1.控制选中状态
    _selectedItem.selected = NO;
    if (_selectedItem == item) {
        _selectedItem = nil;
        
        // 隐藏底部菜单
        [self hideBottomMenu];
    } else {
        item.selected = YES;
        _selectedItem = item;
        // 显示底部菜单
        [self showBottomMenu:item];
    }
}

#pragma mark 隐藏底部菜单
- (void)hideBottomMenu
{
    [_showingMenu hide];
    _showingMenu = nil;
}

#pragma mark 显示底部菜单
- (void)showBottomMenu:(AGDealTopMenuItem *)item
{
    // 是否需要执行动画（没有正在展示的菜单时，就需要执行动画）
    BOOL animted = _showingMenu == nil;
        // 移除当前正在显示的菜单
        [_showingMenu removeFromSuperview];
        // 显示底部菜单
        if (item.tag == 0) {// 分类
            if (_cMenu == nil) {
                _cMenu = [[AGCategoryMenu alloc] init];
            }
            _showingMenu = _cMenu;
        } else if (item.tag == 1) {//区域
            if (_dMenu == nil) {
                _dMenu = [[AGDistrictMenu alloc] init];
            }
            _showingMenu = _dMenu;
        } else { // 排序
            if (_oMenu == nil) {
                _oMenu = [[AGOrderMenu alloc] init];
            }
            _showingMenu = _oMenu;
        }
    // 设置frame
//    _showingMenu.frame = _contentView.bounds;
    _showingMenu.frame = CGRectMake(0, kTopMenuItemH, _contentView.bounds.size.width, _contentView.bounds.size.height);
    // 设置block回调
    __unsafe_unretained AGDealTopMenu * menu = self;
    _showingMenu.hideBlock = ^{
        // 1.取消选中当前的item
        menu->_selectedItem.selected = NO;
        menu->_selectedItem = nil;
        
        // 2.清空正在显示的菜单
        menu->_showingMenu = nil;
    };
    // 添加即将要显示的菜单
    [_contentView addSubview:_showingMenu];
    // 执行菜单出现的动画
    if (animted) {
        [_showingMenu show];
    }
}

- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(3 * kTopMenuItemW, kTopMenuItemH);
    [super setFrame:frame];
}

@end
