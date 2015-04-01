#import <UDLocalization.h>

SpecBegin(UDLocalization)

sharedExamplesFor(@"-localizedString:", ^(NSDictionary *data) {
    UDLocalization *localization = data[@"instance"];
    it(@"should localize string", ^{
        expect([localization localizedString:@"test key"]).to.equal(data[@"test key"]);
    });
    it(@"should not modify non-localized strings", ^{
        expect([localization localizedString:@"not localized key"]).to.equal(data[@"not localized key"]);
    });
});

describe(@"-localizedString:", ^{
    itShouldBehaveLike(@"-localizedString:", @{
            @"instance" : [UDLocalization localization],
            @"test key" : @"test value",
            @"not localized key" : @"not localized key",
    });

    context(@"custom strings table", ^{
        itShouldBehaveLike(@"-localizedString:", @{
                @"instance" : [UDLocalization localizationWithTableName:@"Custom"],
                @"test key" : @"custom file value",
                @"not localized key" : @"not localized key",
        });
    });
});

SpecEnd
