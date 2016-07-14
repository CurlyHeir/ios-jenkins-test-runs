//
//  DefaultValueTests.m
//  integration-example
//
//  Created by kudl helBell on 20/02/16.
//  Copyright © 2016 blow. All rights reserved.
//

#import "TestCase.h"
#import "AccessibilityLabels.h"
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

@interface DefaultValueTests : TestCase

@end

@implementation DefaultValueTests

- (void)testThatValueForSliderShouldHaveSetMinimumValue {
    [tester tapViewWithAccessibilityLabel:Home_secondButton];
     [tester waitForTimeInterval:3];
    [tester waitForViewWithAccessibilityLabel:Second_ScreenName];
     [tester waitForTimeInterval:3];
    [tester setValue:60.f forSliderWithAccessibilityLabel:Second_Slider];
    UISlider * slider = (UISlider *)[tester waitForViewWithAccessibilityLabel:Second_Slider];
     [tester waitForTimeInterval:3];
    assertThatFloat(slider.value, is(@30));
}

- (void)testThatTitleForButtonsAreCorrect {
    UIButton *firstButton = (UIButton *)[tester waitForViewWithAccessibilityLabel:Home_firstButton];
    [tester waitForTimeInterval:3];
    assertThat(firstButton.titleLabel.text, is(@"FirstViewController"));
    
    [tester waitForTimeInterval:3];
    UIButton *secondButton = (UIButton *)[tester waitForViewWithAccessibilityLabel:Home_secondButton];
    [tester waitForTimeInterval:3];
    assertThat(secondButton.titleLabel.text, is(@"SecondViewController"));
}

- (void)testThatSecondViewControllerEditTextHasPlaceholder {
    [tester tapViewWithAccessibilityLabel:Home_firstButton];
    UILabel * label = (UILabel *)[tester waitForViewWithAccessibilityLabel:SecondViewController_titleLabel];
}


@end
