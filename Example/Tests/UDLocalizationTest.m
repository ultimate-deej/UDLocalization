#import <UDLocalization.h>

SpecBegin(UDLocalization)

sharedExamplesFor(@"-localizedString:", ^(NSDictionary *data) {
    UDLocalization *localization = data[@"instance"];
    it(@"should localize string", ^{
        expect([localization localizedString:@"test key"]).to.equal(data[@"test key"]);
    });
    it(@"should return the original string if there is no localization", ^{
        expect([localization localizedString:@"nonexistent key"]).to.equal(@"nonexistent key");
    });
});

describe(@"-localizedString:", ^{
    itShouldBehaveLike(@"-localizedString:", @{
            @"instance" : [UDLocalization localization],
            @"test key" : @"test value",
    });

    context(@"custom strings table", ^{
        itShouldBehaveLike(@"-localizedString:", @{
                @"instance" : [UDLocalization localizationWithTableName:@"Custom"],
                @"test key" : @"custom file value",
        });
    });
});

SpecEnd
