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

- (void)afterAll {
    [super afterAll];
    exit(0);
}

@end
