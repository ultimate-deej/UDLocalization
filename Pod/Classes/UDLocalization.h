@interface UDLocalization : NSObject

- (instancetype)init;

- (instancetype)initWithTableName:(NSString *)tableName;

+ (instancetype)localization;

+ (instancetype)localizationWithTableName:(NSString *)tableName;

- (NSString *)localizedString:(NSString *)key;

@end
