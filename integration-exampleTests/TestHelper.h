//
//  TestHelper.h
//  integration-example
//
//  Created by kudl helBell on 20/02/16.
//  Copyright © 2016 blow. All rights reserved.
//

@import Foundation;
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface TestHelper : NSString

+ (instancetype)sharedInstance;

- (void)login;

- (void)addTestSuite:(NSString *)name;

- (void)addDevice:(NSString *)deviceName;

- (void)retrieveTestingSessionID;

- (void)logEventWithTitle:(NSString *)title andDescription:(NSDictionary *)info;

@end
