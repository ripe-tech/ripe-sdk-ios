#import "Ripe.h"

@implementation Ripe

-(id)initWithBrand:(NSString *)brand andModel:(NSString *)model andOptions:(NSDictionary *)options {
    self = [super init];
    if (self) {
        self.brand = brand;
        self.model = model;
        self.options = options;
        self.api = [[BaseAPI alloc] initWithOptions:options];
    }
    return self;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([self.api respondsToSelector:aSelector]) {
        return self.api;
    }
    else {
        return nil;
    }
}

@end
