#import "ViewController.h"
#import <ripe/RipeObject.h>
#import <ripe/Image.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RipeObject *ripe = [[RipeObject alloc] initWithBrand:@"dummy" andModel:@"dummy" andOptions:[NSDictionary new]];
    Image *image = [[Image alloc] initWithImageView:self.imageView andOwner:ripe andOptions:[NSDictionary new]];
    [image update:[NSDictionary new]];
}


@end
