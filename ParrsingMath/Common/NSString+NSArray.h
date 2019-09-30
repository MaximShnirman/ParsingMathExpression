//
//  NSString+NSArray.h
//  ParrsingMath
//
//  Created by Maxim Shnirman on 04/09/2019.
//  Copyright © 2019 Maxim Shnirman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSArray)

/**
 extenting NSString to return NSArray from given strings chars
 
 @return array of chars
 */
- (NSArray *)toArray;
@end

