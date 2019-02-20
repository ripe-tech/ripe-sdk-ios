#import "ViewController.h"
#import <ripe/Ripe.h>
#import <ripe/Image.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Ripe *ripe = [[Ripe alloc] initWithBrand:@"dummy" andModel:@"dummy"];
    Image *image = [ripe bindImageWithImageView:self.imageView];
    [ripe update];
}

@end
