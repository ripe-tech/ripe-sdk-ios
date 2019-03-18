#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Ripe *ripe = [[Ripe alloc] initWithBrand:@"dummy" model:@"dummy"];
    [ripe bindImage:self.imageView];
    [ripe bind:@"post_config" callback:^(NSDictionary *response) {
        [ripe setInitials:@"PT" engraving:@"grey"];
        [ripe setPart:@"piping" material:@"leather_dmy" color:@"brown"];
    }];
    [ripe bind:@"price" callback:^(NSDictionary *price) {
        NSDictionary *total = price[@"total"];
        NSNumber *priceFinal = total[@"price_final"];
        NSString *currency = total[@"currency"];
        [self.labelView setText:[NSString stringWithFormat:@"%@ %@", priceFinal, currency]];
    }];
}

@end
