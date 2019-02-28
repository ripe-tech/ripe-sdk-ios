#import "Image.h"

@implementation Image

- (id)initWithImageView:(UIImageView *)imageView owner:(Ripe *)owner options:(NSDictionary *)options {
    self = [self initWithOwner:owner options:options];
    self.showInitials = [options[@"showInitials"] boolValue] ?: true;
    InitialsBuilder optionsInitialsBuilder = options[@"initialsBuilder"];
    self.initialsBuilder = optionsInitialsBuilder ?: ^NSDictionary *(NSString *initials, NSString *engraving, UIImageView *imageView) {
        NSString *initialsS = initials ?: @"";
        NSArray *profile = engraving != nil ? @[engraving] : @[];
        return @{ @"initials": initialsS ?: @"", @"profile": profile };
    };
    self.imageView = imageView;
    return self;
}

- (void)update:(NSDictionary *)state {
    self.initials = state[@"initials"] ?: self.initials;
    self.engraving = state[@"engraving"] ?: self.engraving;
    BOOL showInitials = self.initials != nil && self.engraving != nil && self.showInitials;
    NSDictionary *spec = showInitials ?
        self.initialsBuilder(self.initials, self.engraving, self.imageView) : @{ @"initials": @"", @"profile": @[] };

    NSDictionary *options = @{
                              @"brand": self.owner.brand,
                              @"model": self.owner.model,
                              @"initials": spec[@"initials"],
                              @"profile": spec[@"profile"]
                              };
    NSString *url = [self.owner _getImageUrl:options];
    if ([self.url isEqualToString:url]) {
        return;
    }

    self.url = url;
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
