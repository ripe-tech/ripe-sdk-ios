#import "Dependencies.h"

@interface ObservableTests : XCTestCase

@end

@implementation ObservableTests


- (void)testBindAndUnbind {
    Observable *observable = [Observable new];
    Callback callback = [observable bind:@"test" callback:^(NSDictionary * response) {}];
    XCTAssertEqual([observable.callbacks[@"test"] count], 1);
    XCTAssertEqual((Callback) observable.callbacks[@"test"][0], callback);

    [observable unbind:@"test" callback:callback];
    XCTAssertEqual([observable.callbacks[@"test"] count], 0);
}

-(void)testTrigger {
    XCTestExpectation *expectationSync = [self expectationWithDescription:@"should trigger sync callback"];
    XCTestExpectation *expectationASync = [self expectationWithDescription:@"should trigger async callback"];
    XCTestExpectation *expectationAll = [self expectationWithDescription:@"should trigger when all callbacks are done"];

    Observable *observable = [Observable new];

    [observable bindSync:@"test" callback:^(NSDictionary *response) {
        [expectationSync fulfill];
    }];

    [observable bindAsync:@"test" callback:^Promise *(NSDictionary *response) {
        return [[Promise alloc] initWithExecutor:^(Resolve resolve, Reject reject) {
            [NSThread sleepForTimeInterval:1];
            resolve(response);
            [expectationASync fulfill];
        }];
    }];

    Promise *promise = [observable trigger:@"test"];
    [promise then:^(id result) {
        NSArray *results = (NSArray *)result;
        XCTAssertEqual(results.count, 2);
        [expectationAll fulfill];
    }];

    [self waitForExpectationsWithTimeout:4 handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
    }];
}

@end
