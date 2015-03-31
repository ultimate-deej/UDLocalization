//
//  NSObject+UDLocalization.h
//  P2P Network
//
//  Created by Deej on 30.03.15.
//  Copyright (c) 2015 AppCraft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (UDLocalization)

+ (void)localizeProperty:(char const *)name;

+ (void)localizeSetter:(SEL)setter;

@end
