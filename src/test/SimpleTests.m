#import "Dependencies.h"

@interface SimpleTests : XCTestCase

@end

@implementation SimpleTests

- (void)testUndoSetParts {
    XCTestExpectation *expectation = [self expectationWithDescription:@"should trigger post_parts"];
    expectation.assertForOverFulfill = false;

    Ripe *instance = [[Ripe alloc] initWithBrand:@"swear" model:@"vyner"];
    __block NSDictionary *initialParts;
    [instance bind:@"post_parts" callback:^(NSDictionary *response) {
        [expectation fulfill];
        initialParts = response[@"parts"];
    }];

    [self waitForExpectationsWithTimeout:3 handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }

        XCTAssertEqual(initialParts, instance.parts);
        XCTAssertEqual([instance canUndo], false);
        XCTAssertEqual([instance canRedo], false);

        [instance undo];
        XCTAssertEqual(initialParts, instance.parts);
        XCTAssertEqual([instance canUndo], false);
        XCTAssertEqual([instance canRedo], false);

        NSDictionary *front = instance.parts[@"front"];
        XCTAssertEqualObjects(front[@"material"], @"nappa");
        XCTAssertEqualObjects(front[@"color"], @"white");

        [instance setPart:@"front" material:@"suede" color:@"black"];
        front = instance.parts[@"front"];
        XCTAssertEqualObjects(front[@"material"], @"suede");
        XCTAssertEqualObjects(front[@"color"], @"black");
        XCTAssertEqual([instance canUndo], true);
        XCTAssertEqual([instance canRedo], false);

        [instance undo];

        front = instance.parts[@"front"];
        XCTAssertEqualObjects(front[@"material"], @"nappa");
        XCTAssertEqualObjects(front[@"color"], @"white");
        XCTAssertEqual([instance canUndo], false);
        XCTAssertEqual([instance canRedo], true);

        [instance redo];

        front = instance.parts[@"front"];
        XCTAssertEqual(front[@"material"], @"suede");
        XCTAssertEqual(front[@"color"], @"black");
        XCTAssertEqual([instance canUndo], true);
        XCTAssertEqual([instance canRedo], false);
    }];
};

@end
