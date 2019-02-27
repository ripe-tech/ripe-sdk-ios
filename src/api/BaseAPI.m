#import "BaseAPI.h"

@implementation BaseAPI

- (id)initWithOwner:(Ripe *)owner options:(NSDictionary *)options {
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

- (void)getPrice:(void (^)(NSDictionary * ))callback {
    return [self getPrice:nil callback:callback];
}

- (void)getPrice:(NSDictionary *)options callback:(void (^)(NSDictionary *))callback {
    NSDictionary *resultOptions = [self _getPriceOptions:options];
    resultOptions = [self _build:resultOptions];
    [self _cacheURL:resultOptions[@"url"] options:resultOptions callback:callback];
}

- (NSURLSessionDataTask *)_cacheURL:(NSString *)url options:(NSDictionary *)options callback:(void (^)(NSDictionary *))callback {
    // TODO
    return [self _requestURL:url options:options callback:callback];
}

- (NSURLSessionDataTask *)_requestURL:(NSString *)url options:(NSDictionary *)options callback:(void (^)(NSDictionary *))callback {
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
    NSURLRequest *request = [NSURLRequest requestWithURL:urlNS];
    [request.allHTTPHeaderFields setValuesForKeysWithDictionary:headers];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
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

- (NSDictionary *)_getPriceOptions:(NSDictionary *)options {
    NSMutableDictionary *result = [options mutableCopy] ?: [NSMutableDictionary new];
    result = [[self _getQueryOptions:result] mutableCopy];

    NSMutableDictionary *params = result[@"params"] ?: [NSMutableDictionary new];
    result[@"params"] = params;
    NSString *initials = [result[@"initials"] isEqualToString:@""] ? @"$empty" : result[@"initials"];
    if (initials != nil) {
        params[@"initials"] = initials;
    }

    NSString *url = [NSString stringWithFormat:@"%@%@", self.owner.url, @"config/price"];
    [result setValuesForKeysWithDictionary:@{@"url": url, @"method": @"GET"}];
    return result;
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
    result[@"params"] = params;
    NSString *brand = options[@"brand"] ?: self.owner.brand;
    NSString *model = options[@"model"] ?: self.owner.model;
    NSDictionary *parts = options[@"parts"] ?: self.owner.parts;
    // TODO params

    if (brand != nil) {
        params[@"brand"] = brand;
    }

    if (model != nil) {
        params[@"model"] = model;
    }

    NSMutableArray *partsL = [NSMutableArray new];
    for (id key in parts) {
        NSString *part = (NSString *)key;
        NSDictionary *value = parts[key];
        NSString *material = value[@"material"];
        NSString *color = value[@"color"];
        if (material == nil || color == nil) {
            continue;
        }
        [partsL addObject:[NSString stringWithFormat:@"%@:%@:%@", part, material, color]];
    }
    params[@"p"] = partsL;
    return result;
}

- (NSString *)_buildQuery:(NSDictionary *)params {
    __block NSMutableArray *buffer = [NSMutableArray new];
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *keyS = [key stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
        if ([obj isKindOfClass:NSString.class]) {
            NSString *valueS = [obj stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
            [buffer addObject:[NSString stringWithFormat:@"%@=%@", keyS, valueS]];
        } else if ([obj isKindOfClass:NSArray.class]) {
            for(id objKey in obj) {
                NSString *valueS = [objKey stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
                [buffer addObject:[NSString stringWithFormat:@"%@=%@", keyS, valueS]];
            }
        }
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
