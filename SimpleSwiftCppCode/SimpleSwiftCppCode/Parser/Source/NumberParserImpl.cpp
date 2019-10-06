//
//  NumberParser.cpp
//  SimpleSwiftCppCode
//
//  Created by riza milani on 5/31/1398 AP.
//  Copyright © 1398 reza milani. All rights reserved.
//

#include "NumberParserImpl.hpp"

bool NumberParserImpl::isChecked(u_int8_t value) {
    return value >> 7;
}

int NumberParserImpl::getItem(u_int8_t value) {
    return (((value | 128) ^ 128) >> 2) + 1;
}

int NumberParserImpl::getSection(u_int8_t value) {
    return (value & 3) + 1;
}
