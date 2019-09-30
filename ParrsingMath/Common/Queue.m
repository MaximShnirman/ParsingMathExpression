//
//  Stack.m
//  ParrsingMath
//
//  Created by Maxim Shnirman on 03/09/2019.
//  Copyright © 2019 Maxim Shnirman. All rights reserved.
//

#import "Queue.h"

@interface Queue ()
@property (nonatomic, strong) NSMutableArray *objects;
@end

@implementation Queue

- (id)init {
    if ((self = [self initWithArray:nil])) {
    }
    return self;
}

- (id)initWithArray:(NSArray *)array {
    if ((self = [super init])) {
        self.objects = [[NSMutableArray alloc] initWithArray:array];
    }
    return self;
}

- (id)initWithCapacity:(NSUInteger)capacity {
    if ((self = [super init])) {
        self.objects = [NSMutableArray arrayWithCapacity:capacity];
    }
    return self;
}

- (NSUInteger)count {
    return self.objects.count;
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    return self.objects[idx];
}

- (id)head {
    id headObject = self.objects[0];
    return headObject;
}

- (void)enqueue:(id)anObject {
    [self.objects addObject:anObject];
}

- (id)dequeue {
    id headObject = self.objects[0];
    if (headObject != nil) {
        [self.objects removeObjectAtIndex:0];
    }
    return headObject;
}

- (void)print {
    for (NSString *object in self.objects) {
        NSLog(@"%@", object);
    }
}

@end
