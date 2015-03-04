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

#pragma mark - Adding progress views
// ____________________________________________________________________________________________________________________

- (void)addArcProgressView:(ESArcProgressView *)progressView
{
    NSAssert([progressView isKindOfClass:[ESArcProgressView class]], @"view <%@:%p> is not type of class ESArcProgressView", NSStringFromClass(progressView.class), progressView);
    
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
    [self _updateProgressViews];
}

- (void)_updateProgressViews
{
    _previousArcProgressView = nil;
    NSArray *progressViews = [[self.subviews reverseObjectEnumerator] allObjects];
    for (UIView *v in progressViews) {
        ESArcProgressView *pv = (ESArcProgressView *)v;
        [self _placeProgressView:pv];
        [self bringSubviewToFront:pv];
        _previousArcProgressView = pv;
    }
}

@end
