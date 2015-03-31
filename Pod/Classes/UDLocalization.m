//
//  UDLocalization.m
//  P2P Network
//
//  Created by Deej on 30.03.15.
//  Copyright (c) 2015 AppCraft. All rights reserved.
//

#import "UDLocalization.h"
#import "NSObject+UDSetterImplementationProvider.h"
#import <objc/runtime.h>

#pragma mark Localizing

static NSString *LocalizedStringsTableName = @"UDLocalized";

static NSString *GetLocalizedString(NSString *key) {
    if (![key isKindOfClass:[NSString class]]) return key;
    return NSLocalizedStringFromTable(key, LocalizedStringsTableName, nil);
}

#pragma mark - Swizzling

static NSString *const OriginalSelectorPrefix = @"deej_original_";

static SEL RenamedSelector(SEL sel) {
    NSString *selName = NSStringFromSelector(sel);
    return NSSelectorFromString([NSString stringWithFormat:@"%@%@", OriginalSelectorPrefix, selName]);
}

static void Swizzle(Class cls, SEL sel, IMP replacement) {
    SEL renamedSel = RenamedSelector(sel);
    if ([cls instancesRespondToSelector:renamedSel]) return;

    Method originalMethod = class_getInstanceMethod(cls, sel);

    // May be the implementation from base class
    if ([cls instancesRespondToSelector:sel]) {
        if (class_addMethod(cls, sel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))) {
            // Copy the implementation from base class to "cls"
            originalMethod = class_getInstanceMethod(cls, sel);
        }
    } else {
        return;
    }

    class_addMethod(cls, renamedSel, replacement, method_getTypeEncoding(originalMethod));
    Method renamedMethod = class_getInstanceMethod(cls, renamedSel);

    method_exchangeImplementations(originalMethod, renamedMethod);
}

#pragma mark - Method implementations

#pragma mark setX:

static void InvokeSetter(id self, SEL setter, id value) {
    void(*setterImplementation)(id, SEL, id) = (void (*)(id, SEL, id)) class_getMethodImplementation([self class], setter);
    setterImplementation(self, setter, value);
}

static void LocalizedSetter(id self, SEL _cmd, NSString *value) {
    SEL originalSetter = RenamedSelector(_cmd);
    InvokeSetter(self, originalSetter, GetLocalizedString(value));
}

#pragma mark awakeFromNib

static NSMutableDictionary *LocalizedProperties() {
    static NSMutableDictionary *dictionary;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dictionary = [NSMutableDictionary dictionary];
    });
    return dictionary;
}

static void SetLocalizedPropertyInfo(Class cls, NSString *setter, NSString *getter) {
    NSMutableDictionary *properties = LocalizedProperties()[cls];
    if (properties == nil) {
        properties = [NSMutableDictionary dictionary];
        LocalizedProperties()[(id <NSCopying>) cls] = properties;
    }
    properties[setter] = getter;
}

static void ReassignProperties(Class cls, id self) {
    NSMutableDictionary *properties = LocalizedProperties()[cls];
    [properties enumerateKeysAndObjectsUsingBlock:^(NSString *setterName, NSString *getterName, BOOL *stop) {
        SEL setter = NSSelectorFromString(setterName);
        SEL getter = NSSelectorFromString(getterName);
        id(*getterImplementation)(id, SEL) = (id (*)(id, SEL)) class_getMethodImplementation([self class], getter);
        id currentValue = getterImplementation(self, getter);
        InvokeSetter(self, setter, currentValue);
    }];
}

static void LocalizedAwakeFromNib(id self, SEL _cmd) {
    SEL originalAwakeFromNib = RenamedSelector(_cmd);
    void(*impl)(id, SEL) = (void (*)(id, SEL)) class_getMethodImplementation([self class], originalAwakeFromNib);
    impl(self, originalAwakeFromNib);
    [LocalizedProperties() enumerateKeysAndObjectsUsingBlock:^(id cls, id obj, BOOL *stop) {
        if ([self isKindOfClass:cls]) {
            ReassignProperties(cls, self);
            *stop = YES;
        }
    }];
}

#pragma mark - Property attributes

static NSString *GetSetterName(objc_property_t prop, char const *name) {
    char *setterName = property_copyAttributeValue(prop, "S");
    if (setterName != NULL) {
        NSString *result = [NSString stringWithUTF8String:setterName];
        free(setterName);
        return result;
    }

    NSString *propertyName = [NSString stringWithUTF8String:name];
    return [NSString stringWithFormat:@"set%@%@:", [propertyName substringToIndex:1].uppercaseString, [propertyName substringFromIndex:1]];
}

static NSString *GetGetterName(objc_property_t prop, char const *name) {
    char *getterName = property_copyAttributeValue(prop, "G");
    if (getterName != NULL) {
        NSString *result = [NSString stringWithUTF8String:getterName];
        free(getterName);
        return result;
    }

    return [NSString stringWithUTF8String:name];
}

static NSString *GetPropertyType(objc_property_t prop) {
    char *type = property_copyAttributeValue(prop, "T");
    if (type != NULL) {
        NSString *result = [NSString stringWithUTF8String:type];
        free(type);
        return result;
    }
    return nil;
}

#pragma mark - Class

@implementation UDLocalization

+ (void)setStringsTableName:(NSString *)tableName {
    LocalizedStringsTableName = tableName;
}

+ (IMP)defaultLocalizedSetter {
    return (IMP) LocalizedSetter;
}

+ (NSString *)localizedString:(NSString *)key {
    return GetLocalizedString(key);
}

+ (void)localizeProperty:(char const *)name ofClass:(Class)cls {
    objc_property_t prop = class_getProperty(cls, name);
    if (![GetPropertyType(prop) isEqualToString:@"@\"NSString\""]) return;

    NSString *setterName = GetSetterName(prop, name);
    SEL setter = NSSelectorFromString(setterName);
    Swizzle(cls, setter, [cls ud_setterImplementationWithSelector:setter]);

    if ([cls instancesRespondToSelector:@selector(awakeFromNib)]) {
        SetLocalizedPropertyInfo(cls, setterName, GetGetterName(prop, name));
        Swizzle(cls, @selector(awakeFromNib), (IMP) LocalizedAwakeFromNib);
    }
}

+ (void)localizeSetter:(SEL)setter ofClass:(Class)cls {
    Swizzle(cls, setter, [cls ud_setterImplementationWithSelector:setter]);
}

@end
