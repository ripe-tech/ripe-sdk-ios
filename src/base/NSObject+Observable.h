//
//  NSObject+Observable.h
//  ripe
//
//  Copyright © 2019 Platforme. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Observable)

@property (nonatomic, strong) NSMutableDictionary *callbacks;

- (void (^)(NSDictionary *response))bindToEvent:(NSString *)event withCallback:(void (^)(NSDictionary *response))callback;
- (void)unbindFromEvent:(NSString *)event withCallback:(void (^)(NSDictionary *response))callback;

@end

NS_ASSUME_NONNULL_END
