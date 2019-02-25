#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Promise : NSObject

typedef void (^Resolve)(id _Nullable result);
typedef void (^Reject)(NSError *error);
typedef void (^Resolved)(id _Nullable result);
typedef void (^Rejected)(NSError *error);
typedef void (^Executor)(Resolve resolve, Reject reject);

@property (nonatomic, strong) Executor executor;
@property (nonatomic, strong) NSMutableArray *resultObservers;
@property (nonatomic, strong) NSMutableArray *errorObservers;
@property BOOL resolved;
@property (nonatomic, strong) id _Nullable result;
@property (nonatomic, strong) NSError *error;

- (instancetype)initWithExecutor:(Executor)executor;
- (void)resolve:(id _Nullable)result;
- (void)reject:(NSError *)error;
- (void)then:(Resolved)resolved;
- (void)catch:(Rejected)rejected;
+ (Promise *)all:(NSArray *)promises;

@end

NS_ASSUME_NONNULL_END
