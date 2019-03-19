#import "Ripe.h"
#import "Plugin.h"


@implementation Plugin

- (id)init {
    return [self initWithOptions:[NSDictionary new]];
}

- (id)initWithOptions:(NSDictionary *)options {
    self = [super init];
    if (self) {
        self.options = options;
    }
    return self;
}

- (void)register:(Ripe *)owner {
    self.owner = owner;
}

- (void)unregister {
    self.owner = nil;
}

@end
