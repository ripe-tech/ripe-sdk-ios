#import "BaseAPI.h"
#import "BaseAPI+BrandAPI.h"

@implementation BaseAPI

- (id)initWithOwner:(Ripe *)owner andOptions:(NSDictionary *)options {
    self = [super init];
    if (self) {
        self.owner = owner;
        self.options = options;
    }
    return self;
}

- (NSString *)url {
    return self.options[@"url"] ?: @"https://sandbox.platforme.com/api/";
}

- (NSDictionary *)_getImageOptions:(NSDictionary *)options {
    NSMutableDictionary *_options = [NSMutableDictionary dictionaryWithDictionary:[self _getQueryOptions: options]];
    NSDictionary *params = _options[@"params"];
    NSString *url = [NSString stringWithFormat:@"%@compose", self.url];
    [_options setValuesForKeysWithDictionary:@{
                                               @"url": url,
                                               @"method": @"GET",
                                               @"params": params
                                               }];
    return _options;
}

- (NSString *)_getImageUrl:(NSDictionary *)options {
    NSDictionary *_options = [self _getImageOptions:options];
    NSString *url = _options[@"url"];
    NSDictionary *params = _options[@"params"];
    NSString *query = [self _buildQuery:params];
    return [NSString stringWithFormat:@"%@?%@", url, query];
}

- (NSDictionary *)_getQueryOptions:(NSDictionary *)options {
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:options];
    NSMutableDictionary *params = options[@"params"] ?: [NSMutableDictionary dictionaryWithDictionary:options];
    params[@"brand"] = options[@"brand"];
    params[@"model"] = options[@"model"];
    result[@"params"] = params;
    return result;
}

- (NSString *)_buildQuery:(NSDictionary *)params {
    __block NSMutableArray *buffer = [NSMutableArray new];
    [params enumerateKeysAndObjectsUsingBlock:^(id  key, id  obj, BOOL *stop) {
        NSString *keyS = [key stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
        NSString *valueS = [obj stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
        [buffer addObject:[NSString stringWithFormat:@"%@=%@", keyS, valueS]];
    }];
    return [buffer componentsJoinedByString:@"&"];
}

@end
