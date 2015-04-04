#import "UDReferencingLocalizedStrings.h"

static NSString *const ReferencePrefix = @"r/";

@interface UDReferencingLocalizedStrings ()

@property(nonatomic) id <UDLocalizedStrings> localizedStrings;

@end

@implementation UDReferencingLocalizedStrings

- (instancetype)initWithLocalizedStrings:(id <UDLocalizedStrings>)localizedStrings {
    self = [super init];
    if (self) {
        _localizedStrings = localizedStrings;
    }

    return self;
}

+ (instancetype)referencingLocalizedStringsWithLocalizedStrings:(id <UDLocalizedStrings>)localizedStrings {
    return [[self alloc] initWithLocalizedStrings:localizedStrings];
}

- (NSString *)localizedString:(NSString *)key initialKey:(NSString *)initialKey {
    // Break cycles
    if ([key isEqualToString:initialKey]) return initialKey;

    NSString *localized = [_localizedStrings localizedString:key];
    if ([localized hasPrefix:ReferencePrefix]) {
        NSString *referencedKey = [localized substringFromIndex:ReferencePrefix.length];
        NSString *localizedReference = [self localizedString:referencedKey initialKey:initialKey ?: key];
        if (localizedReference != referencedKey) {
            localized = localizedReference;
        }
    }
    return localized;
}

- (NSString *)localizedString:(NSString *)key {
    return [self localizedString:key initialKey:nil];
}

@end
