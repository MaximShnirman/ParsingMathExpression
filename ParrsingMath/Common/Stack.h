//
//  Stack.h
//  ParrsingMath
//
//  Created by Maxim Shnirman on 09/09/2019.
//  Copyright © 2019 Maxim Shnirman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject

/**
 returns count of object in stack
 */
@property (nonatomic, assign, readonly) NSUInteger size;

/**
 pops objct from the stack
 */
- (id)pop;

/**
 adds element to the stack

 @param element object to be added to the stack
 */
- (void)push:(id)element;

/**
 returns last inserted object to the stack, but not removes it

 @return last inserted object to the stack
 */
- (id)peek;

/**
 return true if stack empty, false otherwise

 @return value indicates if the stack is empty
 */
- (BOOL)isEmpty;

/**
 print stacks content
 */
- (void)print;

@end

