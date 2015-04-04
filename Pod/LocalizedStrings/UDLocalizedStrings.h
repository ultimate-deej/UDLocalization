@protocol UDLocalizedStrings <NSObject>

- (NSString *)localizedString:(NSString *)key;

@end

@interface UDLocalizedStrings : NSObject <UDLocalizedStrings>

- (instancetype)init;

- (instancetype)initWithTableName:(NSString *)tableName;

- (instancetype)initWithLanguage:(NSString *)language;

- (instancetype)initWithLanguage:(NSString *)language tableName:(NSString *)tableName;

- (instancetype)initWithBundle:(NSBundle *)bundle tableName:(NSString *)tableName NS_DESIGNATED_INITIALIZER;

+ (instancetype)localizedStrings;

+ (instancetype)localizedStringsWithTableName:(NSString *)tableName;

+ (instancetype)localizedStringsWithLanguage:(NSString *)language;

+ (instancetype)localizedStringsWithLanguage:(NSString *)language tableName:(NSString *)tableName;

+ (instancetype)localizedStringsWithBundle:(NSBundle *)bundle tableName:(NSString *)tableName;

- (NSString *)localizedString:(NSString *)key;

@end
