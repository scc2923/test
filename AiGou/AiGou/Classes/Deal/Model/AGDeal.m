//
//  AGDeal.m
//  AiGou
//
//  Created by rimi on 14/12/25.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGDeal.h"
#import "NSString+AG.h"
#import "AGRestriction.h"
#import "NSObject+Value.h"
#import "AGBusiness.h"

@implementation AGDeal

- (void)setList_price:(double)list_price
{
    _list_price = list_price;
    
    _list_price_text = [NSString stringWithDouble:list_price fractionCount:2];
}

- (void)setCurrent_price:(double)current_price
{
    _current_price = current_price;
    
    _current_price_text = [NSString stringWithDouble:current_price fractionCount:2];
}

- (void)setRestrictions:(AGRestriction *)restrictions
{
    if ([restrictions isKindOfClass:[NSDictionary class]]) {
        _restrictions = [[AGRestriction alloc] init];
        [_restrictions setValues:(NSDictionary *)restrictions];
    } else {
        _restrictions = restrictions;
    }
}

- (void)setBusinesses:(NSArray *)businesses
{
    NSDictionary *obj = [businesses lastObject];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in businesses) {
            AGBusiness *b = [[AGBusiness alloc] init];
            [b setValues:dict];
            [temp addObject:b];
        }
        
        _businesses = temp;
        
    } else {
        _businesses = businesses;
    }
}

//  重写isEqual 防止删除不了添加的收藏
- (BOOL)isEqual:(AGDeal *)other
{
    return [other.deal_id isEqualToString:_deal_id];
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_title forKey:@"_title"];
    [encoder encodeDouble:_list_price forKey:@"_list_price"];
    
    [encoder encodeObject:_purchase_deadline forKey:@"_purchase_deadline"];
    [encoder encodeObject:_deal_id forKey:@"_deal_id"];
    [encoder encodeObject:_image_url forKey:@"_image_url"];
    [encoder encodeObject:_desc forKey:@"_desc"];
    [encoder encodeDouble:_current_price forKey:@"_current_price"];
    [encoder encodeInt:_purchase_count forKey:@"_purchase_count"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.title = [decoder decodeObjectForKey:@"_title"];
        self.purchase_deadline = [decoder decodeObjectForKey:@"_purchase_deadline"];
        self.deal_id = [decoder decodeObjectForKey:@"_deal_id"];
        self.image_url = [decoder decodeObjectForKey:@"_image_url"];
        self.desc = [decoder decodeObjectForKey:@"_desc"];
        self.current_price = [decoder decodeDoubleForKey:@"_current_price"];
        self.list_price = [decoder decodeDoubleForKey:@"_list_price"];
        self.purchase_count = [decoder decodeIntForKey:@"_purchase_count"];
    }
    return self;
}


@end
