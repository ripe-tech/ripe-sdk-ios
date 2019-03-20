#import "Plugin.h"

NS_ASSUME_NONNULL_BEGIN

@interface SyncPlugin : Plugin

@property (nonatomic) NSDictionary *rules;

@property (nonatomic) BOOL manual;

@property (nonatomic) Callback _Nullable postConfigBind;

@property (nonatomic) Callback _Nullable partBind;

- (id)initWithRules:(NSDictionary *)rules;

- (id)initWithRules:(NSDictionary *)rules andOptions:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
