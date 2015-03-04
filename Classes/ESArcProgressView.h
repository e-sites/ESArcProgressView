//
//  ESArcProgressView.h
//  iOS.Library
//
//  Created by Bas van Kuijck on 04-03-15.
//  Copyright (c) 2015 e-sites. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ESMultipleArcProgressView;
@interface ESArcProgressView : UIView

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	The color of the progress
 *  @note Default = Green
 *
 *  @since 1.0
 *  @date 04/03/2015
 */
@property (nonatomic, strong) UIColor *color;

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	The color of the center dots at the beginning and end of the progress vew
 *  @note Default = white
 *
 *	@since 1.0
 *  @date 04/03/2015
 */
@property (nonatomic, strong) UIColor *dotColor;

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	The procentual progress of this view
 *  @note Default = 0
 *  @warning This must be a value somewheren between 0.0 and 1.0
 *
 *	@since 1.0
 *  @date 04/03/2015
 */
@property (nonatomic, readwrite) CGFloat progress;

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	The lineWidth of the progress (aka the diameter)
 *  @note Default = 20 pixels
 *
 *	@since 1.0
 *  @date 04/03/2015
 */
@property (nonatomic, readwrite) CGFloat lineWidth;

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	Should the progress have a drop shadow
 *  @note Default = YES
 *
 *	@since 1.0
 *  @date 04/03/2015
 */
@property (nonatomic, readwrite, getter=shouldShowShadow) BOOL showShadow;

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	Should the progress view show a small center dot
 *  @note Default = YES
 *
 *	@since 1.0
 *  @date 04/03/2015
 */
@property (nonatomic, readwrite, getter=shouldShowCenterDot) BOOL showCenterDot;

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	A property that points the a `ESMultipleArcProgressView` if used.
 *  @warning: Do not call this property yourself, `ESMultipleArcProgressView` will do that for you
 *  @see ESMultipleArcProgressView for more information
 *
 *	@since 1.0
 *  @date 04/03/2015
 */
@property (nonatomic, weak) ESMultipleArcProgressView *multipleArcProgressView;

@end

@interface UIView (ESMultipleArcProgressViewGenerateUIImage)
- (UIImage *)generateImage;
@end