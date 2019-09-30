//
//  Stack.m
//  ParrsingMath
//
//  Created by Maxim Shnirman on 09/09/2019.
//  Copyright © 2019 Maxim Shnirman. All rights reserved.
//

#import "Stack.h"

@interface Stack ()
@property (nonatomic, strong) NSMutableArray *objects;
@end


@implementation Stack

- (id)init {
    if (!(self = [super init])) {
        return nil;
    }
    
    self.objects = [[NSMutableArray alloc] init];
    return self;
}

- (id)pop {
    id object = [self peek];
    [self.objects removeLastObject];
    return object;
}

- (void)push:(id)element {
    [self.objects addObject:element];
}

- (void)pushElementsFromArray:(NSArray *)arr {
    [self.objects addObjectsFromArray:arr];
}

- (id)peek {
    return [self.objects lastObject];
}

- (NSUInteger)size {
    return self.objects.count;
}

- (BOOL)isEmpty {
    return [self.objects count] == 0;
}

- (void)print {
    for (NSString *object in self.objects) {
        NSLog(@"%@", object);
    }
}

@end
