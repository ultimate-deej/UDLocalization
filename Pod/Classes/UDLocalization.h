@interface UDLocalization : NSObject

- (instancetype)init NS_DESIGNATED_INITIALIZER;

- (NSString *)localizedString:(NSString *)key;

@end
