#import <objc/runtime.h>
#import <UDLocalization/UDLocalizedStrings.h>
#import "UDMethodLocalization.h"

typedef void (*Setter)(id self, SEL _cmd, id value);

static NSObject *Sentinel;

static SEL SentinelKey(SEL sel) {
    return NSSelectorFromString([@"UDMethodLocalization_" stringByAppendingString:NSStringFromSelector(sel)]);
}

@interface UDMethodLocalization ()

@property(nonatomic) UDLocalizedStrings *localizedStrings;

@end

@implementation UDMethodLocalization

+ (void)load {
    Sentinel = [[NSObject alloc] init];
}

- (instancetype)initWithLocalizedStrings:(UDLocalizedStrings *)localizedStrings {
    self = [super init];
    if (self) {
        _localizedStrings = localizedStrings;
    }

    return self;
}

+ (instancetype)methodLocalizationWithLocalizedStrings:(UDLocalizedStrings *)localizedStrings {
    return [[self alloc] initWithLocalizedStrings:localizedStrings];
}

- (void)localizeSetter:(SEL)setterSelector forClass:(Class)cls {
    // Check if already localized
    if (objc_getAssociatedObject(cls, SentinelKey(setterSelector)) != nil) {
        NSLog(@"Warning: attempting to localize already localized method %@ on class %@",
                NSStringFromSelector(setterSelector),
                NSStringFromClass(cls));
        return;
    }
    objc_setAssociatedObject(cls, SentinelKey(setterSelector), Sentinel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    Method setterMethod = class_getInstanceMethod(cls, setterSelector);
    // Make sure it takes exactly one argument
    if (method_getNumberOfArguments(setterMethod) != 3) {
        NSLog(@"Warning: attempting to localize method with number of arguments != 1");
        return;
    }
    // And its return type is void
    char returnType[8];
    method_getReturnType(setterMethod, returnType, sizeof(returnType));
    if (strcmp(returnType, "v") != 0) {
        NSLog(@"Warning: attempting to localize method with non-void return type");
        return;
    }

    UDLocalizedStrings *localizedStrings = self.localizedStrings;
    Setter originalSetter = (Setter) method_getImplementation(setterMethod);
    IMP localizedSetterImp = imp_implementationWithBlock(^(id self, id value) {
        value = [localizedStrings localizedString:value];
        originalSetter(self, setterSelector, value);
    });
    method_setImplementation(setterMethod, localizedSetterImp);
}

@end
