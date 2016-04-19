//
//  AGTextView.h
//  AiGou
//
//  Created by rimi on 14/12/29.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGTextView : UIView

@property(nonatomic,retain)UILabel    *titleLable;
@property(nonatomic,retain)UITextField *textField;
@property(nonatomic,retain)UIView      *TextView;
@property(nonatomic,strong)UIButton * OtherButton;
- (instancetype)initWithFrame:(CGRect)frame number:(int )styape;
+ (UIView*)AleaViewName:(NSString *)nameString cgFrame:(CGRect)frame;// 重新设置的弹框

@end
