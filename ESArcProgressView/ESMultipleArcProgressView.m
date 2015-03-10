//
//  ESMultipleArcProgressView.m
//  CircleDraw
//
//  Created by Bas van Kuijck on 04-03-15.
//  Copyright (c) 2015 e-sites. All rights reserved.
//

#import "ESMultipleArcProgressView.h"

@implementation ESMultipleArcProgressView {
    ESArcProgressView *_previousArcProgressView;
}
@synthesize margin=_margin;

#pragma mark - Constructor
// ____________________________________________________________________________________________________________________

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
    _margin = 1;
}

#pragma mark - Layout
// ____________________________________________________________________________________________________________________

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self _updateProgressViews];
}

#pragma mark - Adding progress views
// ____________________________________________________________________________________________________________________

- (void)addArcProgressView:(ESArcProgressView *)progressView
{
    NSAssert([progressView isKindOfClass:[ESArcProgressView class]], @"view <%@:%p> is not type of class ESArcProgressView", NSStringFromClass(progressView.class), progressView);
    CGFloat diameterLeft = self.frame.size.width / 2;
    if (_previousArcProgressView != nil) {
        diameterLeft = _previousArcProgressView.frame.size.width - (_previousArcProgressView.lineWidth * 2);
        diameterLeft -= self.margin * 2;
    }
    NSAssert(diameterLeft >= progressView.lineWidth * 2, @"There is not enough room to place the <%@:%p> with lineWidth %.2f, maximum lineWidth: %.2f", NSStringFromClass(progressView.class), progressView, progressView.lineWidth, diameterLeft / 2);
             
    [self _placeProgressView:progressView];
    [progressView setMultipleArcProgressView:self];
    [super addSubview:progressView];
    _previousArcProgressView = progressView;
}

- (void)setMargin:(CGFloat)aMargin
{
    _margin = aMargin;
    [self _updateProgressViews];
}

- (void)_placeProgressView:(ESArcProgressView *)progressView
{
    CGRect rect = self.bounds;
    if (_previousArcProgressView != nil) {
        rect = _previousArcProgressView.frame;
        rect.size.width -= (_previousArcProgressView.lineWidth * 2) + (self.margin * 2);
        rect.size.height -= (_previousArcProgressView.lineWidth * 2) + (self.margin * 2);
        rect.origin.x += _previousArcProgressView.lineWidth + self.margin;
        rect.origin.y += _previousArcProgressView.lineWidth + self.margin;
    }
    
    [progressView setFrame:rect];
    [progressView setNeedsDisplay];    
}

- (void)removeArcProgressView:(ESArcProgressView *)progressView
{
    [progressView setMultipleArcProgressView:nil];
    [progressView removeFromSuperview];
}

- (void)_updateProgressViews
{
    _previousArcProgressView = nil;
    NSArray *progressViews = self.subviews;
    for (UIView *v in progressViews) {
        ESArcProgressView *pv = (ESArcProgressView *)v;
        [self _placeProgressView:pv];
        [self bringSubviewToFront:pv];
        _previousArcProgressView = pv;
    }
}

#pragma mark - Overriding
// ____________________________________________________________________________________________________________________

- (void)addSubview:(UIView *)view
{
    NSAssert(NO, @"%s should not be called", __PRETTY_FUNCTION__);
}

- (void)insertSubview:(UIView *)view aboveSubview:(UIView *)siblingSubview
{
    NSAssert(NO, @"%s should not be called", __PRETTY_FUNCTION__);    
}

- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index
{
    NSAssert(NO, @"%s should not be called", __PRETTY_FUNCTION__);
}

- (void)insertSubview:(UIView *)view belowSubview:(UIView *)siblingSubview
{
    NSAssert(NO, @"%s should not be called", __PRETTY_FUNCTION__);
}

@end