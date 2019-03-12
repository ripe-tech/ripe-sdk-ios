#import "BaseAPI+BuildAPI.h"

@implementation BaseAPI (BuildAPI)

- (void)getLocaleModel:(void (^)(NSDictionary * _Nonnull))callback {
    [self getLocaleModel:[NSDictionary new] callback:callback];
}

- (void)getLocaleModel:(NSDictionary *)options callback:(void (^)(NSDictionary * _Nonnull))callback {
    options = [self _getLocaleModelOptions:options];
    options = [self _build:options];
    [self _cacheURL:options[@"url"] options:options callback:callback];
}

- (NSDictionary *)_getLocaleModelOptions:(NSDictionary *)options {
    NSString *brand = options[@"brand"] ?: self.owner.brand;
    NSString *model = options[@"model"] ?: self.owner.model;
    NSString *locale = options[@"locale"] ?: self.owner.locale;

    NSString *url = [NSString stringWithFormat:@"%@builds/%@/locale/%@", self.url, brand, locale];
    NSMutableDictionary *params = [NSMutableDictionary new];
    if (model != nil) {
        params[@"model"] = model;
    }
    if (options[@"compatibility"] != nil) {
        params[@"compatibility"] = options[@"compatibility"] ? @"1" : @"0";
    }
    if (options[@"prefix"] != nil) {
        params[@"prefix"] = options[@"prefix"];
    }

    NSMutableDictionary *localeOptions = [NSMutableDictionary new];
    [localeOptions setValuesForKeysWithDictionary:@{
        @"url": url,
        @"method": @"GET",
        @"params": params
    }];
    return localeOptions;
}

@end
