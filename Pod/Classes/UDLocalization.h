//
//  UDLocalization.h
//  P2P Network
//
//  Created by Deej on 30.03.15.
//  Copyright (c) 2015 AppCraft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UDLocalization : NSObject

+ (void)setStringsTableName:(NSString *)tableName;

+ (IMP)defaultLocalizedSetter;

+ (NSString *)localizedString:(NSString *)key;

+ (void)localizeProperty:(char const *)name ofClass:(Class)cls;

+ (void)localizeSetter:(SEL)setter ofClass:(Class)cls;

@end
