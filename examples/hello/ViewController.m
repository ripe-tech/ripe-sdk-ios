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
    [ripe bindToEvent:@"config" withCallback:^(NSDictionary *response) {
        NSDictionary *parts = ripe.parts;
    }];
}

@end
