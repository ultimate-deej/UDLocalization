@interface UDLocalization : NSObject

- (instancetype)init NS_DESIGNATED_INITIALIZER;

+ (instancetype)localization;

- (NSString *)localizedString:(NSString *)key;

@end
