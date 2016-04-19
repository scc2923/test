//
//  AGTextView.m
//  AiGou
//
//  Created by rimi on 14/12/29.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGTextView.h"

@interface AGTextView () <UITextFieldDelegate>

@end

@implementation AGTextView

// 对一些UIview的封装（UIButton  UItextField   UIView）
- (instancetype)initWithFrame:(CGRect)frame number:(int )styape
{
    self = [super initWithFrame:frame];
    if (self) {
        if (styape == 1) {
            self.userInteractionEnabled = YES;
            _textField           = [[UITextField alloc]initWithFrame:CGRectMake(55, 10, self.frame.size.width - 60, self.frame.size.height/2)];
            _titleLable          = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
            _TextView            = [[UIView alloc]initWithFrame:CGRectMake(40, _textField.frame.size.height + 15, self.frame.size.width - 50,1)];
            _TextView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.2];
            _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            [_textField addTarget:self action:@selector(touche) forControlEvents:UIControlEventEditingChanged];
            _TextView.tag = 100;
            [self addSubview:_titleLable];
            [self   addSubview:_TextView];
            [self  addSubview:_textField];
        }else if(styape == 2){
            _OtherButton          = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            _OtherButton.layer.cornerRadius = 5;
            [self addSubview:_OtherButton];
            
       
            
        }
        
    }
    return self;
}
- (void)touche
{
    if (_textField.text.length == 0) {
        _TextView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.2];
    }else{
        _TextView.backgroundColor = [UIColor colorWithRed:22.0f/255.0f green:190.0f/255.0f blue:168.0f/255.0f alpha:0.5];
    }
}
//重新设置的弹框
+ (UIView*)AleaViewName:(NSString *)nameString cgFrame:(CGRect)tframe
{
    UIWindow * window    = [[[UIApplication sharedApplication]delegate]window];
    AGTextView * view      = [[AGTextView alloc] initWithFrame:CGRectMake(window.center.x - tframe.size.width/2, window.center.y + 200, tframe.size.width, tframe.size.height)];
    view.tag             = 100;
    [window addSubview:view];
    view.layer.cornerRadius = 8;
    UILabel * lable      = [[UILabel alloc]  initWithFrame:view.bounds];
    [view addSubview:lable];
    lable.text           = nameString;
    lable.font = [UIFont systemFontOfSize:13];
    lable.textColor      = [UIColor whiteColor];
    lable.textAlignment  = NSTextAlignmentCenter;
    view.backgroundColor = [UIColor colorWithRed:13.0f/255.0f green:75.0f/255.0f blue:31.0f/255.0f alpha:0.5];
    [view performSelector:@selector(removeView) withObject:nil afterDelay:2];
    return view;
}
- (void)removeView
{
    [self removeFromSuperview];//将弹框移除
}

@end
