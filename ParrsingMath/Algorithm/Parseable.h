//
//  Parseable.h
//  ParrsingMath
//
//  Created by Maxim Shnirman on 04/09/2019.
//  Copyright © 2019 Maxim Shnirman. All rights reserved.
//

@class Queue;

@protocol Parseable <NSObject>

/**
  protocol for enabling parsing from NSString to Queue

 @param inputString string to parse
 @return result type Queue
 */
- (Queue*)parse:(NSString *)inputString;
@end
