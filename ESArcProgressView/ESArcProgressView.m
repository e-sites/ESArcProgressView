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
    AHEasingFunction _easingFunction;
    NSTimer *_animationTimer;
    NSInteger _animationStep;
    ESArcProgressViewUpdateBlock _updateBlock;
}
@synthesize color=_color,showShadow=_showShadow,showCenterDot,progress=_percentage,lineWidth=_lineWidth,multipleArcProgressView,dotColor=_dotColor,centerDotStyle=_centerDotStyle,text=_text,showZeroProgress=_showZeroProgress,centerDotImage=_centerDotImage,colorizeCenterDotImage=_colorizeCenterDotImage;

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
    _colorizeCenterDotImage = YES;
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

- (void)setShowZeroProgress:(BOOL)aShowZeroProgress
{
    _showZeroProgress = aShowZeroProgress;
    [self setNeedsDisplay];
}

- (void)setCenterDotImage:(UIImage *)centerDotImage
{
    _centerDotImage = centerDotImage;
    [self setNeedsDisplay];
}

- (void)setColorizeCenterDotImage:(BOOL)colorizeCenterDotImage
{
    _colorizeCenterDotImage = colorizeCenterDotImage;
    [self setNeedsDisplay];
}

#pragma mark - Animation
// ____________________________________________________________________________________________________________________

- (void)animateTo:(CGFloat)toValue
{
    [self animateTo:toValue withDuration:1];
}

#define kFPS 60.0f

- (void)animateTo:(CGFloat)toValue withDuration:(NSTimeInterval)duration
{
    [self animateTo:toValue withDuration:1.0f withEasingFunction:LinearInterpolation];
}

- (void)animateTo:(CGFloat)toValue withDuration:(NSTimeInterval)duration withEasingFunction:(AHEasingFunction)easingFunction
{
    [self animateTo:toValue withDuration:duration withEasingFunction:easingFunction withUpdateHandler:nil];
}

- (void)animateTo:(CGFloat)toValue withDuration:(NSTimeInterval)duration withEasingFunction:(AHEasingFunction)easingFunction withUpdateHandler:(ESArcProgressViewUpdateBlock)updateHandler
{
    if (duration == 0) {
        [self setProgress:toValue];
        return;
    }
    _updateBlock = [updateHandler copy];
    toValue = fminf(fmaxf(0.0f, toValue), 1.0f);
    _easingFunction = easingFunction;
    [_animationTimer invalidate];
    _animationStep = 0;
    _animationTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f / kFPS target:self selector:@selector(_animationTick:) userInfo:@{
                                                                                                                                     @"from": @(self.progress),
                                                                                                                                     @"to": @(toValue),
                                                                                                                                     @"duration": @(duration)
                                                                                                                                     } repeats:YES];
}

- (void)_animationTick:(NSTimer *)timer
{
    CGFloat fromValue = [timer.userInfo[@"from"] floatValue];
    CGFloat toValue = [timer.userInfo[@"to"] floatValue];
    NSTimeInterval duration = [timer.userInfo[@"duration"] doubleValue];
    
    CGFloat percPercStep = (toValue - fromValue) / (duration * kFPS);
    _animationStep++;

    CGFloat animationPercentage = _animationStep * percPercStep;
    if (animationPercentage >= 1.0f) {
        ESArcProgressViewUpdateBlock handler = _updateBlock;
        [self stopAnimation];
        if (handler != nil) {
            handler(animationPercentage);
            handler = nil;
        }
        return;
    }
    CGFloat p = _easingFunction(animationPercentage);
    
    self.progress = fromValue + ((toValue - fromValue) * p);
    if (_updateBlock != nil) {
        _updateBlock(animationPercentage);
    }
}

- (void)stopAnimation
{
    _updateBlock = nil;
    if (_animationTimer != nil) {
        self.progress = [_animationTimer.userInfo[@"to"] floatValue];
    }
    [_animationTimer invalidate];
    _animationTimer = nil;
}

#pragma mark - UIView
// ____________________________________________________________________________________________________________________

- (void)removeFromSuperview
{
    [self stopAnimation];
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
    
    const CGFloat perc = fmaxf(self.shouldShowZeroProgress ? 0.000001 : 0, self.progress);
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
    if (perc > 0) {
        
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
    }
    
    
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
    
    UIImage *_image = [self _centerDotColorizedImage];
    CGSize imageSize = _image.size;
    if (self.centerDotImage == nil) {
        CGContextSetFillColorWithColor(ctx, self.dotColor.CGColor);
    } else {
        imageSize.height = fminf(imageSize.height, (lineRadius * 2) * 0.7);
        imageSize.width = fminf(imageSize.width, (lineRadius * 2) * 0.7);
    }
    
    if ((self.centerDotStyle == ESArcProgressCenterDotStyleBeginAndEnd || self.centerDotStyle == ESArcProgressCenterDotStyleBegin) && perc > 0) {
        if (_image != nil) {
            [_image drawInRect:CGRectMake(center.x - imageSize.width / 2, lineRadius - imageSize.height / 2, imageSize.width, imageSize.height)];
        } else {
            CGContextAddEllipseInRect(ctx, CGRectMake(center.x - midDotRadius, center.y - innerRadius - midDotRadius, midDotRadius * 2, midDotRadius * 2));
        }
    }
    
    if (((self.centerDotStyle == ESArcProgressCenterDotStyleBeginAndEnd && self.progress < 1.0f) || self.centerDotStyle == ESArcProgressCenterDotStyleEnd) && self.progress > 0) {
        CGFloat w = sinf(delta) * innerRadius;
        CGFloat h = cosf(delta) * innerRadius;
        CGFloat x = center.x + w;
        CGFloat y = center.y - h;
        
        if (_image != nil) {
            [_image drawInRect:CGRectMake(x - imageSize.width / 2, y - imageSize.height / 2, imageSize.width, imageSize.height)];
        } else {
            CGContextAddEllipseInRect(ctx, CGRectMake(x - midDotRadius, y - midDotRadius, midDotRadius * 2, midDotRadius * 2));
            
        }
    }
    
    if (self.centerDotImage == nil) {
        CGContextSetShadowWithColor(ctx, CGSizeZero, 0, nil);
        CGContextSetLineWidth(ctx, 0);
        CGContextFillPath(ctx);
    }
}

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	Creates a colorized UIImage
 *  Credits to https://github.com/raymondjavaxx/UIImage-RTTint
 *
 *	@return UIImage
 *
 *	@since 1.3
 *  @date 10/03/2015
 */
- (UIImage *)_centerDotColorizedImage
{
    if (self.centerDotImage == nil || !self.colorizeCenterDotImage) {
        return self.centerDotImage;
    }
    CGRect imageRect = CGRectMake(0.0f, 0.0f, self.centerDotImage.size.width, self.centerDotImage.size.height);
    
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.centerDotImage.scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self.centerDotImage drawInRect:imageRect];
    
    CGContextSetFillColorWithColor(ctx, [self.dotColor CGColor]);
    CGContextSetAlpha(ctx, 1.0f);
    CGContextSetBlendMode(ctx, kCGBlendModeSourceAtop);
    CGContextFillRect(ctx, imageRect);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *darkImage = [UIImage imageWithCGImage:imageRef
                                             scale:self.centerDotImage.scale
                                       orientation:self.centerDotImage.imageOrientation];
    CGImageRelease(imageRef);
    
    UIGraphicsEndImageContext();
    
    return darkImage;
}


#pragma mark - Destructor
// ____________________________________________________________________________________________________________________

- (void)dealloc
{
    [_animationTimer invalidate];
    _animationTimer = nil;
    _updateBlock = nil;
}

@end

@implementation UIView (ESMultipleArcProgressViewGenerateUIImage)

- (UIImage *)generateImage
{
    NSAssert(NO, @"use es_imageOfView instead");
    return nil;
}

- (UIImage *)es_imageOfView
{
    return [self es_imageOfViewWithScale:0];
}

- (UIImage *)es_imageOfViewWithScale:(CGFloat)scale
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end