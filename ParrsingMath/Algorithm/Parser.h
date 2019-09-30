//
//  ParserCals.h
//  ParrsingMath
//
//  Created by Maxim Shnirman on 04/09/2019.
//  Copyright © 2019 Maxim Shnirman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parseable.h"

FOUNDATION_EXPORT NSString * const CantParseInputExName;
FOUNDATION_EXPORT NSString * const BadParenthesisExName;

FOUNDATION_EXPORT NSString * const ErrorIndex;
FOUNDATION_EXPORT NSString * const NextToString;


@interface Parser : NSObject <Parseable>

/**
 parses a given string into tokens queue
 
 @param inputString string fits the pattern
 @return a queue with parrsed items form the string
 */
- (Queue*)parse:(NSString *)inputString;
@end

