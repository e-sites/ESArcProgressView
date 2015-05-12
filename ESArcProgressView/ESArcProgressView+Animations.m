//
//  ESArcProgressView+Animations.m
//  CircleDraw
//
//  Created by Bas van Kuijck on 11-03-15.
//  Copyright (c) 2015 e-sites. All rights reserved.
//

#import "ESArcProgressView+Animations.h"
#import <objc/runtime.h>

static char kEasingFunctionKey;
static char kAnimationTimerKey;
static char kAnimationStepKey;
static char kUpdateHandlerKey;

@implementation ESArcProgressView (Animations)

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
    
    objc_setAssociatedObject(self, &kUpdateHandlerKey, updateHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    NSValue *nsvalue = [NSValue valueWithBytes:&easingFunction objCType:@encode(AHEasingFunction)];
    objc_setAssociatedObject(self, &kEasingFunctionKey, nsvalue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSTimer *timer = objc_getAssociatedObject(self, &kAnimationTimerKey);
    [timer invalidate];
    toValue = fminf(fmaxf(0.0f, toValue), 1.0f);
    
    objc_setAssociatedObject(self, &kAnimationStepKey, @(0), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f / kFPS target:self selector:@selector(_animationTick:) userInfo:@{
                                                                                                                                     @"from": @(self.progress),
                                                                                                                                     @"to": @(toValue),
                                                                                                                                     @"duration": @(duration)
                                                                                                                                     } repeats:YES];
    objc_setAssociatedObject(self, &kAnimationTimerKey, timer, OBJC_ASSOCIATION_RETAIN);
}

- (void)_animationTick:(NSTimer *)timer
{
    CGFloat fromValue = [timer.userInfo[@"from"] floatValue];
    CGFloat toValue = [timer.userInfo[@"to"] floatValue];
    NSTimeInterval duration = [timer.userInfo[@"duration"] doubleValue];

    CGFloat percPercStep = (toValue >= fromValue ? (toValue - fromValue) : (fromValue - toValue))/(duration * kFPS);
    NSInteger animationStep = [objc_getAssociatedObject(self, &kAnimationStepKey) integerValue];
    animationStep++;
    objc_setAssociatedObject(self, &kAnimationStepKey, @(animationStep), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    ESArcProgressViewUpdateBlock updateBlock = objc_getAssociatedObject(self, &kUpdateHandlerKey);
    
    CGFloat animationPercentage = animationStep * percPercStep;
    if (animationPercentage >= 1.0f) {
        ESArcProgressViewUpdateBlock handler = updateBlock;
        [self stopAnimation];
        if (handler != nil) {
            handler(animationPercentage);
            handler = nil;
        }
        return;
    }
    NSValue *value = objc_getAssociatedObject(self, &kEasingFunctionKey);
    CGFloat p = animationPercentage;
    if (value != nil) {
        AHEasingFunction function;
        [value getValue:&function];
        p = function(animationPercentage);
    }    
    
    self.progress = fromValue + ((toValue - fromValue) * p);

    if (updateBlock != nil) {
        updateBlock(animationPercentage);
    }
}

- (void)stopAnimation
{
    objc_setAssociatedObject(self, &kEasingFunctionKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &kAnimationStepKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &kUpdateHandlerKey, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    NSTimer *timer = objc_getAssociatedObject(self, &kAnimationTimerKey);
    if (timer != nil) {
        self.progress = [timer.userInfo[@"to"] floatValue];
    }
    objc_setAssociatedObject(self, &kAnimationTimerKey, nil, OBJC_ASSOCIATION_RETAIN);
    [timer invalidate];
}

#pragma mark - Destructor
// ____________________________________________________________________________________________________________________

- (void)dealloc
{
    [self stopAnimation];
}

@end