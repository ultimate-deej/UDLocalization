#import <UDLocalizedStrings.h>

SpecBegin(UDLocalizedStrings)

sharedExamplesFor(@"-localizedString:", ^(NSDictionary *data) {
    UDLocalizedStrings *localizedStrings = data[@"instance"];
    it(@"should localize string", ^{
        expect([localizedStrings localizedString:@"test key"]).to.equal(data[@"test key"]);
    });
    it(@"should return the original string if there is no localization", ^{
        expect([localizedStrings localizedString:@"nonexistent key"]).to.equal(@"nonexistent key");
    });
});

describe(@"-localizedString:", ^{
    itShouldBehaveLike(@"-localizedString:", @{
            @"instance" : [UDLocalizedStrings localizedStrings],
            @"test key" : @"english test value", // Not sure why it uses English by default
    });

    context(@"custom strings table", ^{
        itShouldBehaveLike(@"-localizedString:", @{
                @"instance" : [UDLocalizedStrings localizedStringsWithTableName:@"Custom"],
                @"test key" : @"custom file value",
        });
    });

    context(@"custom language", ^{
        itShouldBehaveLike(@"-localizedString:", @{
                @"instance" : [UDLocalizedStrings localizedStringsWithLanguage:@"Base"],
                @"test key" : @"test value",
        });
    });

    context(@"custom language and table", ^{
        itShouldBehaveLike(@"-localizedString:", @{
                @"instance" : [UDLocalizedStrings localizedStringsWithLanguage:@"ru" tableName:@"OnlyRu"],
                @"test key" : @"pseudo russian",
        });
        itShouldBehaveLike(@"-localizedString:", @{
                @"instance" : [UDLocalizedStrings localizedStringsWithLanguage:@"Base" tableName:@"OnlyRu"],
                @"test key" : @"test key",
        });
        itShouldBehaveLike(@"-localizedString:", @{
                @"instance" : [UDLocalizedStrings localizedStringsWithLanguage:nil tableName:@"OnlyRu"],
                @"test key" : @"test key",
        });
    });

    context(@"when explicit bundle is being used", ^{
        itShouldBehaveLike(@"-localizedString:", @{
                @"instance" : [UDLocalizedStrings localizedStringsWithBundle:[NSBundle bundleForClass:[UDLocalizedStrings class]] tableName:@"Custom"],
                @"test key" : @"custom file value",
        });
    });
});

SpecEnd
