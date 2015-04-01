@interface UDLocalization : NSObject

- (instancetype)init;

- (instancetype)initWithTableName:(NSString *)tableName;

- (instancetype)initWithLanguage:(NSString *)language;

- (instancetype)initWithLanguage:(NSString *)language tableName:(NSString *)tableName;

- (instancetype)initWithBundle:(NSBundle *)bundle tableName:(NSString *)tableName NS_DESIGNATED_INITIALIZER;

+ (instancetype)localization;

+ (instancetype)localizationWithTableName:(NSString *)tableName;

+ (instancetype)localizationWithLanguage:(NSString *)language;

+ (instancetype)localizationWithLanguage:(NSString *)language tableName:(NSString *)tableName;

+ (instancetype)localizationWithBundle:(NSBundle *)bundle tableName:(NSString *)tableName;

- (NSString *)localizedString:(NSString *)key;

@end
