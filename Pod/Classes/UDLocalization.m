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

- (NSBundle *)bundle {
    if (_bundle == nil) {
        _bundle = [NSBundle bundleForClass:[self class]];
    }
    return _bundle;
}

- (NSString *)localizedString:(NSString *)key {
    return GetLocalizedString(key, self.bundle);
}

@end
