//
//  HTTPClient.h
//  integration-example
//
//  Created by kudl helBell on 20/02/16.
//  Copyright © 2016 blow. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "AFHTTPSessionManager.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface HTTPClient : AFHTTPSessionManager

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *testingSession;


- (RACSignal *)POST:(NSString *)URLString parameters:(id)parameters;


@end
