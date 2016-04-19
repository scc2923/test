//
//  AGCenterLineLabel.m
//  AiGou
//
//  Created by rimi on 14-12-30.
//  Copyright (c) 2014年 AG. All rights reserved.
//

#import "AGCenterLineLabel.h"

@implementation AGCenterLineLabel

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // 1.获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.设置颜色
    [self.textColor setStroke];
    
    // 3.画线
    CGFloat y = rect.size.height * 0.5;
    CGContextMoveToPoint(ctx, 0, y);
    
//    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
//    CGSize endx = [self.text sizeWithAttributes:attribute];
//    CGSize size = [self.text boundingRectWithSize:CGSizeMake(0, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    CGFloat endX = [self.text sizeWithFont:self.font].width;
//    CGFloat endX = size.width;

    CGContextAddLineToPoint(ctx, endX, y);
    // 4.渲染
    CGContextStrokePath(ctx);
}
@end
