//
//  ESArcProgressViewCore.h
//  iOS.Library
//
//  Created by Bas van Kuijck on 04-03-15.
//  Copyright (c) 2015 e-sites. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ESArcProgressCenterDotStyle) {
    ESArcProgressCenterDotStyleNone = 0,
    ESArcProgressCenterDotStyleBegin,
    ESArcProgressCenterDotStyleEnd,
    ESArcProgressCenterDotStyleBeginAndEnd
};

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
 *	The label to show in the progress view
 *  @note Default = nil
 *
 *	@since 1.2
 *  @date 06/03/2015
 */
@property (nonatomic, copy) NSString *text;

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	Should a small line fragment be visible when the progress is 0.0
 *  @note Default: NO
 * 
 *	@since 1.3
 *  @date 06/03/2015
 */
@property (nonatomic, readwrite, getter=shouldShowZeroProgress) BOOL showZeroProgress;

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	Should the progress view show a small center dot
 *  @deprecated Use [ESArcProgressView centerDotStyle] instead
 *  @note Default = YES
 *
 *	@since 1.0
 *  @date 04/03/2015
 */
@property (nonatomic, readwrite, getter=shouldShowCenterDot) BOOL showCenterDot __attribute__((deprecated("use centerDotStyle instead")));

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	What center dot style should be used
 *  @note Default = ESArcProgressCenterDotStyleBeginAndEnd
 *
 *	@since 1.1
 *  @date 05/03/2015
 */
@property (nonatomic, readwrite) ESArcProgressCenterDotStyle centerDotStyle;


/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	The image to show as a center dot in the arc line
 *  @note Default = nil
 *
 *  @date 10/03/2015
 *	@since 1.4
 */
@property (nonatomic, strong) UIImage *centerDotImage;

/**
 *	@author Bas van Kuijck <bas@e-sites.nl>
 *
 *	Should the `centerDotImage` be colorized according to the `dotColor` ?
 *  @note Default = YES
 *
 *	@since 1.4
 *  @date 10/03/2015
 */
@property (nonatomic, readwrite, getter=shouldColorizeCenterDotImage) BOOL colorizeCenterDotImage;


@end

@interface UIView (ESMultipleArcProgressViewGenerateUIImage)
- (UIImage *)generateImage __attribute__((deprecated("use es_imageOfView instead")));
- (UIImage *)es_imageOfView;
- (UIImage *)es_imageOfViewWithScale:(CGFloat)scale;
@end