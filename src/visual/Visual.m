#import "Visual.h"

@implementation Visual

@synthesize owner;

-(id)initWithOwner:(Ripe *)owner andOptions:(NSDictionary *)options {
    self = [super init];
    if (self) {
        self.owner = owner;
        self.options = options;
    }
    return self;
}

- (void)update:(NSDictionary *)state {}

@end
