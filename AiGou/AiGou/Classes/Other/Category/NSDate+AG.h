//
//  AGDate+AG.h
//  AiGou
//
//  Created by rimi on 14/12/25.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (AG)
+ (NSDateComponents *)compareFrom:(NSDate *)from to:(NSDate *)to;

- (NSDateComponents *)compare:(NSDate *)other;
@end
