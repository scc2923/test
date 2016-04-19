//
//  AGData.h
//  AiGou
//
//  Created by rimi on 14/12/29.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGData : NSObject

@property (nonatomic, retain)NSArray * countNameArray;//账号 密码
@property (nonatomic, retain)NSArray * nameArray;
@property (nonatomic, retain)NSArray * shareNameArray;
@property (nonatomic, retain)NSArray * ImageArray;//分享的图片
@property (nonatomic, strong)NSArray * enterNameArray;//登录
@property (nonatomic, strong)NSArray * RegisterArray;//免费注册,无账号快捷登录
@property (nonatomic, strong)NSArray * registerFreeArray;//免费注册
@property (nonatomic, strong)NSArray * registerArray;//注册
@property (nonatomic, retain)NSArray * otherNameArray;//关于注册弹出框的提示
@property (nonatomic, retain)NSArray * OTHERenterArray;//登录弹出框的提示
- (void)requstData:(NSArray *)Farray succed:(void(^)(id))compleit;

@end
