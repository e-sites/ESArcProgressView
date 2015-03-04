# ESArcProgressView
[![Platform](https://cocoapod-badges.herokuapp.com/p/ESArcProgressView/badge.png)](http://cocoadocs.org/docsets/ESArcProgressView)
[![Version](https://cocoapod-badges.herokuapp.com/v/ESArcProgressView/badge.png)](http://cocoadocs.org/docsets/ESArcProgressView)

A progress view to be used within Apple Watch projects

## Examples
![](https://raw.githubusercontent.com/e-sites/ESArcProgressView/master/Assets/example1.png)


## Installation

### Cocoapods
```pod 'ESArcProgressView', '~> 1.0'```

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
[pv setColor:[UIColor orangeColor]];
[v addArcProgressView:pv];
    
pv = [[ESArcProgressView alloc] init];
[pv setProgress:0.65];
[pv setColor:[UIColor greenColor]];
[v addArcProgressView:pv];
    
pv = [[ESArcProgressView alloc] init];
[pv setProgress:0.8];
[pv setColor:[UIColor redColor]];
[v addArcProgressView:pv];
```

```objc
// To extra the UIImage:
UIImage *image = [v generateImage];
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
// To extra the UIImage:
UIImage *image = [pv generateImage];
```
