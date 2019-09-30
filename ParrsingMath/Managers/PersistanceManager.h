//
//  PersistanceManager.h
//  ParrsingMath
//
//  Created by Maxim Shnirman on 05/09/2019.
//  Copyright © 2019 Maxim Shnirman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersistanceManager : NSObject

/**
 shared access for using PersistanceManager
 @return an instance of PersistanceManager
 */
+ (PersistanceManager *)sharedInstance;

/**
 save given input to a file in: /Users/<USER>/Library/Containers/max.parsingmath.com.ParrsingMath/Data/Documents/persistant_storage.txt
 
 @param input NSString input to save
 @param result the result on the given string
 */
- (void)saveInput:(NSString *)input result:(double)result;

/**
 gets the persistant data from the file

 @return NSArray of rows read from the file
 */
- (NSArray *)getPersistantData;

/**
 removes the peristant file from the file system
 */
- (void)deletePersistantData;

@end
