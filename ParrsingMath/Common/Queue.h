//
//  Queue.h
//  ParrsingMath
//
//  Created by Maxim Shnirman on 03/09/2019.
//  Copyright © 2019 Maxim Shnirman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Queue : NSObject

/**
 returns count of object in queue
 */
@property (nonatomic, assign, readonly) NSUInteger count;

/**
 override to provide access for an array syntax, eg: queue[index]
 */
- (id)objectAtIndexedSubscript:(NSUInteger)idx;

/**
 initializer with given array

 @param array with values to populate the queue
 @return instance type Queue
 */
- (instancetype)initWithArray:(NSArray *)array;

/**
 initializer with given capacity

 @param capacity amount of expected objects in the array
 @return instance type Queue
 */
- (instancetype)initWithCapacity:(NSUInteger)capacity;

/**
 returns last added object to the queue
 */
- (id)head;

/**
 adds object to the queue
 */
- (void)enqueue:(id)anObject;

/**
 removes last added object to the queue
 */
- (id)dequeue;

/**
 prints queue objects to console
 */
- (void)print;
@end
