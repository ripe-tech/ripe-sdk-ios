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

- (NSURLSessionDataTask *)_cacheURL:(NSString *)url withOptions:(NSDictionary *)options andCallback:(void (^)(NSDictionary *))callback {
    // TODO
    return [self _requestURL:url withOptions:options andCallback:callback];
}

- (NSURLSessionDataTask *)_requestURL:(NSString *)url withOptions:(NSDictionary *)options andCallback:(void (^)(NSDictionary *))callback {
    NSString *method = options[@"method"] ?: @"GET";
    NSDictionary *params = options[@"params"] ?: [NSDictionary new];
    NSDictionary *headers = options[@"headers"] ?: [NSDictionary new];
    NSString *data = options[@"data"];
    NSString *contentType = options[@"contentType"];

    NSString *query = [self _buildQuery:params];
    BOOL isEmpty = [@[@"GET", @"DELETE"] containsObject:method];
    BOOL hasQuery = [url containsString:@"?"];
    NSString *separator = hasQuery ? @"&" : @"?";
    if (isEmpty || data != nil) {
        url = [NSString stringWithFormat:@"%@%@%@", url, separator, query];
    } else {
        data = query;
        contentType = @"application/x-www-form-urlencoded";
    }

    NSURL *urlNS = [NSURL URLWithString:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:urlNS completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *config = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(config);
        });
    }];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [task resume];
    });
    return task;
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

- (NSDictionary *)_build:(NSDictionary *)options {
    NSString *url = options[@"url"] ?: @"";
    NSString *method = options[@"method"] ?: @"GET";
    NSDictionary *params = options[@"params"] ?: [NSDictionary new];
    BOOL auth = options[@"auth"] ?: false;
    // TODO sid
    NSMutableDictionary *result = [options mutableCopy];
    [result setValuesForKeysWithDictionary:@{
                                             @"url": url,
                                             @"method": method,
                                             @"params": params,
                                             @"auth": [NSNumber numberWithBool:auth]
                                             }];
    return result;
}

@end
