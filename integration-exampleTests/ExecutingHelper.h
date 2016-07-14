//
//  ExecutingHelper.h
//  integration-example
//
//  Created by kudl helBell on 20/02/16.
//  Copyright © 2016 blow. All rights reserved.
//

@import Foundation;

@interface ExecutingHelper : NSObject

+ (void)wait:(NSTimeInterval)time;

+ (void)waitUntil:(BOOL (^)())condition;

@end
