#import "Dependencies.h"

@interface SyncTests : XCTestCase

@end

@implementation SyncTests

- (void)testConfigSync {
    XCTestExpectation *expectation = [self expectationWithDescription:@"should trigger post_parts"];
    expectation.assertForOverFulfill = false;

    SyncPlugin *syncPlugin = [[SyncPlugin alloc] init];
    Ripe *instance = [[Ripe alloc] initWithBrand:@"swear" model:@"vyner" options:@{ @"plugins": @[syncPlugin] }];
    [instance bind:@"post_config" callback:^(NSDictionary * _Nonnull response) {
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:3 handler:^(NSError * _Nullable error) {
        XCTAssertEqualObjects(instance.parts[@"hardware"][@"color"], @"silver");
        XCTAssertEqualObjects(instance.parts[@"logo"][@"color"], @"silver");
        
        [instance setPart:@"hardware" material:@"metal" color:@"bronze"];
        
        XCTAssertEqualObjects(instance.parts[@"hardware"][@"color"], @"bronze");
        XCTAssertEqualObjects(instance.parts[@"logo"][@"color"], @"bronze");
    }];
}

@end
