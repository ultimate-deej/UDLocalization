//
//  NSObject+UDSetterImplementationProvider.m
//  P2P Network
//
//  Created by Deej on 30.03.15.
//  Copyright (c) 2015 AppCraft. All rights reserved.
//

#import "NSObject+UDSetterImplementationProvider.h"
#import "UDLocalization.h"

@implementation NSObject (UDSetterImplementationProvider)

+ (IMP)ud_setterImplementationWithSelector:(SEL)setter {
    return [UDLocalization defaultLocalizedSetter];
}

@end
