//
//  ESArcProgressViewTests.m
//  ESArcProgressViewTests
//
//  Created by Bas van Kuijck on 10-03-15.
//  Copyright (c) 2015 e-sites. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <ESArcProgressView.h>

@interface ESArcProgressViewTests : XCTestCase

@end

@implementation ESArcProgressViewTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testImageGeneration
{
    CGFloat wh = 200;
    ESArcProgressView *pv = [[ESArcProgressView alloc] initWithFrame:CGRectMake(0, 0, wh, wh)];
    [pv setProgress:0.5];
    UIImage *image = [pv es_imageOfView];
    XCTAssert(image.size.width == wh && image.size.height == wh, @"Width and height of the image should be %.2f", wh);
}

- (void)testMultipleViews
{
    ESMultipleArcProgressView *mv = [[ESMultipleArcProgressView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    
    ESArcProgressView *pv = [[ESArcProgressView alloc] init];
    [pv setProgress:0.5];
    [mv addArcProgressView:pv];
    
    pv = [[ESArcProgressView alloc] init];
    [pv setProgress:0.5];
    [mv addArcProgressView:pv];
    
    XCTAssert(mv.subviews.count == 2, @"ESMultipleArcProgressView should contain 2 subviews");
}

- (void)testRemoveMultipleViews
{
    ESMultipleArcProgressView *mv = [[ESMultipleArcProgressView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    
    ESArcProgressView *pv = [[ESArcProgressView alloc] init];
    [pv setProgress:0.5];
    [mv addArcProgressView:pv];
    
    pv = [[ESArcProgressView alloc] init];
    [pv setProgress:0.5];
    [mv addArcProgressView:pv];
    
    pv = [[ESArcProgressView alloc] init];
    [pv setProgress:0.5];
    [mv addArcProgressView:pv];
    
    [mv removeArcProgressView:pv];
    
    XCTAssert(mv.subviews.count == 2, @"ESMultipleArcProgressView should contain 2 subviews");
}

@end
