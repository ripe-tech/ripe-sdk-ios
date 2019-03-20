#import "Ripe.h"
#import "SyncPlugin.h"

@implementation SyncPlugin

- (id)initWithRules:(NSDictionary *)rules {
    return [self initWithRules:rules andOptions:[NSDictionary new]];
}

- (id)initWithRules:(NSDictionary *)rules andOptions:(NSDictionary *)options {
    self = [super initWithOptions:options];
    if (self) {
        self.rules = [self normalizeRules:rules];
        self.manual = [options[@"manual"] boolValue] ?: true;
    }
    return self;
}

- (id)initWithOptions:(NSDictionary *)options {
    self = [super initWithOptions:options];
    if (self) {
        self.manual = [options[@"manual"] boolValue] ?: false;
    }
    return self;
}

- (void)register:(Ripe *)owner {
    [super register:owner];
    if (!self.manual && owner.loadedConfig != nil) {
        self.rules = [self normalizeRules:owner.loadedConfig[@"sync"]];
    }

    self.postConfigBind = self.manual ? nil : [owner bind:@"post_config" callback:^(NSDictionary * _Nonnull response) {
        self.rules = [self normalizeRules:owner.loadedConfig[@"sync"]];
    }];

    self.partBind = [owner bind:@"part" callback:^(NSDictionary * _Nonnull response) {
        [self applySync:response[@"part"] partValue:response[@"value"]];
    }];
}

- (void)unregister {
    [self.owner unbind:@"part" callback:self.partBind];
    [self.owner unbind:@"post_config" callback:self.postConfigBind];

    [super unregister];
}

- (NSDictionary *)normalizeRules:(NSDictionary *)rules {
    NSMutableDictionary *result = [NSMutableDictionary new];
    for(NSString *ruleName in rules) {
        NSMutableArray *rule = [rules[ruleName] mutableCopy];
        for (int index = 0; index < rule.count; index++) {
            id part = rule[index];
            if ([part isKindOfClass:NSString.class]) {
                rule[index] = @{ @"part": part };
            }
        }
        result[ruleName] = rule;
    }
    return result;
}

- (void)applySync:(NSString *)partName partValue:(NSDictionary *)partValue {
    for (NSString *key in self.rules) {
        // if a part was selected and it is part of
        // the rule then its value is used otherwise
        // the first part of the rule is used
        NSArray *rule = self.rules[key];
        NSDictionary *firstPart = rule[0];
        NSString *name = partName ?: firstPart[@"part"];
        NSDictionary *value = partValue ?: firstPart[@"value"];

        // checks if the part triggers the sync rule
        // and skips to the next rule if it doesn't
        if (![self shouldSync:rule name:name value:value]) {
            continue;
        }

        // iterates through the parts of the rule and
        // sets their material and color according to
        // the sync rule in case there's a match
        for (NSDictionary *part in rule) {
            // in case the current rule definition references the current
            // part in rule definition, ignores the current loop
            NSString *rulePart = part[@"part"];
            NSString *ruleMaterial = part[@"material"];
            NSString *ruleColor = part[@"color"];
            if ([rulePart isEqualToString:name]) {
                continue;
            }

            // tries to find the target part configuration an in case
            // no such part is found throws an error
            NSMutableDictionary *target = self.owner.parts[rulePart];
            if (!target) {
                NSString *error = [NSString stringWithFormat:@"Target part for rule not found %@", rulePart];
                @throw [NSException exceptionWithName:@"SyncPlugin"
                                               reason:error
                                             userInfo:nil];
            }
            if (ruleColor == nil) {
                target[@"material"] = ruleMaterial ?: value[@"material"];
            }

            target[@"color"] = ruleColor ?: value[@"color"];
        }
    }
}

- (BOOL)shouldSync:(NSArray *)rules name:(NSString *)name value:(NSDictionary *)value {
    for(NSDictionary *rule in rules) {
        NSString *part = rule[@"part"];
        NSString *material = rule[@"material"];
        NSString *color = rule[@"color"];
        BOOL materialSync = material == nil || [material isEqualToString:value[@"material"]];
        BOOL colorSync = color == nil || [color isEqualToString:value[@"color"]];
        if ([part isEqualToString:name] && materialSync && colorSync) {
            return true;
        }
    }
    return false;
}

@end
