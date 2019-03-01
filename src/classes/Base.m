#import "Interactable.h"
#import "Image.h"
#import "BaseAPI.h"
#import "BaseAPI+BrandAPI.h"
#import "Base.h"

@implementation Ripe

@dynamic url;

@synthesize parts = _parts;
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
        _parts = [NSMutableDictionary new];
        self.usePrice = true;
        self.useDefaults = true;
        [self setOptions:options];
        [self config:brand model:model options:options];
    }
    return self;
}

- (NSMutableDictionary *)parts {
    return _parts;
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

- (void)setPart:(NSString *)part material:(NSString *)material color:(NSString *)color {
    [self setPart:part material:material color:color noEvents:false];
}

- (void)setPart:(NSString *)part material:(NSString *)material color:(NSString *)color noEvents:(BOOL)noEvents {
    [self setPart:part material:material color:color noEvents:noEvents options:[NSDictionary new]];
}

- (void)setPart:(NSString *)part material:(NSString *)material color:(NSString *)color noEvents:(BOOL)noEvents options:(NSDictionary *)options {
    if (noEvents) {
        return [self _setPart:part material:material color:color noEvents:false];
    }

    NSDictionary *value = @{@"parts": self.parts, @"options": options };
    [self trigger:@"pre_part" args:value];
    [self _setPart:part material:material color:color noEvents:false];
    [self trigger:@"part" args:value];
    [self trigger:@"post_part" args:value];
}

- (void)setParts:(NSDictionary *)parts {
    [self setParts:parts noEvents:false options:[NSDictionary new]];
}

- (void)setParts:(NSDictionary *)parts noEvents:(BOOL)noEvents {
    [self setParts:parts noEvents:noEvents options:[NSDictionary new]];
}

- (void)setParts:(NSDictionary *)parts noEvents:(BOOL)noEvents options:(NSDictionary *)options {
    NSArray *partsList = [self _partsList:parts];
    [self setPartsList:partsList noEvents:noEvents options:options];
}

- (void)setPartsList:(NSArray *)partsList {
    [self setPartsList:partsList noEvents:false options:[NSDictionary new]];
}

- (void)setPartsList:(NSArray *)partsList noEvents:(BOOL)noEvents {
    [self setPartsList:partsList noEvents:noEvents options:[NSDictionary new]];
}

- (void)setPartsList:(NSArray *)partsList noEvents:(BOOL)noEvents options:(NSDictionary *)options {
    BOOL noPartEvent = [options[@"noPartEvent"] boolValue] ?: false;

    if (noEvents) {
        return [self setPartsList:partsList noEvents:noPartEvent];
    }
    NSDictionary *value = @{@"parts": self.parts, @"options": options };
    [self trigger:@"pre_parts" args:value];
    [self _setParts:partsList noEvents:noEvents];
    [self trigger:@"parts" args:value];
    [self trigger:@"post_parts" args:value];
}

- (void)setInitials:(NSString *)initials engraving:(NSString *)engraving {
    [self setInitials:initials engraving:engraving noUpdate:false];
}

- (void)setInitials:(NSString *)initials engraving:(NSString *)engraving noUpdate:(BOOL)noUpdate {
    self.initials = initials;
    self.engraving = engraving;

    if (noUpdate) {
        return;
    }

    [self update];
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

- (void)_setPart:(NSString *)part material:(NSString * _Nullable)material color:(NSString * _Nullable)color noEvents:(BOOL)noEvents {
    // ensures that there's one valid configuration loaded
    // in the current instance, required for part setting
    if (self.loadedConfig == nil) {
        @throw [NSException exceptionWithName:@"setPartException"
                                       reason:@"Model config is not loaded"
                                     userInfo:nil
                ];
    }

    // if the material or color are not set then this
    // is considered a removal operation and the part
    // is removed from the parts structure if it's
    // optional or an error is thrown if it's required
    NSDictionary *defaults = self.loadedConfig[@"defaults"];
    NSDictionary *partInfo = defaults[@"part"];
    BOOL isOptional = [partInfo[@"optional"] boolValue] ?: false;
    BOOL isRequired = !isOptional;
    BOOL remove = material == nil && color == nil;
    if (isRequired && remove) {
        NSString *error = [NSString stringWithFormat:@"Part %@ can't be removed", part];
        @throw [NSException exceptionWithName:@"setPartException"
                                       reason:error
                                     userInfo:nil
                ];
    }

    NSMutableDictionary *value = self.parts[part] ?: [NSMutableDictionary new];
    value[@"material"] = remove ? NSNull.null : material;
    value[@"color"] = remove ? NSNull.null : color;

    if (noEvents) {
        if (remove) {
            [_parts removeObjectForKey:part];
        } else {
            [_parts setObject:value forKey:part];
        }
        return;
    }

    NSDictionary *eventValue = @{ @"part": part, @"value": value };
    [self trigger:@"pre_part" args:eventValue];
    if (remove) {
        [_parts removeObjectForKey:part];
    } else {
        [_parts setObject:value forKey:part];
    }
    [self trigger:@"part" args:eventValue];
    [self trigger:@"post_part" args:eventValue];
}

- (void)_setParts:(NSArray *)parts noEvents:(BOOL)noEvents {
    for(id value in parts) {
        NSArray *part = (NSArray *)value;
        [self _setPart:part[0] material:part[1] color:part[2] noEvents:noEvents];
    }
}

- (NSDictionary *)_getstate {
    NSDictionary *parts = self.parts ?: [NSDictionary new];
    NSString *initials = self.initials ?: @"";
    NSString *engraving = self.engraving ?: @"";
    return @{ @"parts": parts, @"initials": initials, @"engraving": engraving };
}

- (NSArray *)_partsList:(NSDictionary *)parts {
    NSMutableArray *partsList = [NSMutableArray new];
    for (id key in parts) {
        NSString *part = (NSString *)key;
        NSDictionary *value = parts[part];
        [partsList addObject:@[key, value[@"material"], value[@"color"]]];
    }
    return partsList;
}

@end