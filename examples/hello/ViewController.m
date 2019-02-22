#import "ViewController.h"
#import <ripe/Ripe.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Ripe *ripe = [[Ripe alloc] initWithBrand:@"dummy" andModel:@"dummy"];
    [ripe bindImageWithImageView:self.imageView];
    [ripe update];
    [ripe bindToEvent:@"price" withCallback:^(NSDictionary *price) {
        NSDictionary *total = price[@"total"];
        NSNumber *priceFinal = total[@"price_final"];
        NSString *currency = total[@"currency"];
        [self.labelView setText:[NSString stringWithFormat:@"%@ %@", priceFinal, currency]];
    }];
}

@end
