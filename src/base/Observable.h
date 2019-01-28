#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Observable <NSObject>

@property (nonatomic, strong) NSMutableDictionary *callbacks;

- (void (^)(NSDictionary *response))bindToEvent:(NSString *)event withCallback:(void (^)(NSDictionary *response))callback;
- (void)unbindFromEvent:(NSString *)event withCallback:(void (^)(NSDictionary *response))callback;

@end

NS_ASSUME_NONNULL_END
