#import <Foundation/Foundation.h>

@class UDLocalizedStrings;

@interface UDMethodLocalization : NSObject

- (instancetype)init;

- (instancetype)initWithLocalizedStrings:(UDLocalizedStrings *)localizedStrings;

+ (instancetype)methodLocalization;

+ (instancetype)methodLocalizationWithLocalizedStrings:(UDLocalizedStrings *)localizedStrings;

- (void)localizeSetter:(SEL)setterSelector forClass:(Class)cls;

@end
