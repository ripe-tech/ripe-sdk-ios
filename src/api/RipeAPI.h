//
//  RipeAPI.h
//  ripe
//
//  Created by Afonso Neves Caldas on 29/01/2019.
//  Copyright © 2019 Platforme. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RipeAPI <NSObject>

@property (readonly) NSString *url;

- (NSString *)_getImageUrl:(NSDictionary *)options;
- (NSDictionary *)_getImageOptions:(NSDictionary *)options;
- (NSDictionary *)_getQueryOptions:(NSDictionary *)options;
- (NSString *)_buildQuery:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
