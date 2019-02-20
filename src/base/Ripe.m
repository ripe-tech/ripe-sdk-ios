#import "Interactable.h"
#import "Image.h"
#import "Ripe.h"

@implementation Ripe

@synthesize options = _options;

- (id)initWithBrand:(NSString *)brand andModel:(NSString *)model {
    return [self initWithBrand:brand andModel:model andOptions:[NSDictionary new]];
}

-(id)initWithBrand:(NSString *)brand andModel:(NSString *)model andOptions:(NSDictionary *)options {
    self = [super init];
    if (self) {
        self.brand = brand;
        self.model = model;
        self.options = options;
        self.api = [[BaseAPI alloc] initWithOptions:options];
        self.children = [NSMutableArray new];
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

- (void)configWithBrand:(NSString *)brand andModel:(NSString *)model {
    [self configWithBrand:brand andModel:model andOptions:[NSDictionary new]];
}

- (void)configWithBrand:(NSString *)brand andModel:(NSString *)model andOptions:(NSDictionary *)options {
    self.brand = brand;
    self.model = model;
    self.options = options;
}

- (Interactable *)bindInteractable:(Interactable *)interactable {
    [self.children addObject:interactable];
    return interactable;
}

- (Image *)bindImageWithImageView:(UIImageView *)imageView {
    return [self bindImageWithImageView:imageView andOptions:[NSDictionary new]];
}

- (Image *)bindImageWithImageView:(UIImageView *)imageView andOptions:(NSDictionary *)options {
    Image *image = [[Image alloc] initWithImageView:imageView andOwner:self andOptions:options];
    [self bindInteractable:(Interactable *)image];
    return image;
}

- (void)unbindInteractable:(Interactable *)interactable {
    [self.children removeObject:interactable];
}

- (void)unbindImage:(Image *)image {
    [self unbindInteractable:(Interactable *)image];
}

- (void)update {
    NSDictionary *state = [self _getstate];
    [self update:state];
}

- (void)update:(NSDictionary *)state {
    state = state != nil ? state : [self _getstate];
    
    for (id<Interactable> child in self.children) {
        [child update:state];
    }
}
         
- (NSDictionary *)_getstate {
    //TODO
    return [NSDictionary new];
}

@end
