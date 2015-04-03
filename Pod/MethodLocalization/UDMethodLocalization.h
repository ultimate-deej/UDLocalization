#import <Foundation/Foundation.h>

@class UDLocalizedStrings;

@interface UDMethodLocalization : NSObject

- (instancetype)init;

- (instancetype)initWithLocalizedStrings:(UDLocalizedStrings *)localizedStrings NS_DESIGNATED_INITIALIZER;

+ (instancetype)methodLocalization;

+ (instancetype)methodLocalizationWithLocalizedStrings:(UDLocalizedStrings *)localizedStrings;

- (void)localizeSetter:(SEL)setterSelector forClass:(Class)cls;

@end
