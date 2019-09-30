//
//  Colculateable.h
//  ParrsingMath
//
//  Created by Maxim Shnirman on 04/09/2019.
//  Copyright © 2019 Maxim Shnirman. All rights reserved.
//

@class Queue;

@protocol Calculable <NSObject>

/**
 protocol for calculating values of a given Queue returning result as a double

 @param queue queue to calculate its values
 @return double represents the result of the calculation
 */
- (double)calculate:(Queue *)queue;
@end
