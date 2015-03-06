//
//  ESArcProgressView.m
//  CircleDraw
//
//  Created by Bas van Kuijck on 04-03-15.
//  Copyright (c) 2015 e-sites. All rights reserved.
//

#import "ESArcProgressView.h"
#import "ESMultipleArcProgressView.h"

@implementation ESArcProgressView {
    UIColor *_customBackgroundColor;
}
@synthesize color=_color,showShadow=_showShadow,showCenterDot,progress=_percentage,lineWidth=_lineWidth,multipleArcProgressView,dotColor=_dotColor,centerDotStyle=_centerDotStyle,text=_text;

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self _init];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self _init];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self _init];
    }
    return self;
}

- (void)_init
{
    [self setOpaque:NO];
    _showShadow = YES;
    _centerDotStyle = ESArcProgressCenterDotStyleBeginAndEnd;
    _lineWidth = 20;
    _color = [UIColor greenColor];
    _dotColor = [UIColor whiteColor];
}

- (void)layoutSubviews
{
    [self setOpaque:NO];
    [super setBackgroundColor:[UIColor clearColor]];
}

#pragma mark - Properties
// ____________________________________________________________________________________________________________________

- (void)setColor:(UIColor *)aColor
{
    _color = aColor;
    [self setNeedsDisplay];
}

- (void)setBackgroundColor:(UIColor *)aBackgroundColor
{
    _customBackgroundColor = aBackgroundColor;
    [self setNeedsDisplay];
}

- (void)setShowShadow:(BOOL)aShowShadow
{
    _showShadow = aShowShadow;
    [self setNeedsDisplay];
}

- (void)setProgress:(CGFloat)aProgress
{
    _percentage = fminf(1.0f, fmaxf(0.0f, aProgress));
    [self setNeedsDisplay];
}

- (void)setLineWidth:(CGFloat)aLineWidth
{
    _lineWidth = fmaxf(1, aLineWidth);
    [self setNeedsDisplay];
}

- (void)setCenterDotStyle:(ESArcProgressCenterDotStyle)aCenterDotStyle
{
    _centerDotStyle = aCenterDotStyle;
    [self setNeedsDisplay];
}

- (void)setDotColor:(UIColor *)aDotColor
{
    _dotColor = aDotColor;
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)aText
{
    _text = [aText copy];
    [self setNeedsDisplay];
}

#pragma mark - UIView
// ____________________________________________________________________________________________________________________

- (void)removeFromSuperview
{
    if (self.multipleArcProgressView == nil) {
        [super removeFromSuperview];
    } else {
        [self.multipleArcProgressView removeArcProgressView:self];
    }
}

#pragma mark - Drawing
// ____________________________________________________________________________________________________________________

- (void)drawRect:(CGRect)rect
{
    // ------------------------------------------------
    // Configuration values
    
    const CGFloat perc = self.progress;
    const CGFloat lineRadius = self.lineWidth / 2;
    const CGFloat midDotRadius = fmaxf(1.0f, lineRadius * 0.3);
    
    // ------------------------------------------------
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGPoint center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    CGFloat delta = (360 * perc) * M_PI / 180;
    CGFloat innerRadius = fminf(center.x, center.y) - lineRadius;
    
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineWidth(ctx, lineRadius * 2);
    
    // Draw background
    UIColor *bgColor = _customBackgroundColor;
    if (bgColor == nil) {
        bgColor = [self.color colorWithAlphaComponent:.5];
    }
    CGContextSetStrokeColorWithColor(ctx, bgColor.CGColor);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRelativeArc(path, NULL, center.x, center.y, innerRadius, -(M_PI / 2), M_PI * 2);
    CGContextAddPath(ctx, path);
    CGContextStrokePath(ctx);
    if (perc == 0) {
        return;
    }
    
    CGContextSaveGState(ctx);
    // Draw mask
    path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, nil, rect);
    CGPathAddEllipseInRect(path, nil, CGRectMake(lineRadius * 2, lineRadius * 2, (innerRadius - lineRadius) * 2, (innerRadius - lineRadius) * 2));
    CGContextAddPath(ctx, path);
    CGContextClosePath(ctx);
    CGContextEOClip(ctx);
    
    // Shadow
    if (self.shouldShowShadow) {
        CGContextSetShadowWithColor(ctx, CGSizeZero, lineRadius * 1.5f, [UIColor colorWithWhite:0 alpha:.75].CGColor);
    }
    
    // Draw foreground
    path = CGPathCreateMutable();
    CGContextSetStrokeColorWithColor(ctx, self.color.CGColor);
    CGPathAddRelativeArc(path, NULL, center.x, center.y, innerRadius, -(M_PI / 2), delta);
    CGContextAddPath(ctx, path);
    CGContextStrokePath(ctx);
    CGContextRestoreGState(ctx);
    
    if (self.text.length > 0) {
        NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc] initWithString:self.text];
        [attstr beginEditing];
        NSShadow *shadow = [[NSShadow alloc] init];
        [shadow setShadowBlurRadius:0];
        [shadow setShadowColor:[UIColor blackColor]];
        [shadow setShadowOffset:CGSizeMake(1, 1)];
        
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        [paragraph setAlignment:NSTextAlignmentRight];
        [attstr addAttributes:@{
                                NSFontAttributeName: [UIFont boldSystemFontOfSize:self.lineWidth / 1.2f],
                                NSShadowAttributeName: shadow,
                                NSParagraphStyleAttributeName: paragraph,
                                NSForegroundColorAttributeName: self.color
                                } range:NSMakeRange(0, self.text.length)];
        [attstr endEditing];
        [attstr drawInRect:CGRectMake(0, 0, center.x - 15, self.lineWidth)];
    }
    
    // Draw white begin / end dots
    if (self.centerDotStyle == ESArcProgressCenterDotStyleNone) {
        return;
    }
    
    CGContextSetShadowWithColor(ctx, CGSizeZero, 0, nil);
    CGContextSetLineWidth(ctx, 0);
    CGContextSetFillColorWithColor(ctx, self.dotColor.CGColor);
    
    if (self.centerDotStyle == ESArcProgressCenterDotStyleBeginAndEnd || self.centerDotStyle == ESArcProgressCenterDotStyleBegin) {
        CGContextAddEllipseInRect(ctx, CGRectMake(center.x - midDotRadius, center.y - innerRadius - midDotRadius, midDotRadius * 2, midDotRadius * 2));
    }
    
    if ((self.centerDotStyle == ESArcProgressCenterDotStyleBeginAndEnd && perc < 1.0f) || self.centerDotStyle == ESArcProgressCenterDotStyleEnd) {
        CGFloat w = sinf(delta) * innerRadius;
        CGFloat h = cosf(delta) * innerRadius;
        CGFloat x = center.x + w;
        CGFloat y = center.y - h;
        CGContextAddEllipseInRect(ctx, CGRectMake(x - midDotRadius, y - midDotRadius, midDotRadius * 2, midDotRadius * 2));
    }
    CGContextFillPath(ctx);
}
@end

@implementation UIView (ESMultipleArcProgressViewGenerateUIImage)

- (UIImage *)generateImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end