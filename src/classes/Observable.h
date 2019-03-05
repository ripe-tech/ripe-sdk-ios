#import "Promise.h"

NS_ASSUME_NONNULL_BEGIN

/**
 An object that emits events. Listeners can bind to specific events and be notified when the event is triggered.
 */
@interface Observable : NSObject

/**
 A function to be executed when an event. It receives a dictionary with the response as parameter and returns a promise which is resolved asynchronously.

 @param response A dictionary with the payload of the event
 @return A Promise that may be resolved asynchronously
 */
typedef Promise * (^Callback)(NSDictionary *response);

/**
 A dictionary that contains all methods to be executed when an event is triggered
 */
@property (nonatomic, strong) NSMutableDictionary *callbacks;

/**
 Binds to an event by providing a block that will receive the event payload as a parameter. The block will be executed synchronously, for costly operations prefer the use of bindSync:callback:.

 @param event Name of the event to bind to
 @param callback Block to be executed synchronously when the event is triggered
 @return Returns the callback instance created, to be used when unbinding from the event
 */
- (Callback)bind:(NSString *)event callback:(void (^)(NSDictionary *response))callback;

/**
 Binds to an event by providing a block that will receive the event payload as a parameter. The block will be executed synchronously, for costly operations prefer the use of bindSync:callback:.

 @param event Name of the event to bind to
 @param callback Block to be executed synchronously when the event is triggered
 @return Returns the callback instance created, to be used when unbinding from the event
 */
- (Callback)bindSync:(NSString *)event callback:(void (^)(NSDictionary *response))callback;

/**
 Binds to an event by providing a block that will receive the event payload as a parameter and return a Promise that will be resolved asynchronously.

@param event Name of the event to bind to
@param callback Block to be executed when the event is triggered
@return Returns the provided callback, to be used when unbinding from the event
*/
- (Callback)bindAsync:(NSString *)event callback:(Callback)callback;

/**
 Unbinds the provided callback from an event.

 @param event The name of the event
 @param callback The callback that was returned when the bind method was called.
 */
- (void)unbind:(NSString *)event callback:(Callback)callback;

/**
 Triggers the event by calling all its bound callbacks with args as parameters.

 @param event The name of the event to be triggered
 @param args The payload of the event, to be passed to the callbacks
 @return Returns a promise that will be resolved when all of the callbacks
 have finished processing the triggered event
 */
- (Promise *)trigger:(NSString *)event args:(NSDictionary * _Nullable)args;

/**
  Triggers the event by calling all its bound callbacks.

 @param event The name of the event
 @return Returns a promise that will be resolved when all of the callbacks
 have finished processing the triggered event
 */
- (Promise *)trigger:(NSString *)event;

@end

NS_ASSUME_NONNULL_END
