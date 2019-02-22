#import "Interactable.h"
#import "Image.h"
#import "BaseAPI.h"
#import "Ripe.h"

@implementation Ripe

@synthesize options = _options;

- (id)initWithBrand:(NSString *)brand andModel:(NSString *)model {
    return [self initWithBrand:brand andModel:model andOptions:[NSDictionary new]];
}

-(id)initWithBrand:(NSString *)brand andModel:(NSString *)model andOptions:(NSDictionary *)options {
    self = [super init];
    if (self) {
        self.api = [[BaseAPI alloc] initWithOwner:self andOptions:options];
        self.children = [NSMutableArray new];
        [self setOptions:options];
        [self configWithBrand:brand andModel:model andOptions:options];
    }
    return self;
}

- (NSDictionary *)options {
    return _options;
}

- (void)setOptions:(NSDictionary *)options {
    _options = options;
    id parts = options[@"parts"];
    id useDefaults = options[@"useDefaults"];
    id usePrice = options[@"usePrice"];

    if ([parts isKindOfClass:[NSDictionary class]]) {
        self.parts = [parts mutableCopy];
    }

    if (useDefaults != nil) {
        self.useDefaults = [useDefaults boolValue];
    }

    if (usePrice != nil) {
        self.useDefaults = [usePrice boolValue];
    }
    [self.api setOptions:[self.options copy]];
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
    // updates the current references to both the brand
    // and the model according to the new configuration
    // request (update before remote update)
    self.brand = brand;
    self.model = model;

    // sets the new options using the current options
    // as default values and sets the update flag to
    // true if it is not set
    NSMutableDictionary *newOptions = [self.options mutableCopy];
    newOptions[@"update"] = @(true);
    [newOptions setValuesForKeysWithDictionary:options];
    [self setOptions:newOptions];

    // determines if a valid model is currently defined for the ripe
    // instance, as this is going to change some logic behaviour
    BOOL hasModel = self.brand != nil && self.model != nil;

    // retrieves the configuration for the currently loaded model so
    // that others may use it freely (cache mechanism)
    void (^callback)(NSDictionary *) = ^void (NSDictionary *response) {
        self.loadedConfig = response;

        // determines if the defaults for the selected model should
        // be loaded so that the parts structure is initially populated
        BOOL hasParts = [self.parts count] == 0;
        BOOL loadDefaults = !hasParts && self.useDefaults && hasModel;

        // in case the current instance already contains configured parts
        // the instance is marked as ready (for complex resolution like price)
        // for cases where this is the first configuration (not an update)
        id optionsUpdate = self.options[@"options"];
        BOOL update = optionsUpdate != nil ? [optionsUpdate boolValue] : true;
        self.ready = update ? self.ready : hasParts;

        // triggers the config event notifying any listener that the (base)
        // configuration for this main RIPE instance has changed
        [self triggerEvent:@"config" withArgs:self.loadedConfig];

        // determines the proper initial parts for the model taking into account
        // if the defaults should be loaded
        NSDictionary *parts = loadDefaults ? self.loadedConfig[@"defaults"] : self.parts;
        if (!self.ready) {
            self.ready = true;
            [self triggerEvent:@"ready"];
        }

        // in case there's no model defined in the current instance then there's
        // nothing more possible to be done, reeturns the control flow
        if (!hasModel) {
            return;
        }

        // updates the parts of the current instance and triggers the remove and
        // local update operations, as expected
        [self setParts:parts.mutableCopy];
        [self update];
    };

    hasModel ? [self.api getConfigWithCallback:callback] : callback(nil);
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
    for (id<Interactable> child in self.children) {
        [child update:state];
    }

    if (self.ready) [self triggerEvent:@"update"];

    if (self.ready && self.usePrice) {
        [self.api getConfigWithCallback:^(NSDictionary *response) {

        }];
    }
}

- (NSDictionary *)_getstate {
    //TODO
    return [NSDictionary new];
}

@end
