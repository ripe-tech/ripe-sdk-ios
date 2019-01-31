#import "Ripe.h"

@implementation Ripe

@synthesize options = _options;


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

- (NSDictionary *)options {
    return _options;
}

- (void)setOptions:(NSDictionary *)options {
    _options = options;
    self.api.options = options;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([self.api respondsToSelector:aSelector]) {
        return self.api;
    }
    else {
        return nil;
    }
}

- (void)configWithBrand:(NSString *)brand andModel:(NSString *)model andOptions:(NSDictionary *)options {
    self.brand = brand;
    self.model = model;
    self.options = options;
}

@end
