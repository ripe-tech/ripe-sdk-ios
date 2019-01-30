#import <Foundation/Foundation.h>
#import "RipeObject.h"

NS_ASSUME_NONNULL_BEGIN

@protocol Interactable <NSObject>

@property (nonatomic, weak) RipeObject *owner;

- (void)update:(NSDictionary *)state;

@end

NS_ASSUME_NONNULL_END
