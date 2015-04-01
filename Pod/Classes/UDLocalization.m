#import "UDLocalization.h"

#pragma mark Localizing

static NSString *GetLocalizedString(NSString *key, NSBundle *bundle, NSString *tableName) {
    if (![key isKindOfClass:[NSString class]]) return key;
    return [bundle localizedStringForKey:key value:nil table:tableName];
}

#pragma mark - Class

@interface UDLocalization ()

@property(nonatomic) NSBundle *bundle;
@property(nonatomic) NSString *tableName;

- (instancetype)initWithBundle:(NSBundle *)bundle tableName:(NSString *)tableName NS_DESIGNATED_INITIALIZER;

@end

@implementation UDLocalization

- (instancetype)init {
    return [self initWithBundle:nil tableName:nil];
}

- (instancetype)initWithTableName:(NSString *)tableName {
    return [self initWithBundle:nil tableName:tableName];
}

- (instancetype)initWithBundle:(NSBundle *)bundle tableName:(NSString *)tableName {
    self = [super init];
    if (self) {
        if (bundle == nil) bundle = [NSBundle bundleForClass:[self class]];
        if (tableName == nil) tableName = @"UDLocalizable";
        _bundle = bundle;
        _tableName = tableName;
    }

    return self;
}

+ (instancetype)localization {
    return [[self alloc] init];
}

+ (instancetype)localizationWithTableName:(NSString *)tableName {
    return [[self alloc] initWithTableName:tableName];
}

- (NSString *)localizedString:(NSString *)key {
    return GetLocalizedString(key, _bundle, _tableName);
}

@end
