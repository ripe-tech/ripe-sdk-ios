#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * A Promise implementation that simplifies asynchronous code.
 */
@interface Promise : NSObject

/**
 * Declaration of the Resolve block, used to resolve a promise with a result.
 *
 * @param result The result of the promise.
 */
typedef void (^Resolve)(id _Nullable result);

/**
 * Declaration of the Reject block, used to reject a promise with an error.
 *
 * @param error The error that caused the rejection.
 */
typedef void (^Reject)(NSError *error);

/**
 * Declaration of the Resolved block, used to handle the result of a promise.
 *
 * @param result The result of the promise.
 */
typedef void (^Resolved)(id _Nullable result);

/**
 * Declaration of the Rejected block, used to handle the rejection of a promise.
 *
 * @param error The error of the promise.
 */
typedef void (^Rejected)(NSError *error);

/**
 * Declaration of the Executor block, used to resolve or reject a promise.
 *
 * @param resolve The Resolve block to be called with a result.
 * @param reject The Reject block to be called with an error.
 */
typedef void (^Executor)(Resolve resolve, Reject reject);

/**
 * The block to be asynchronously executed that will resolve or reject the promise.
 */
@property (nonatomic, strong) Executor executor;

/**
 * The Resolved blocks to be called when the promise is resolved.
 */
@property (nonatomic, strong) NSMutableArray *resultObservers;

/**
 * The Rejected blocks to be called when the promise is rejected.
 */
@property (nonatomic, strong) NSMutableArray *errorObservers;


/**
 * If the promise has been resolved.
 */
@property BOOL resolved;

/**
 * The result of the promise in case it has been resolved.
 */
@property (nonatomic, strong) id _Nullable result;

/**
 * The error of the promise in case it has been rejected.
 */
@property (nonatomic, strong) NSError *error;

/**
 * The constructor of a Promise instance.
 *
 * @param executor The block to be asynchronously executed that will resolve or reject the promise.
 * @return The Promise instance created.
 */
- (instancetype)initWithExecutor:(Executor)executor;

/**
 * Calls the provided Resolved block with the result of the promise if it is resolved.
 *
 * @param resolved The Resolved block to be called.
 * @return The Promise instance itself.
 */
- (Promise *)then:(Resolved)resolved;

/**
 * Calls the provided Rejected block with an error caused by a rejection of the promise.
 *
 * @param rejected The Rejected block to be called.
 */
- (void)catch:(Rejected)rejected;

/**
 * Helper method that executes multiple promises in parallel and returns a Promise that is resolved when all the provided promises have finished executing.
 *
 * @param promises The promises to be executed.
 * @return A Promise instance where the result is a NSArray with the results of all the provided promises.
 */
+ (Promise *)all:(NSArray *)promises;

@end

NS_ASSUME_NONNULL_END
