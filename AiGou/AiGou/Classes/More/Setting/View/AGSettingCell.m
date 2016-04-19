//
//  AGSettingCell.m
//  AiGou
//
//  Created by rimi on 14/12/31.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGSettingCell.h"
#import "AGSettingItem.h"
#import "AGSettingSwitchItem.h"
#import "AGSettingArrowItem.h"
#import "AGSettingLabelItem.h"
#import "Defines.h"

@interface AGSettingCell ()
{
    UIImageView *_arrow;
    UISwitch *_switch;
    UILabel *_label;
    
    UIView *_divider;
}
@end

@implementation AGSettingCell


+ (instancetype)settingCellWithTableView:(UITableView *)tableView
{
    // 0.用static修饰的局部变量，只会初始化一次
    static NSString *ID = @"Cell";
    
    // 1.拿到一个标识先去缓存池中查找对应的Cell
    AGSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 2.如果缓存池中没有，才需要传入一个标识创建新的Cell
    if (cell == nil) {
        cell = [[AGSettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.设置背景
        [self setupBg];
        
        // 2.设置子控件属性
        [self setupSubviews];
        
        // 3.添加分隔线
        [self setupDivider];
    }
    return self;
}

#pragma mark 设置背景
- (void)setupBg
{
    // 1.默认
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = [UIColor whiteColor];
    self.backgroundView = bg;
    
    // 2.选中
    UIView *selectedBg = [[UIView alloc] init];
    selectedBg.backgroundColor = AGColor(237, 233, 218, 1);
    self.selectedBackgroundView = selectedBg;
}

#pragma mark 设置子控件属性
- (void)setupSubviews
{
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.font = [UIFont systemFontOfSize:16];
    
    self.detailTextLabel.backgroundColor = [UIColor clearColor];
    self.detailTextLabel.font = [UIFont systemFontOfSize:14];
}

#pragma mark 添加分隔线
- (void)setupDivider
{
    UIView *divider = [[UIView alloc] init];
    divider.backgroundColor = kGlobalBg;
    // 不能在这里设置分隔线的x值（原因：cell没有具体的数据，里面的label就不知道最终的位置）
    //    divider.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 1.5);
    [self.contentView addSubview:divider];
    _divider = divider;
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    _divider.hidden = indexPath.row == 0;
}

#pragma mark 当cell的宽高改变了就会调用
// 需要调节cell内部子控件的frame，在layoutSubviews方法最可靠\最有效
- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    CGFloat x = self.textLabel.frame.origin.x;
//    _divider.frame = CGRectMake(x, 43, [UIScreen mainScreen].bounds.size.width - x - 20, 1.0);
    
    // 0.设置分隔线的位置
    _divider.frame = CGRectMake(10, 0, kMainScreenW - 40, 1.0);
    
     if (IOS6) return;
    
    // 1.cell位置及宽度
    CGRect cellF = self.frame;
    cellF.origin.x = 10;
    cellF.size.width = kMainScreenW - 20;
    self.frame = cellF;
    
    // 2.右边控件的frame
//    CGRect accessF = self.accessoryView.frame;
//    accessF.origin.x = cellF.size.width - accessF.size.width - 10;
//    self.accessoryView.frame = accessF;
}

- (void)setItem:(AGSettingItem *)item
{
    _item = item;
    
    // 设置数据
    self.imageView.image = [UIImage imageNamed:item.icon];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subtitle;
    
    if ([item isKindOfClass:[AGSettingArrowItem class]]) {
        [self settingArrow];
    } else if ([item isKindOfClass:[AGSettingSwitchItem class]]) {
        [self settingSwitch];
    } else if ([item isKindOfClass:[AGSettingLabelItem class]]) {
        [self settingLabel];
    } else {
        // 什么也没有，清空右边显示的view
        self.accessoryView = nil;
        // 用默认的选中样式
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
}

#pragma mark 设置右边的文本标签
- (void)settingLabel
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.bounds = CGRectMake(0, 0, 100, self.frame.size.height);
        _label.textAlignment = NSTextAlignmentRight;
        _label.textColor = AGColor(173, 69, 14, 1);
//        _label.text = [NSString stringWithFormat:@"%d", arc4random_uniform(1000000)];
        _label.font = [UIFont systemFontOfSize:13];
    }
    
    // 设置右边label的值
    AGSettingLabelItem *labelItem = (AGSettingLabelItem *)_item;
    _label.text = labelItem.text;
    
    // 右边显示label
    self.accessoryView = _label;
    // 禁止选中
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
}

#pragma mark 设置右边的开关
- (void)settingSwitch
{
    if (_switch == nil) {
        _switch = [[UISwitch alloc] init];
        [_switch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    }
    // 设置开关的状态
    AGSettingSwitchItem *switchItem = (AGSettingSwitchItem *)_item;
    _switch.on = !switchItem.off;
    
    // 右边显示开关
    self.accessoryView = _switch;
    // 禁止选中
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark 开关状态改变
- (void)switchChange:item
{
    AGSettingSwitchItem *switchItem = (AGSettingSwitchItem *)_item;
    switchItem.off = !_switch.on;
}

#pragma mark 设置右边的箭头
- (void)settingArrow
{
    if (_arrow == nil) {
        _arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellArrow"]];
    }
    
    // 右边显示箭头
    self.accessoryView = _arrow;
    // 用默认的选中样式
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
}

@end
