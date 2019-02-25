#import <XCTest/XCTest.h>
#import "Promise.h"

@interface PromiseTests : XCTestCase

@end

@implementation PromiseTests

- (void)testResolve {
    XCTestExpectation *expectation = [self expectationWithDescription:@"should resolve promise"];
    expectation.assertForOverFulfill = true;
    
    NSString *test = @"test";
    Promise *promise = [[Promise alloc] initWithExecutor:^(Resolve resolve, Reject reject) {
        [NSThread sleepForTimeInterval:1];
        resolve(test);
    }];
    
    [promise then:^(id result) {
        NSString *resultS = (NSString *)result;
        XCTAssertEqual(resultS, test);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:2 handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        
        XCTestExpectation *secondExpectation = [self expectationWithDescription:@"should resolve promise with previous result"];
        secondExpectation.assertForOverFulfill = true;
        
        [promise then:^(id result) {
            NSString *resultS = (NSString *)result;
            XCTAssertEqual(resultS, test);
            [secondExpectation fulfill];
        }];
        [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
            }
        }];
    }];
};

- (void)testReject {
    XCTestExpectation *expectation = [self expectationWithDescription:@"should reject promise"];
    expectation.assertForOverFulfill = true;
    
    NSError *rejection = [NSError errorWithDomain:NSCocoaErrorDomain code:1 userInfo:nil];
    Promise *promise = [[Promise alloc] initWithExecutor:^(Resolve resolve, Reject reject) {
        reject(rejection);
    }];

    [promise catch:^(NSError *error) {
        XCTAssertEqual(error, rejection);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:3 handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
    }];
};

- (void)testAll {
    XCTestExpectation *expectation = [self expectationWithDescription:@"should resolve promise"];
    expectation.assertForOverFulfill = true;
    
    NSString *test = @"test";
    Promise *promise1 = [[Promise alloc] initWithExecutor:^(Resolve resolve, Reject reject) {
        [NSThread sleepForTimeInterval:1];
        resolve(test);
    }];
    
    Promise *promise2 = [[Promise alloc] initWithExecutor:^(Resolve resolve, Reject reject) {
        [NSThread sleepForTimeInterval:1];
        resolve(test);
    }];
    
    Promise *promise3 = [[Promise alloc] initWithExecutor:^(Resolve resolve, Reject reject) {
        [NSThread sleepForTimeInterval:2];
        resolve(test);
    }];
    
    Promise *promiseAll = [Promise all:@[promise1, promise2, promise3]];
    [promiseAll then:^(id result) {
        NSArray *results = (NSArray *)result;
        XCTAssertEqual(results.count, 3);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:3 handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
    }];
};

@end
