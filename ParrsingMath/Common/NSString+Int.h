//
//  NSString+Int.h
//  ParrsingMath
//
//  Created by Maxim Shnirman on 04/09/2019.
//  Copyright © 2019 Maxim Shnirman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Int)

/**
 extenting NSString to return if a given string is numeric

 @return true if string is numeric
 */
- (BOOL)isNumeric;
@end
