//
//  NSString+NSArray.m
//  ParrsingMath
//
//  Created by Maxim Shnirman on 04/09/2019.
//  Copyright © 2019 Maxim Shnirman. All rights reserved.
//

#import "NSString+NSArray.h"

@implementation NSString (NSArray)

- (NSArray *)toArray {
    NSMutableArray *arr = [NSMutableArray new];
    for (int i=0; i < self.length; i++) {
        NSString *character = [self substringWithRange:NSMakeRange(i, 1)];
        [arr addObject:character];
    }
    return arr;
}

@end
