//
//  ESMultipleArcProgressView.h
//  CircleDraw
//
//  Created by Bas van Kuijck on 04-03-15.
//  Copyright (c) 2015 e-sites. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESArcProgressView.h"


@interface ESMultipleArcProgressView : UIView

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	How much margin should be used betwene individual `ESArcProgressView`
 *  @note Default = 1
 *
 *	@since 1.0
 *  @date 04/03/2015
 */
@property (nonatomic, readwrite) CGFloat margin;

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	Add an `ESArcProgressView` to the view stack
 *  @see ESArcProgressView
 *
 *	@param progressView ESArcProgressView
 *
 *	@since 1.0
 *  @date 04/03/2015
 */
- (void)addArcProgressView:(ESArcProgressView *)progressView;

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	Remove a specific `ESArcProgressView` fromthe view stack
 *  @see ESArcProgressView
 *
 *	@param progressView ESArcProgressView
 *
 *	@since 1.0
 *  @date 04/03/2015
 */
- (void)removeArcProgressView:(ESArcProgressView *)progressView;

- (void)addSubview:(UIView *)view __attribute__((unavailable("use addArcProgressView: instead")));
- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index __attribute__((unavailable("use addArcProgressView: instead")));
- (void)insertSubview:(UIView *)view aboveSubview:(UIView *)siblingSubview __attribute__((unavailable("use addArcProgressView: instead")));
- (void)insertSubview:(UIView *)view belowSubview:(UIView *)siblingSubview __attribute__((unavailable("use addArcProgressView: instead")));

@end