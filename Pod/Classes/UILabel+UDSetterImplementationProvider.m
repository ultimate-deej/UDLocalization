//
//  UILabel+UDSetterImplementationProvider.m
//  P2P Network
//
//  Created by Deej on 30.03.15.
//  Copyright (c) 2015 AppCraft. All rights reserved.
//

#import "UILabel+UDSetterImplementationProvider.h"
#import "UDLocalization.h"

static void LabelTextSetter(UILabel *self, SEL _cmd, id value) {
    void(*defaultSetter)(id, SEL, id) = (void (*)(id, SEL, id)) [UDLocalization defaultLocalizedSetter];
    defaultSetter(self, _cmd, value);
    if ([self.superview isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *) self.superview;
        [button setTitle:self.text forState:button.state];
    }
}

@implementation UILabel (UDSetterImplementationProvider)

+ (IMP)ud_setterImplementationWithSelector:(SEL)setter {
    if (setter == @selector(setText:)) {
        return (IMP) LabelTextSetter;
    }
    return [UDLocalization defaultLocalizedSetter];
}

@end
