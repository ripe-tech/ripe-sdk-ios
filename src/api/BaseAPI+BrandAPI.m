#import "BaseAPI+BrandAPI.h"

@implementation BaseAPI (BrandAPI)

- (void)getConfigWithCallback:(void (^)(NSDictionary *))callback {
    NSString *queryString = [NSString stringWithFormat:@"%@brands/%@/models/%@/config", self.url, self.owner.brand, self.owner.model];
    NSURL *url = [NSURL URLWithString:queryString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *config = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(config);
        });
    }];
    [task resume];
}

@end
