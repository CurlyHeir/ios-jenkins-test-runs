//
//  AcceptanceTests.m
//  integration-example
//
//  Created by kudl helBell on 16/07/16.
//  Copyright © 2016 blow. All rights reserved.
//

#import "TestCase.h"
#import "AccessibilityLabels.h"

@interface AcceptanceTests : TestCase

@end

@implementation AcceptanceTests

- (void)testThatUserCanTypeTextIntoLabel {
    [tester tapViewWithAccessibilityLabel:Home_firstButton];
    [tester enterText:@"Example text" intoViewWithAccessibilityLabel:Second_editText];
    
}


@end
