@interface UDLocalization : NSObject

- (instancetype)init NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithTableName:(NSString *)tableName NS_DESIGNATED_INITIALIZER;

+ (instancetype)localization;

+ (instancetype)localizationWithTableName:(NSString *)tableName;

- (NSString *)localizedString:(NSString *)key;

@end
