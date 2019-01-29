#import <XCTest/XCTest.h>
#import "../base/Ripe.h"

@interface ObservableTests : XCTestCase

@end

@implementation ObservableTests


- (void)testBindAndUnbind {
    Ripe *observable = [Ripe new];
    void (^callback)(NSDictionary *response) = ^(NSDictionary *response) {};
    void (^_callback)(NSDictionary *response) = [observable bindToEvent:@"test" withCallback:callback];
    XCTAssertEqual(callback, _callback);
    XCTAssertEqual([observable.callbacks[@"test"] count], 1);

    [observable unbindFromEvent:@"test" withCallback:callback];
    XCTAssertEqual([observable.callbacks[@"test"] count], 0);
}

@end
