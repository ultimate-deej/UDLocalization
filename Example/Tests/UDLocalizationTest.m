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
            @"test key" : @"english test value", // Not sure why it uses English by default
    });

    context(@"custom strings table", ^{
        itShouldBehaveLike(@"-localizedString:", @{
                @"instance" : [UDLocalization localizationWithTableName:@"Custom"],
                @"test key" : @"custom file value",
        });
    });

    context(@"custom language", ^{
        itShouldBehaveLike(@"-localizedString:", @{
                @"instance" : [UDLocalization localizationWithLanguage:@"Base"],
                @"test key" : @"test value",
        });
    });

    context(@"custom language and table", ^{
        itShouldBehaveLike(@"-localizedString:", @{
                @"instance" : [UDLocalization localizationWithLanguage:@"ru" tableName:@"OnlyRu"],
                @"test key" : @"pseudo russian",
        });
        itShouldBehaveLike(@"-localizedString:", @{
                @"instance" : [UDLocalization localizationWithLanguage:@"Base" tableName:@"OnlyRu"],
                @"test key" : @"test key",
        });
        itShouldBehaveLike(@"-localizedString:", @{
                @"instance" : [UDLocalization localizationWithLanguage:nil tableName:@"OnlyRu"],
                @"test key" : @"test key",
        });
    });
});

SpecEnd
