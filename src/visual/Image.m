#import "Image.h"

@implementation Image

- (id)initWithImageView:(UIImageView *)imageView owner:(Ripe *)owner options:(NSDictionary *)options {
    self = [self initWithOwner:owner options:options];
    self.imageView = imageView;
    return self;
}

- (void)update:(NSDictionary *)state {
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
        self.owner.brand, @"brand",
        self.owner.model, @"model",
        nil
    ];
    NSString *url = [self.owner _getImageUrl:options];
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData *data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: url]];
        if (data == nil)
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData: data];
            self.imageView.image = image;
        });
    });
}

@end
