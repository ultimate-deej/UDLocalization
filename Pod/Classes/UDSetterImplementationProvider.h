//
//  UDSetterImplementationProvider.h
//  P2P Network
//
//  Created by Deej on 30.03.15.
//  Copyright (c) 2015 AppCraft. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UDSetterImplementationProvider

@required
+ (IMP)ud_setterImplementationWithSelector:(SEL)setter;

@end
