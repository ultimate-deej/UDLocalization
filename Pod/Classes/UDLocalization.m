#import "UDLocalization.h"

#pragma mark Localizing

static NSString *GetLocalizedString(NSString *key, NSBundle *bundle) {
    if (![key isKindOfClass:[NSString class]]) return key;
    return [bundle localizedStringForKey:key value:nil table:@"UDLocalizable"];
}

#pragma mark - Class

@interface UDLocalization ()

@property(nonatomic) NSBundle *bundle;

@end

@implementation UDLocalization

- (instancetype)init {
    self = [super init];
    if (self) {
        _bundle = [NSBundle bundleForClass:[self class]];
    }

    return self;
}

- (NSString *)localizedString:(NSString *)key {
    return GetLocalizedString(key, self.bundle);
}

@end
