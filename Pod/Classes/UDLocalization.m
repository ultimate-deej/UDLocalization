#import "UDLocalization.h"

#pragma mark Localizing

static NSString *GetLocalizedString(NSString *key) {
    if (![key isKindOfClass:[NSString class]]) return key;
    return [[NSBundle bundleForClass:[UDLocalization class]] localizedStringForKey:key value:nil table:@"UDLocalizable"];
}

#pragma mark - Class

@implementation UDLocalization

+ (NSString *)localizedString:(NSString *)key {
    return GetLocalizedString(key);
}

@end
