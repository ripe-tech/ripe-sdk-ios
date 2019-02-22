#import "BaseAPI+BrandAPI.h"

@implementation BaseAPI (BrandAPI)

- (void)getConfigWithCallback:(void (^)(NSDictionary *))callback {
    [self getConfigWithOptions:nil andCallback:callback];
}

- (void)getConfigWithOptions:(NSDictionary *)options andCallback:(void (^)(NSDictionary *))callback {
    NSDictionary *configOptions = [self _getConfigOptions:options];
    configOptions = [self _build:configOptions];
    [self _cacheURL:configOptions[@"url"] withOptions:configOptions andCallback:callback];
}

- (NSDictionary *)_getConfigOptions:(NSDictionary *)options {
    options = options ?: [NSDictionary new];
    NSString *brand = options[@"brand"] ?: self.owner.brand;
    NSString *model = options[@"model"] ?:  self.owner.model;
    NSString *country = options[@"country"] ?: self.owner.country;
    NSString *flag = options[@"flag"] ?: self.owner.flag;
    NSString *url = [NSString stringWithFormat:@"%@brands/%@/models/%@/config", self.owner.url, brand, model];
    NSMutableDictionary *params = [NSMutableDictionary new];
    if (country != nil) {
        params[@"country"] = country;
    }
    if (flag != nil) {
        params[@"flag"] = flag;
    }
    if (options[@"filter"] != nil) {
        params[@"filter"] = [options[@"filter"] boolValue] ? @"1" : @"0";
    }
    NSDictionary *result = [options mutableCopy];
    [result setValuesForKeysWithDictionary:@{
                                             @"url": url,
                                             @"method": @"GET",
                                             @"params": params
                                             }];
    return result;
}

@end
