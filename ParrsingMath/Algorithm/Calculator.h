//
//  Calculator.h
//  ParrsingMath
//
//  Created by Maxim Shnirman on 04/09/2019.
//  Copyright © 2019 Maxim Shnirman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calculable.h"

FOUNDATION_EXPORT NSString * const CantDevideByZeroExName;
FOUNDATION_EXPORT NSString * const UnhandledExceptionExName;

@interface Calculator : NSObject<Calculable>
/**
 calculates the result by Shunting-yard_algorithm. link https://en.wikipedia.org/wiki/Shunting-yard_algorithm. CantDevideByZeroExName raised if the input contains devision by zero.
 
 @param queue with values to run the pattern on
 @return double represents the result 
 */
- (double)calculate:(Queue *)queue;
@end

