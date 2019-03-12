#import "Dependencies.h"

@interface APITests : XCTestCase

@end

@implementation APITests

- (void)testGetSizes {
    XCTestExpectation *expectation = [self expectationWithDescription:@"should get sizes"];
    expectation.assertForOverFulfill = false;

    Ripe *instance = [[Ripe alloc] init];
    [instance getSizes:^(NSDictionary * _Nonnull response) {
        XCTAssertTrue([response[@"fr"] isEqualToArray:@[@"female"]]);
        XCTAssertTrue([response[@"uk"] isEqualToArray:(@[@"male", @"female"])]);
        [expectation fulfill];
    }];
    [self waitForExpectations:@[expectation] timeout:3];
};

- (void)testSizeToNative {
    XCTestExpectation *expectation = [self expectationWithDescription:@"should convert size to native"];
    expectation.assertForOverFulfill = false;

    Ripe *instance = [[Ripe alloc] init];
    [instance sizeToNative:@"fr" value:42 gender:@"female" callback:^(NSDictionary * _Nonnull response) {
        XCTAssertTrue([response[@"scale"] isEqual:@"fr"]);
        XCTAssertEqual([response[@"value"] doubleValue], 31);
        XCTAssertEqual([response[@"native"] doubleValue], 31);
        [expectation fulfill];
    }];
    [self waitForExpectations:@[expectation] timeout:3];
};

- (void)testSizeToNativeB {
    XCTestExpectation *expectation = [self expectationWithDescription:@"should convert size to native in bulk"];
    expectation.assertForOverFulfill = false;

    Ripe *instance = [[Ripe alloc] init];
    [instance sizeToNativeB:@[@"fr"] values:@[[NSNumber numberWithDouble:42]] genders:@[@"female"] callback:^(NSArray * _Nonnull response) {
        XCTAssertEqual(response.count, 1);
        XCTAssertTrue([response[0][@"scale"] isEqual:@"fr"]);
        XCTAssertEqual([response[0][@"value"] doubleValue], 31);
        XCTAssertEqual([response[0][@"native"] doubleValue], 31);
        [expectation fulfill];
    }];
    [self waitForExpectations:@[expectation] timeout:3];
};

- (void)testNativeToSize {
    XCTestExpectation *expectation = [self expectationWithDescription:@"should convert native to size"];
    expectation.assertForOverFulfill = false;

    Ripe *instance = [[Ripe alloc] init];
    [instance nativeToSize:@"fr" value:31 gender:@"female" callback:^(NSDictionary * _Nonnull response) {
        XCTAssertEqual([response[@"value"] doubleValue], 42);
        [expectation fulfill];
    }];
    [self waitForExpectations:@[expectation] timeout:3];
};

- (void)testNativeToSizeB {
    XCTestExpectation *expectation = [self expectationWithDescription:@"should convert native to size in bulk"];
    expectation.assertForOverFulfill = false;

    Ripe *instance = [[Ripe alloc] init];
    [instance nativeToSizeB:@[@"fr"] values:@[[NSNumber numberWithDouble:31]] genders:@[@"female"] callback:^(NSArray * _Nonnull response) {
        XCTAssertEqual(response.count, 1);
        XCTAssertEqual([response[0][@"value"] doubleValue], 42);
        [expectation fulfill];
    }];
    [self waitForExpectations:@[expectation] timeout:3];
};

@end
