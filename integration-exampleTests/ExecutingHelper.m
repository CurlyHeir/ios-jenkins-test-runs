//
//  ExecutingHelper.m
//  integration-example
//
//  Created by kudl helBell on 20/02/16.
//  Copyright © 2016 blow. All rights reserved.
//

#import "ExecutingHelper.h"
#import "Typhoon.h"

NSTimeInterval const kDefaultDelayForWaitUntil = 0.2;
NSTimeInterval const kTimeOutIntervalForWaitUntil = 10;

@implementation ExecutingHelper

+ (void)wait:(NSTimeInterval)time {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:time];
    [TyphoonTestUtils waitForCondition:^BOOL {
        NSDate *now = [NSDate date];
        typhoon_asynch_condition([date compare:now] == NSOrderedAscending);
    }];
}

+ (void)waitUntil:(BOOL (^)())condition {
    if (!condition) {
        NSLog(@"condition block do not exist. Return");
        return;
    }
    BOOL waiting = !condition();
    NSUInteger count = 0;
    NSTimeInterval maxCount = kTimeOutIntervalForWaitUntil/kDefaultDelayForWaitUntil;
    NSTimeInterval time = [NSDate timeIntervalSinceReferenceDate];
    while (waiting && count < maxCount) {
        count++;
        [self wait:kDefaultDelayForWaitUntil];
        waiting = !condition();
    }
    
    if (waiting) {
        NSLog(@"Timeout!!! (%f). Condition do not achieved!!!", [NSDate timeIntervalSinceReferenceDate] - time);
    } else {
        NSLog(@"Condition achieved in about: %f", [NSDate timeIntervalSinceReferenceDate] - time);
    }
}

@end
