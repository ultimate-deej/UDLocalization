#import <UDLocalization.h>

SpecBegin(UDLocalization)

UDLocalization *localization = [UDLocalization new];

describe(@"localizedString:", ^{
    it(@"should localize string", ^{
        expect([localization localizedString:@"test key"]).to.equal(@"test value");
    });
    it(@"should not modify non-localized strings", ^{
        expect([localization localizedString:@"not localized key"]).to.equal(@"not localized key");
    });
});

SpecEnd
