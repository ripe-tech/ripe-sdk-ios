#import "Interactable.h"
#import "Image.h"
#import "BaseAPI.h"
#import "BaseAPI+BrandAPI.h"
#import "Ripe.h"

@implementation Ripe

@dynamic url;

@synthesize options = _options;

- (id)initWithOptions:(NSDictionary *)options {
    return [self initWithBrand:nil model:nil options:options];
}

- (id)initWithBrand:(NSString *)brand model:(NSString *)model {
    return [self initWithBrand:brand model:model options:[NSDictionary new]];
}

-(id)initWithBrand:(NSString *)brand model:(NSString *)model options:(NSDictionary *)options {
    self = [super init];
    if (self) {
        self.api = [[BaseAPI alloc] initWithOwner:self options:options];
        self.children = [NSMutableArray new];
        self.usePrice = true;
        self.useDefaults = true;
        [self setOptions:options];
        [self config:brand model:model options:options];
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
        return [super forwardingTargetForSelector:aSelector];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [super respondsToSelector:aSelector] || [self.api respondsToSelector:aSelector];
}

- (Promise *)config:(NSString *)brand model:(NSString *)model {
    return [self config:brand model:model options:[NSDictionary new] callback:nil];
}

- (Promise *)config:(NSString *)brand model:(NSString *)model options:(NSDictionary *)options {
    return [self config:brand model:model options:options callback:nil];
}

- (Promise *)config:(NSString *)brand model:(NSString *)model options:(NSDictionary *)options callback:(void (^ _Nullable)(NSDictionary * _Nullable))callback {
    return [[Promise alloc] initWithExecutor:^(Resolve resolve, Reject reject) {
        // triggers the 'pre_config' event so that
        // the listeners can cleanup if needed
        Promise *preConfig = [self trigger:@"pre_config"];
        [preConfig then:^(id result) {
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
                BOOL hasParts = self.parts.count > 0;
                BOOL loadDefaults = !hasParts && self.useDefaults && hasModel;

                // in case the current instance already contains configured parts
                // the instance is marked as ready (for complex resolution like price)
                // for cases where this is the first configuration (not an update)
                id optionsUpdate = self.options[@"options"];
                BOOL update = optionsUpdate != nil ? [optionsUpdate boolValue] : true;
                self.ready = update ? self.ready : hasParts;

                // triggers the config event notifying any listener that the (base)
                // configuration for this main RIPE instance has changed
                Promise *config = [self trigger:@"config" args:self.loadedConfig];
                [config then:^(id  _Nullable result) {
                    // determines the proper initial parts for the model taking into account
                    // if the defaults should be loaded
                    NSDictionary *parts = loadDefaults ? self.loadedConfig[@"defaults"] : self.parts;
                    if (!self.ready) {
                        self.ready = true;
                        [self trigger:@"ready"];
                    }

                    // in case there's no model defined in the current instance then there's
                    // nothing more possible to be done, reeturns the control flow
                    if (!hasModel) {
                        [[self trigger:@"post_config"] then:^(id result) {
                            resolve(nil);
                        }];
                        return;
                    }

                    // updates the parts of the current instance and triggers the remove and
                    // local update operations, as expected
                    [self setParts:parts.mutableCopy];
                    [self update];
                    [[self trigger:@"post_config"] then:^(id result) {
                        resolve(nil);
                    }];
                }];
            };
            hasModel ? [self.api getConfig:callback] : callback(nil);
        }];
    }];
}

- (Interactable *)bindInteractable:(Interactable *)interactable {
    [self.children addObject:interactable];
    return interactable;
}

- (Image *)bindImage:(UIImageView *)imageView {
    return [self bindImage:imageView options:[NSDictionary new]];
}

- (Image *)bindImage:(UIImageView *)imageView options:(NSDictionary *)options {
    Image *image = [[Image alloc] initWithImageView:imageView owner:self options:options];
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

    if (self.ready) [self trigger:@"update"];

    if (self.ready && self.usePrice) {
        [self getPrice:^(NSDictionary *response) {
            [self trigger:@"price" args:response];
        }];
    }
}

- (NSDictionary *)_getstate {
    //TODO
    NSDictionary *parts = self.parts ?: [NSDictionary new];
    return @{ @"parts": parts };
}


@end
