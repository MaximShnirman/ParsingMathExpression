//
//  NSString+Int.m
//  ParrsingMath
//
//  Created by Maxim Shnirman on 04/09/2019.
//  Copyright © 2019 Maxim Shnirman. All rights reserved.
//

#import "NSString+Int.h"

@implementation NSString (Int)

- (BOOL)isNumeric {
    return [self rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location == NSNotFound;
}

@end
