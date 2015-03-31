//
//  NSObject+UDLocalization.m
//  P2P Network
//
//  Created by Deej on 30.03.15.
//  Copyright (c) 2015 AppCraft. All rights reserved.
//

#import "NSObject+UDLocalization.h"
#import "UDLocalization.h"

@implementation NSObject (UDLocalization)

+ (void)localizeProperty:(char const *)name {
    [UDLocalization localizeProperty:name ofClass:self];
}

+ (void)localizeSetter:(SEL)setter {
    [UDLocalization localizeSetter:setter ofClass:self];
}

@end
