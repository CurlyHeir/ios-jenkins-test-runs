//
//  TestCase.m
//  integration-example
//
//  Created by kudl helBell on 20/02/16.
//  Copyright © 2016 blow. All rights reserved.
//

#import "TestCase.h"
#import "TestHelper.h"


@implementation TestCase

- (void)beforeAll {
    [super beforeAll];
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        // TODO : request
//        [[TestHelper sharedInstance] login];
//        [[TestHelper sharedInstance] addTestSuite:@"TestIntegrationFromXcode"];
//        [[TestHelper sharedInstance] addDevice:@"iPhone 5s Simulator"];
//        [[TestHelper sharedInstance] retrieveTestingSessionID];
    });
}

@end
