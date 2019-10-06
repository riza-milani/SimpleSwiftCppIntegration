//
//  NumberParser.hpp
//  SimpleSwiftCppCode
//
//  Created by riza milani on 5/31/1398 AP.
//  Copyright © 1398 reza milani. All rights reserved.
//

#ifndef NumberParser_hpp
#define NumberParser_hpp

#include <stdio.h>
class NumberParserImpl {
public:
    bool isChecked(u_int8_t value);
    int getItem(u_int8_t value);
    int getSection(u_int8_t value);
};
#endif /* NumberParser_hpp */
