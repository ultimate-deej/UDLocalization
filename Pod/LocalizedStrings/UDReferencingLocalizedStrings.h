#import <Foundation/Foundation.h>
#import "UDLocalizedStrings.h"

@interface UDReferencingLocalizedStrings : NSObject <UDLocalizedStrings>

- (instancetype)initWithLocalizedStrings:(id <UDLocalizedStrings>)localizedStrings;

+ (instancetype)referencingLocalizedStringsWithLocalizedStrings:(id <UDLocalizedStrings>)localizedStrings;

@end
