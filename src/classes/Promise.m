#import "Promise.h"

@implementation Promise

- (instancetype)initWithExecutor:(Executor)executor {
    self = [super init];
    if (self) {
        self.executor = executor;
        self.resultObservers = [NSMutableArray new];
        self.errorObservers = [NSMutableArray new];
        self.resolved = false;
        [self execute];
    }
    return self;
}

- (void)resolve:(id)result {
    self.result = result;
    self.resolved = true;
    [self update];
}

- (void)reject:(NSError *)error {
    self.error = error;
    [self update];
}

- (Promise *)then:(Resolved)resolved {
    [self.resultObservers addObject:resolved];
    [self update];
    return self;
}

- (void)catch:(Rejected)rejected {
    [self.errorObservers addObject:rejected];
}

+ (Promise *)all:(NSArray *)promises {
    Promise *promise = [[Promise alloc] initWithExecutor:^(Resolve resolve, Reject reject) {
        NSLock *lock = [NSLock new];
        NSUInteger count = promises.count;
        NSMutableArray *results = [NSMutableArray arrayWithCapacity:count];
        if (promises.count == 0) {
            resolve(results);
        }
        for(id value in promises) {
            Promise *promise = (Promise *)value;
            [promise then:^(id _Nullable result) {
                if (result == nil) {
                    result = [NSNull null];
                }
                [lock lock];
                [results addObject:result];
                if (results.count == count) {
                    resolve(results);
                }
                [lock unlock];
            }];
            [promise catch:^(NSError *error) {
                reject(error);
            }];
        }
    }];
    return promise;
};

-(void)execute {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        self.executor(^(id result) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self resolve:result];
            });
        }, ^(NSError * _Nonnull error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reject:error];
            });
        });
    });
}

-(void)update {
    if (self.resolved) {
        for (id resolution in self.resultObservers) {
            Resolved resolved = (Resolved) resolution;
            resolved(self.result);
        }
        [self.resultObservers removeAllObjects];
    } else if (self.error != nil) {
        if (self.errorObservers.count == 0) {
            @throw self.error;
        }

        for (id rejection in self.errorObservers) {
            Rejected rejected = (Rejected) rejection;
            rejected(self.error);
        }
        [self.errorObservers removeAllObjects];
    }
}

@end
