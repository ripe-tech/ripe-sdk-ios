#import "BaseAPI+SizeAPI.h"

@implementation BaseAPI (SizeAPI)

- (void)getSizes:(void (^)(NSDictionary * _Nonnull))callback {
    [self getSizes:[NSDictionary new] callback:callback];
}

- (void)getSizes:(NSDictionary *)options callback:(void (^)(NSDictionary * _Nonnull))callback {
    NSString *url = [NSString stringWithFormat:@"%@%@", self.owner.url, @"sizes"];
    NSMutableDictionary *sizeOptions = options.mutableCopy;
    [sizeOptions setValuesForKeysWithDictionary:@{
        @"url": url,
        @"method": @"GET"
        }];
    options = [self _build:sizeOptions];
    [self _cacheURL:options[@"url"] options:options callback:callback];
}

- (Promise *)getSizesP {
    return [self getSizesP:[NSDictionary new]];
}

- (Promise *)getSizesP:(NSDictionary *)options {
    return [self _callbackToPromise:@selector(getSizes:callback:) options:options];
}

- (void)sizeToNative:(NSString *)scale value:(double)value gender:(NSString *)gender callback:(void (^)(NSDictionary * _Nonnull))callback {
    [self sizeToNative:scale value:value gender:gender options:[NSDictionary new] callback:callback];
}

- (void)sizeToNative:(NSString *)scale value:(double)value gender:(NSString *)gender options:(NSDictionary *)options callback:(void (^)(NSDictionary * _Nonnull))callback {
    NSString *url = [NSString stringWithFormat:@"%@%@", self.owner.url, @"sizes/size_to_native"];
    NSMutableDictionary *sizeOptions = options.mutableCopy;
    [sizeOptions setValuesForKeysWithDictionary:@{
        @"url": url,
        @"method": @"GET",
        @"params": @{
            @"scale": scale,
            @"value": [NSNumber numberWithDouble:value],
            @"gender": gender
        }
    }];
    options = [self _build:sizeOptions];
    [self _cacheURL:options[@"url"] options:options callback:callback];
}

- (Promise *)sizeToNativeP:(NSString *)scale value:(double)value gender:(NSString *)gender {
    return [self sizeToNativeP:scale value:value gender:gender options:[NSDictionary new]];
}

- (Promise *)sizeToNativeP:(NSString *)scale value:(double)value gender:(NSString *)gender options:(NSDictionary *)options {
    return [[Promise alloc] initWithExecutor:^(Resolve  _Nonnull resolve, Reject  _Nonnull reject) {
        [self sizeToNative:scale value:value gender:gender options:options callback:^(NSDictionary * _Nonnull response) {
            resolve(response);
        }];
    }];
}

- (void)sizeToNativeB:(NSArray *)scales values:(NSArray *)values genders:(NSArray *)genders callback:(void (^)(NSArray * _Nonnull))callback {
    [self sizeToNativeB:scales values:values genders:genders options: [NSDictionary new] callback:callback];
}

- (void)sizeToNativeB:(NSArray *)scales values:(NSArray *)values genders:(NSArray *)genders options:(NSDictionary *)options callback:(void (^)(NSArray * _Nonnull))callback {
    NSString *url = [NSString stringWithFormat:@"%@%@", self.owner.url, @"sizes/size_to_native_b"];
    NSMutableArray *scalesP = [NSMutableArray new];
    NSMutableArray *valuesP = [NSMutableArray new];
    NSMutableArray *gendersP = [NSMutableArray new];

    for (int index = 0; index < scales.count; index++) {
        [scalesP addObject:scales[index]];
        [valuesP addObject:values[index]];
        [gendersP addObject:genders[index]];
    }

    NSMutableDictionary *sizeOptions = options.mutableCopy;
    [sizeOptions setValuesForKeysWithDictionary:@{
        @"url": url,
        @"method": @"GET",
        @"params": @{
            @"scales": scalesP,
            @"values": valuesP,
            @"genders": gendersP
        }
    }];
    options = [self _build:sizeOptions];
    [self _cacheURL:options[@"url"] options:options callback:^(NSDictionary * _Nonnull response) {
        callback((NSArray *)response);
    }];
}

- (Promise *)sizeToNativeBP:(NSArray *)scales values:(NSArray *)values genders:(NSArray *)genders {
    return [self sizeToNativeBP:scales values:values genders:genders options:[NSDictionary new]];
}

- (Promise *)sizeToNativeBP:(NSArray *)scales values:(NSArray *)values genders:(NSArray *)genders options:(NSDictionary *)options {
    return [[Promise alloc] initWithExecutor:^(Resolve  _Nonnull resolve, Reject  _Nonnull reject) {
        [self sizeToNativeB:scales values:values genders:genders options:options callback:^(NSArray * _Nonnull response) {
            resolve(response);
        }];
    }];
}

- (void)nativeToSize:(NSString *)scale value:(double)value gender:(NSString *)gender callback:(void (^)(NSDictionary * _Nonnull))callback {
    [self nativeToSize:scale value:value gender:gender options:[NSDictionary new] callback:callback];
}

- (void)nativeToSize:(NSString *)scale value:(double)value gender:(NSString *)gender options:(NSDictionary *)options callback:(void (^)(NSDictionary * _Nonnull))callback {
    NSString *url = [NSString stringWithFormat:@"%@%@", self.owner.url, @"sizes/native_to_size"];
    NSMutableDictionary *sizeOptions = options.mutableCopy;
    [sizeOptions setValuesForKeysWithDictionary:@{
        @"url": url,
        @"method": @"GET",
        @"params": @{
            @"scale": scale,
            @"value": [NSNumber numberWithDouble:value],
            @"gender": gender
        }
    }];
    options = [self _build:sizeOptions];
    [self _cacheURL:options[@"url"] options:options callback:callback];
}

- (Promise *)nativeToSizeP:(NSString *)scale value:(double)value gender:(NSString *)gender {
    return [self nativeToSizeP:scale value:value gender:gender options:[NSDictionary new]];
}

- (Promise *)nativeToSizeP:(NSString *)scale value:(double)value gender:(NSString *)gender options:(NSDictionary *)options {
    return [[Promise alloc] initWithExecutor:^(Resolve  _Nonnull resolve, Reject  _Nonnull reject) {
        [self nativeToSize:scale value:value gender:gender options:options callback:^(NSDictionary * _Nonnull response) {
            resolve(response);
        }];
    }];
}

- (void)nativeToSizeB:(NSArray *)scales values:(NSArray *)values genders:(NSArray *)genders callback:(void (^)(NSArray * _Nonnull))callback {
    [self nativeToSizeB:scales values:values genders:genders options: [NSDictionary new] callback:callback];
}

- (void)nativeToSizeB:(NSArray *)scales values:(NSArray *)values genders:(NSArray *)genders options:(NSDictionary *)options callback:(void (^)(NSArray * _Nonnull))callback {
    NSString *url = [NSString stringWithFormat:@"%@%@", self.owner.url, @"sizes/native_to_size_b"];
    NSMutableArray *scalesP = [NSMutableArray new];
    NSMutableArray *valuesP = [NSMutableArray new];
    NSMutableArray *gendersP = [NSMutableArray new];

    for (int index = 0; index < scales.count; index++) {
        [scalesP addObject:scales[index]];
        [valuesP addObject:values[index]];
        [gendersP addObject:genders[index]];
    }

    NSMutableDictionary *sizeOptions = options.mutableCopy;
    [sizeOptions setValuesForKeysWithDictionary:@{
        @"url": url,
        @"method": @"GET",
        @"params": @{
            @"scales": scalesP,
            @"values": valuesP,
            @"genders": gendersP
        }
    }];
    options = [self _build:sizeOptions];
    [self _cacheURL:options[@"url"] options:options callback:^(NSDictionary * _Nonnull response) {
        callback((NSArray *)response);
    }];
}

- (Promise *)nativeToSizeBP:(NSArray *)scales values:(NSArray *)values genders:(NSArray *)genders {
    return [self nativeToSizeBP:scales values:values genders:genders options:[NSDictionary new]];
}

- (Promise *)nativeToSizeBP:(NSArray *)scales values:(NSArray *)values genders:(NSArray *)genders options:(NSDictionary *)options {
    return [[Promise alloc] initWithExecutor:^(Resolve  _Nonnull resolve, Reject  _Nonnull reject) {
        [self nativeToSizeB:scales values:values genders:genders options:options callback:^(NSArray * _Nonnull response) {
            resolve(response);
        }];
    }];
}
@end
