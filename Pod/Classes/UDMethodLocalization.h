#import <Foundation/Foundation.h>

@class UDLocalizedStrings;

@interface UDMethodLocalization : NSObject

- (instancetype)initWithLocalizedStrings:(UDLocalizedStrings *)localizedStrings;

+ (instancetype)methodLocalizationWithLocalizedStrings:(UDLocalizedStrings *)localizedStrings;

- (void)localizeSetter:(SEL)setterSelector forClass:(Class)cls;

@end
