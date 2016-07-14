//
//  HTTPClient.m
//  integration-example
//
//  Created by kudl helBell on 20/02/16.
//  Copyright © 2016 blow. All rights reserved.
//

#import "HTTPClient.h"




@implementation HTTPClient

- (instancetype)init {
    NSURL *base = [NSURL URLWithString:@"http://192.168.99.100:4000"];
    self = [super initWithBaseURL:base];
    if (self) {
        
    }
    return self;
}

- (RACSignal *)POST:(NSString *)URLString parameters:(id)parameters {
    @weakify(self)
    return [[RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        @strongify(self)
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        [self putHeaders:self.responseSerializer];
        
        typedef void (^SuccessBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject);
        SuccessBlock success = [self responseSuccess:subscriber];
        
        typedef void (^FailureBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject);
        FailureBlock failure = [self responseFailed:subscriber];

        NSURLSessionDataTask *requestTask = [self POST:URLString
                                            parameters:parameters
                                              progress:nil
                                               success:success
                                               failure:failure];
        
        return [RACDisposable disposableWithBlock:^{
            [requestTask cancel];
        }];
    }] catch:^RACSignal *(NSError *error) {
        return [RACSignal error:error];
    }];
}

- (void)putHeaders:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)requestSerializer {
    if (self.token)
    [self.requestSerializer setValue:self.token forHTTPHeaderField:@"X-Auth-Token"];
    if (self.token)
    [self.requestSerializer setValue:self.testingSession forHTTPHeaderField:@"X-Session-Id"];
}

- (void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))responseSuccess:(id<RACSubscriber>)subscriber {
    return ^(NSURLSessionDataTask *task, id responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *) task.response;
        NSInteger responseCode = response.statusCode;
        BOOL success = responseCode == 200;
        if (success) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } else {
            [subscriber sendError:[NSError new]];
        }
    };
}

- (void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))responseFailed:(id<RACSubscriber>)subscriber {
    return ^(NSURLSessionDataTask * task, NSError * error) {
        [subscriber sendError:error];
    };
}

@end
