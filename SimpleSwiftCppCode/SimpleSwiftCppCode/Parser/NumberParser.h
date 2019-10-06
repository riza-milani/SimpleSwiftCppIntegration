//
//  NumberParser.h
//  SimpleSwiftCppCode
//
//  Created by riza milani on 5/31/1398 AP.
//  Copyright © 1398 reza milani. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NumberParser : NSObject
-(bool)isChecked:(u_int8_t)value;
-(u_int8_t)getItem:(u_int8_t)value;
-(u_int8_t)getSection:(u_int8_t)value;
@end
