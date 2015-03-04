# ESArcProgressView
[![Platform](https://cocoapod-badges.herokuapp.com/p/ESArcProgressView/badge.png)](http://cocoadocs.org/docsets/ESArcProgressView)
[![Version](https://cocoapod-badges.herokuapp.com/v/ESArcProgressView/badge.png)](http://cocoadocs.org/docsets/ESArcProgressView)

A progress view to be used within Apple Watch projects

## Examples
![](https://raw.githubusercontent.com/e-sites/ESArcProgressView/master/Assets/example.png)


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

### ESArcProgressView
```#import <ESArcProgressView.h>```

```objc
ESArcProgressView *pv = [[ESArcProgressView alloc] initWithFrame:CGRectMake(20, 20, 200, 200)];
[pv setProgress:0.5];
[pv setColor:[UIColor orangeColor]];
[self.view addSubview:pv];
```

### Localization
- `deleteText`: The text in the delete button (default = "Delete")
- `cancelText`: The text in the cancel button (default = "Cancel")
- `headerText`: The top text that asks the user to enter a passcode (default = "Enter Passcode")

### Appearance
- `showCancelButton`: Should the cancel button appear when no digits are entered (Default = NO)
- `showAlphabet`: Should the entry buttons contain alphabet characters. (Default = NO)
- `backgroundView`: Should the entry buttons contain alphabet characters. (Default = Blue/grayish background)
- `backgroundBlurRadius`: The blur radius given to the background view (Default = 15)
- `backgroundColor`: The background color that overlays the backgroundView (Default = 70% alpha black)

### Validation
- `numberOfDigits`: The total number of digits that should be entered. (Default = 4)
- `attempts`: The total number of attempts (readonly)
- `code`: The code that is entered. (readonly)
- `vibrate`: Should the device vibrate when an incorrect entry is given (Default = YES)

### General
- `delegate`