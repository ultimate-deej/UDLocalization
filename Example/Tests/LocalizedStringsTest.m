#import <UDLocalization.h>

SpecBegin(LocalizableStrings)

describe(@"localizedString:", ^{
    it(@"should localize string", ^{
        expect([UDLocalization localizedString:@"test key"]).to.equal(@"test value");
    });
    it(@"should not modify non-localized strings", ^{
        expect([UDLocalization localizedString:@"not localized key"]).to.equal(@"not localized key");
    });
});

SpecEnd
