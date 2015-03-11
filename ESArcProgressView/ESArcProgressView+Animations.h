//
//  ESArcProgressView+Animations.h
//  CircleDraw
//
//  Created by Bas van Kuijck on 11-03-15.
//  Copyright (c) 2015 e-sites. All rights reserved.
//

#import "ESArcProgressView.h"
#include "easing.h"

typedef void (^ESArcProgressViewUpdateBlock)(CGFloat animationProgress);

@interface ESArcProgressView (Animations)


/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	Animate to a given value with a duration of 1.0seconds and linear easing
 *
 *	@param toValue CGFloat (somewhere between 0.0 and 1.0f)
 *
 *	@since 1.5
 *  @date 10/03/2015
 */
- (void)animateTo:(CGFloat)toValue;

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	Animate to a given value with a given duration and a linear easing
 *
 *	@param toValue CGFloat (somewhere between 0.0 and 1.0f)
 *  @param duration NSTimeInterval Duration
 *
 *	@since 1.5
 *  @date 10/03/2015
 */
- (void)animateTo:(CGFloat)toValue withDuration:(NSTimeInterval)duration;

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	Animate to a given value with a duration and custom easing
 *  @see https://github.com/warrenm/AHEasing for possible easingFunction values
 *
 *	@param toValue        CGFloat
 *	@param duration       NSTimeInterval
 *	@param easingFunction AHEasingFunction
 *
 *	@since 1.5
 *  @date 10/03/2015
 */
- (void)animateTo:(CGFloat)toValue withDuration:(NSTimeInterval)duration withEasingFunction:(AHEasingFunction)easingFunction;

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	Animate to a given value with a duration and custom easing
 *  Every time a new progress is done the updateHandler will be called
 *  @see https://github.com/warrenm/AHEasing for possible easingFunction values
 *
 *	@param toValue        CGFloat
 *	@param duration       NSTimeInterval
 *	@param easingFunction AHEasingFunction
 *  @param updateHandler ESArcProgressViewUpdateBlock
 *
 *	@since 1.5
 *  @date 10/03/2015
 */
- (void)animateTo:(CGFloat)toValue withDuration:(NSTimeInterval)duration withEasingFunction:(AHEasingFunction)easingFunction withUpdateHandler:(ESArcProgressViewUpdateBlock)updateHandler;

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	Stops an active animation
 *
 *	@since 1.5
 *  @date 10/03/2015
 */
- (void)stopAnimation;

@end
