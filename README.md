# ESArcProgressView
[![Build](https://travis-ci.org/e-sites/ESArcProgressView.svg)](https://travis-ci.org/e-sites/ESArcProgressView)
[![Platform](https://cocoapod-badges.herokuapp.com/p/ESArcProgressView/badge.png)](http://cocoadocs.org/docsets/ESArcProgressView)
[![Version](https://cocoapod-badges.herokuapp.com/v/ESArcProgressView/badge.png)](http://cocoadocs.org/docsets/ESArcProgressView)

A progress view to be used within Apple Watch projects

## Examples
![](https://raw.githubusercontent.com/e-sites/ESArcProgressView/master/Assets/example1.png)
![](https://raw.githubusercontent.com/e-sites/ESArcProgressView/master/Assets/applewatch1.png)


## Installation

### Cocoapods
```pod 'ESArcProgressView', '~> 1.4'```

### Manually

These classes have the following dependecies:
- `QuartzCore` Framework

## Usage

### ESMultipleArcProgressView
```#import <ESMultipleArcProgressView.h>```

```objc
ESMultipleArcProgressView *v = [[ESMultipleArcProgressView alloc] initWithFrame:CGRectMake(40, 40, 200, 200)];
[self.view addSubview:v];

ESArcProgressView *pv = [[ESArcProgressView alloc] init];
[pv setProgress:0.5];
[pv setText:@"RUN"];
[pv setColor:[UIColor orangeColor]];
[v addArcProgressView:pv];

pv = [[ESArcProgressView alloc] init];
[pv setProgress:0.65];
[pv setText:@"WALK"];
[pv setColor:[UIColor greenColor]];
[v addArcProgressView:pv];

pv = [[ESArcProgressView alloc] init];
[pv setProgress:0.8];
[pv setText:@"REST"];
[pv setColor:[UIColor redColor]];
[v addArcProgressView:pv];
```

```objc
// To extract the UIImage:
UIImage *image = [v es_imageOfView];
```

### ESArcProgressView
```#import <ESArcProgressView.h>```

```objc
ESArcProgressView *pv = [[ESArcProgressView alloc] initWithFrame:CGRectMake(20, 20, 200, 200)];
[pv setProgress:0.5];
[pv setColor:[UIColor orangeColor]];
[self.view addSubview:pv];
```

```objc
// To extract the UIImage:
UIImage *image = [pv es_imageOfView];
```

### Animation

```#import <ESArcProgressView.h>```

```#include <easing.h>```

```objc
ESArcProgressView *pv = [[ESArcProgressView alloc] initWithFrame:CGRectMake(20, 20, 200, 200)];
[pv setProgress:0];
[pv setColor:[UIColor orangeColor]];
[self.view addSubview:pv];

[pv animateTo:0.75 withDuration:1.0f withEasingFunction:BounceEaseOut withUpdateHandler:^(CGFloat animationProgress) {
	NSLog(@"animation progress: %.2f", animationProgress);
	if (animationProgress == 1.0f) {
		NSLog(@"animation finished");
	}
}];
```

## ESArcProgressView

### Properties

| Property 	| Type  | Description  | Default value
|-------	|------ |----------    | -------
| `color`		| UIColor | The color of the line | Green
| `backgroundColor`	| UIColor | The background color of the line | Default = 50% transparent of color
| `dotColor	`	| UIColor | The color of the center dot at the beginning / end of the line | White
| `lineWidth`		| CGFloat | The line width (aka diameter) of the line | 20
| `showZeroProgress`	| BOOL | Should a small line fragment be visible when the progress is 0.0 | NO
| `showShadow`	| BOOL | Should the line have a drop shadow | YES
| `centerDotStyle`	| ESArcProgress-CenterDotStyle | Center dot style placement | ESArcProgress-CenterDotStyle-BeginAndEnd
| `centerDotImage` | UIImage | The 'center dot' is replaced by a custom image | nil
| `colorizeCenterDotImage` | BOOL | Should `centerDotImage` be colorized with `dotColor` | YES
| `progress`		| CGFloat | The progress in percentage (from 0.0 - 1.0) | 0.0
| `text`			| NSString | Show a text label next to the progress view | nil
| `multipleArcProgressView` | ESMultipleArc-ProgressView | The group view this instance belongs to  | nil

### ESArcProgressCenterDotStyle
```objc
typedef NS_ENUM(NSInteger, ESArcProgressCenterDotStyle) {
    ESArcProgressCenterDotStyleNone = 0,
    ESArcProgressCenterDotStyleBegin,
    ESArcProgressCenterDotStyleEnd,
    ESArcProgressCenterDotStyleBeginAndEnd
};
```

### Methods

#### `animateTo:`

Animate to a given value with a duration of 1.0seconds and linear easing

| Property 	| Type  | Description
|-------	|------ |----------
| `toValue`		| CGFloat | The progress to animate to

------------

#### `animateTo:withDuration:`

Animate to a given value with a duration of 1.0seconds and linear easing

| Property 	| Type  | Description
|-------	|------ |----------
| `toValue`		| CGFloat | The progress to animate to
| `duration`		| NSTimeInterval | The duration of the animation

------------

#### `animateTo:withDuration:withEasingFunction:`

Animate to a given value with a duration of 1.0seconds and linear easing

| Property 	| Type  | Description
|-------	|------ |----------
| `toValue`		| CGFloat | The progress to animate to
| `duration`		| NSTimeInterval | The duration of the animation
| `easingFunction`		| AHEasingFunction | See [AHEAsing](https://github.com/warrenm/AHEasing) for possible values

------------

#### `animateTo:withDuration:withEasingFunction:withUpdateHandler:`

Animate to a given value with a duration of 1.0seconds and linear easing

| Property 	| Type  | Description
|-------	|------ |----------
| `toValue`		| CGFloat | The progress to animate to
| `duration`		| NSTimeInterval | The duration of the animation
| `easingFunction`		| AHEasingFunction | See [AHEAsing](https://github.com/warrenm/AHEasing) for possible values
| `updateHandler` | void (^)(CGFloat animationProgress) | Update block which is called when the animation progresses

------------

## ESMultipleArcProgressView

### Properties

| Property 	| Type  | Description  | Default value
|-------	|------ |----------    | -------
| `margin`		| CGFloat | The space between the progress views | 1.0

### Methods

------------

#### `addArcProgressView:`

Adds a `ESArcProgressView` to the view. Each `ESArcProgressView` will be inserted inside the previous `ESArcProgressView`.

| Parameter 	| Type  | Description
|-------	|------ |----------
| `progressView`		| ESArcProgressView | The ESArcProgressView to add

------------

#### `removeArcProgressView:`

Remove a particular `ESArcProgressView` from the view stack. This method will reposition the remaining progress views accordingly.

| Parameter 	| Type  | Description
|-------	|------ |----------
| `progressView`		| ESArcProgressView | The ESArcProgressView to be removed


## UIView (ESMultipleArcProgressViewGenerateUIImage)

#### `es_imageOfView`
This method generates (and returns) a `UIImage` which is a snapshot of the current instance's view with the device's scale as setting

### `es_imageOfViewWithScale:`
This method generates (and returns) a `UIImage` which is a snapshot of the current instance's view with a specific scale setting
