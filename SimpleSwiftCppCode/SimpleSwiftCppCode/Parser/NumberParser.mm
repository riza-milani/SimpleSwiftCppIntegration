//
//  NumberParser.m
//  SimpleSwiftCppCode
//
//  Created by riza milani on 5/31/1398 AP.
//  Copyright © 1398 reza milani. All rights reserved.
//

#include "NumberParser.h"
#include "Source/NumberParserImpl.hpp"

@implementation NumberParser

NumberParserImpl numberParser;

-(bool)isChecked:(u_int8_t)value {
    return numberParser.isChecked(value);
}

- (u_int8_t)getItem:(u_int8_t)value {
    return numberParser.getItem(value);
}

- (u_int8_t)getSection:(u_int8_t)value {
    return numberParser.getSection(value);
}

@end
