//
//  AGData.m
//  AiGou
//
//  Created by rimi on 14/12/29.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGData.h"
#import <BmobSDK/Bmob.h>

@implementation AGData

- (instancetype)init
{
    self = [super init];
    if (self) {
        //封装的一些杂数据
        _nameArray         = [NSArray arrayWithObjects:@"分        享",@"关于我们",@"意见反馈",nil];
        _shareNameArray    = [NSArray arrayWithObjects:@"腾信分享",@"新浪分享",@"QQ空间", nil];
        _ImageArray        = [NSArray arrayWithObjects:@"5gkQ.png",@"xl.jpg",@"qq.jpg", nil];
        _enterNameArray    = [NSArray arrayWithObjects:@"手机/邮箱/用户名",@"密码", nil];
        _RegisterArray     = [NSArray arrayWithObjects:@"免费注册",@"无账号快捷登录",nil];
        _registerFreeArray = [NSArray arrayWithObjects:@"请输入您注册的用户名",@"请输入6-12位密码",@"请重新输入密码",nil];
        _countNameArray    = [NSArray arrayWithObjects:@"账号:",@"密码:", nil];
        _registerArray     = [NSArray arrayWithObjects:@"账号:",@"密码:",@"密码:",nil];
        _otherNameArray    = [NSArray arrayWithObjects:@"输入的用户名为空",@"为了账号安全请重新输入6-12位密码",@"两个密码不一致",@"请输入6-12密码",@"你注册的账号已经存在",@"注册成功", nil];
        _OTHERenterArray    = [NSArray arrayWithObjects:@"输入的账号为空",@"输入的密码为空",@"登录成功",@"输入的密码有误",@"输入的账号有误",nil];
    }
    return self;
}

// Bmob请求数据
- (void)requstData:(NSArray *)Farray succed:(void(^)(id))compleit
{
    [Bmob registerWithAppKey:@"bb3685bd5afc53864110fa3336adaf3c"];
    BmobObject * zhoumineng = [[BmobObject alloc]initWithClassName:@"EnterAllData"];
    BmobQuery * query = [[BmobQuery alloc]initWithClassName:@"EnterAllData"];
    query.limit = HUGE_VAL;
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            NSLog(@"数据失败");
        }else
        {
            compleit (array);
            /**
             判断Array 是否为空
             若为空这不进行下操作
             */
            if (Farray.count !=0) {// 判断Farray 不为空才进行
                if (array.count == 0) {
                    NSLog(@"nill");
                    [zhoumineng  setObject:Farray[1] forKey:@"Enterserect"];// 添加密码
                    [zhoumineng setObject:Farray[0] forKey:@"EnterAccount"];// 添加账号
                    [zhoumineng   saveInBackground];
                    [zhoumineng updateInBackground];
                }else{
                    //static int count = 0;
                    for (int i = 0; i < array.count; i ++) {
                        //if (count == 0) {
                        //判断账号是否有相同的存在
                        if (![Farray[0] isEqualToString:[array[i] objectForKey:@"EnterAccount"]]) {
                            if(i == array.count - 1){
                                NSLog(@"%@",Farray[0]);
                                NSLog(@"%@",[array[i] objectForKey:@"EnterAccount"]);
                                NSLog(@"%lu",(unsigned long)array.count);
                                [zhoumineng setObject:Farray[1]  forKey:@"Enterserect"];// 添加密码
                                [zhoumineng setObject:Farray[0] forKey:@"EnterAccount"];// 添加账号
                                [zhoumineng saveInBackground];
                                [zhoumineng  updateInBackground];
                            }
                        } else {
                            break;
                        }
                    }
                }
            }
        }
    }];
}

@end
