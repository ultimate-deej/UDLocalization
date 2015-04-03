#import <UDMethodLocalization.h>
#import "UDLocalizedStrings.h"
#import <objc/runtime.h>

#pragma mark - Sample Class

@interface SomeClass : NSObject

@property(nonatomic) NSString *regularProperty;
@property(nonatomic) NSString *localizedProperty;
@property(nonatomic, setter=setLocalizedCustom:) NSString *localizedPropertyWithCustomSetter;

@end

@implementation SomeClass

- (void)setFoo:foo bar:bar {
}

- (id)setFoo:foo {
    return nil;
}

- (void)notASetter {
}

@end

#pragma mark - Tests

SpecBegin(UDMethodLocalization)

UDLocalizedStrings *localizedStrings = [UDLocalizedStrings localizedStringsWithTableName:@"Custom"];
UDMethodLocalization *methodLocalization = [UDMethodLocalization methodLocalizationWithLocalizedStrings:localizedStrings];

// Store original implementations
IMP originalSetLocalizedPropertyImp = class_getMethodImplementation([SomeClass class], @selector(setLocalizedProperty:));
IMP originalSetFooBarImp = class_getMethodImplementation([SomeClass class], @selector(setFoo:bar:));
IMP originalSetFooImp = class_getMethodImplementation([SomeClass class], @selector(setFoo:));
IMP originalNotASetterImp = class_getMethodImplementation([SomeClass class], @selector(notASetter));
// Localize valid setters
[methodLocalization localizeSetter:@selector(setLocalizedProperty:) forClass:[SomeClass class]];
[methodLocalization localizeSetter:@selector(setLocalizedCustom:) forClass:[SomeClass class]];
// Try to localize invalid setters
[methodLocalization localizeSetter:@selector(setFoo:bar:) forClass:[SomeClass class]];
[methodLocalization localizeSetter:@selector(setFoo:) forClass:[SomeClass class]];
[methodLocalization localizeSetter:@selector(notASetter) forClass:[SomeClass class]];

SomeClass *someObject = [SomeClass new];

describe(@"changed method implementations", ^{
    context(@"invalid setters", ^{
        example(@"void with multiple parameters is not localized", ^{
            IMP currentSetFooBarImp = class_getMethodImplementation([SomeClass class], @selector(setFoo:bar:));
            expect(currentSetFooBarImp).to.equal(originalSetFooBarImp);
        });
        example(@"non-void is not localized", ^{
            IMP currentSetFooImp = class_getMethodImplementation([SomeClass class], @selector(setFoo:));
            expect(currentSetFooImp).to.equal(originalSetFooImp);
        });
        example(@"void without parameters is not localized", ^{
            IMP currentNotASetterImp = class_getMethodImplementation([SomeClass class], @selector(notASetter));
            expect(currentNotASetterImp).to.equal(originalNotASetterImp);
        });
    });

    context(@"valid setter", ^{
        it(@"should have different implementation", ^{
            IMP currentSetLocalizedPropertyImp = class_getMethodImplementation([SomeClass class], @selector(setLocalizedProperty:));
            expect(currentSetLocalizedPropertyImp).toNot.equal(originalSetLocalizedPropertyImp);
        });
    });
});

describe(@"values of properties set via localized setters", ^{
    context(@"string property", ^{
        it(@"should not modify non-localized values set to localized properties", ^{
            someObject.localizedProperty = @"nonexistent key";
            expect(someObject.localizedProperty).to.equal(@"nonexistent key");
        });
        it(@"should not modify values set to non-localized properties", ^{
            someObject.regularProperty = @"test key";
            expect(someObject.regularProperty).to.equal(@"test key");
        });
        it(@"should replace values set to localized properties with values that exist in a strings table", ^{
            someObject.localizedProperty = @"test key";
            expect(someObject.localizedProperty).to.equal([localizedStrings localizedString:@"test key"]);
        });

        context(@"custom setter name", ^{
            it(@"should work the same way as with default setter name", ^{
                someObject.localizedPropertyWithCustomSetter = @"test key";
                expect(someObject.localizedPropertyWithCustomSetter).to.equal([localizedStrings localizedString:@"test key"]);
            });
        });
    });
});

SpecEnd