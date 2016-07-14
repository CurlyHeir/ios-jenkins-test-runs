//
//  TestHelper.m
//  integration-example
//
//  Created by kudl helBell on 20/02/16.
//  Copyright © 2016 blow. All rights reserved.
//

#import "TestHelper.h"
#import "HTTPClient.h"
#import "ExecutingHelper.h"

@interface TestHelper()

@property (nonatomic, strong) HTTPClient *httpClient;
@property (nonatomic, strong) NSString *testSuiteId;
@property (nonatomic, strong) NSString *deviceID;
@property (nonatomic, strong) NSString *testingSession;

@end

@implementation TestHelper

+ (instancetype)sharedInstance {
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _httpClient = [HTTPClient new];
    }
    return self;
}

- (void)login {
    __block BOOL finished = NO;
    [[self.httpClient POST:@"/auth" parameters:@{@"email":@"test@blow.io",@"password":@"12345678"}] subscribeNext:^(NSDictionary *dictionary) {
        self.httpClient.token = dictionary[@"token"];
        finished = YES;
    } error:^(NSError *error) {
        finished = YES;
    }];
    [ExecutingHelper waitUntil:^BOOL{
        return finished == YES;
    }];
}

- (void)addTestSuite:(NSString *)name {
    __block BOOL finished = NO;
    [[self.httpClient POST:@"/test-suites" parameters:@{@"name":name}]
        subscribeNext:^(NSDictionary *response) {
        self.testSuiteId = response[@"_id"];
        NSLog(@"@API RESPONSE@ TEST_SUITE_ID %@",self.testSuiteId);
        finished = YES;
    } error:^(NSError *error) {
        finished = YES;
    }];
    
    [ExecutingHelper waitUntil:^BOOL{
        return finished == YES;
    }];
}

- (void)addDevice:(NSString *)deviceName {
    __block BOOL finished = NO;
    [[self.httpClient POST:@"/devices" parameters:@{@"model":deviceName,@"os":@"iOS"}] subscribeNext:^(NSDictionary *response) {\
        NSString *deviceID = response[@"_id"];
        self.deviceID = deviceID;
        NSLog(@"@API RESPONSE@ DEVICE_ID %@",deviceID);
        finished = YES;
    } error:^(NSError *error) {
        finished = YES;
    }];
    [ExecutingHelper waitUntil:^BOOL{
        return finished == YES;
    }];
}

- (void)retrieveTestingSessionID {
    __block BOOL finished = NO;
    [[self.httpClient POST:@"/sessions" parameters:@{@"deviceId":self.deviceID,@"testSuiteId":self.testSuiteId}]
     subscribeNext:^(NSDictionary *response) {
         NSString *testingSession = response[@"_id"];
         NSLog(@"@API RESPONSE@ TESTING SESSION %@",testingSession);
         self.httpClient.testingSession = testingSession;
         finished = YES;
    } error:^(NSError *error) {
        finished = YES;
    }];
    [ExecutingHelper waitUntil:^BOOL{
        return finished == YES;
    }];
}

- (void)addTestCase:(NSString *)testCaseName {
    __block BOOL finished = NO;
    [[self.httpClient POST:@"/test-cases" parameters:@{@"name":testCaseName,@"description":@"There is no particular description for example test case"}]
     subscribeNext:^(NSDictionary *response) {
        
         finished = YES;
    } error:^(NSError *error) {
        finished = YES;
    }];
    [ExecutingHelper waitUntil:^BOOL{
        return finished == YES;
    }];
}

- (void)addTestMethod:(NSString *)testMethodName {
    __block BOOL finished = NO;
    [[self.httpClient POST:@"/name" parameters:@{@"name":testMethodName}]
     subscribeNext:^(NSDictionary *response) {
         
         finished = YES;
     } error:^(NSError *error) {
         finished = YES;
     }];
    [ExecutingHelper waitUntil:^BOOL{
        return finished == YES;
    }];
}

- (void)addLog:(NSString *)name description:(NSString *)description {
    __block BOOL finished = NO;
    [[self.httpClient POST:@"test-steps" parameters:@{}] subscribeNext:^(id x) {
        
    } error:^(NSError *error) {
        
    }];
    [ExecutingHelper waitUntil:^BOOL{
        return finished == YES;
    }];
}

- (void)logEventWithTitle:(NSString *)title andDescription:(NSDictionary *)info {
    NSDictionary *params = @{ @"title":title, @"info":info };
    [[self.httpClient POST:@"/events" parameters:params] subscribeNext:^(id x) {
        
    } error:^(NSError *error) {
        
    }];
}

@end
