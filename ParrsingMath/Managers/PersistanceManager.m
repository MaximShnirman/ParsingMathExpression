//
//  PersistanceManager.m
//  ParrsingMath
//
//  Created by Maxim Shnirman on 05/09/2019.
//  Copyright © 2019 Maxim Shnirman. All rights reserved.
//

#import "PersistanceManager.h"

@interface PersistanceManager()
@property (strong, nonatomic) NSString *filePath;
@end

@implementation PersistanceManager

static PersistanceManager *sharedInstance = nil;

+ (PersistanceManager *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    
    return sharedInstance;
}

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    
    self.filePath = [self applicationDatabaseDirectory];
    
    return self;
}

- (NSString *)applicationDatabaseDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"persistant_storage.txt"];
    
    return filePath;
}

- (void)saveInput:(NSString *)input result:(double)result {
    NSString *newLine = [NSString stringWithFormat:@"\n%@ = %f", input, result];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:self.filePath]) {
        NSError *error;
        [newLine writeToFile:self.filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
        if (error) {
            NSLog(@"error while writing to file");
        }
    } else if ([[NSFileManager defaultManager] isWritableFileAtPath:self.filePath]) {
        NSFileHandle *file = [NSFileHandle fileHandleForWritingAtPath:self.filePath];
        [file seekToEndOfFile];
        [file writeData:[newLine dataUsingEncoding:NSUTF8StringEncoding]];
    } else {
        NSLog(@"Not Writable");
    }
}

- (NSArray *)getPersistantData {
    NSArray *result = nil;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.filePath]) {
        NSData *fileData = [[NSFileManager defaultManager] contentsAtPath:self.filePath];
        NSString *fileString = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
        result = [fileString componentsSeparatedByString:@"\n"];
        result = [result subarrayWithRange:NSMakeRange(1, result.count - 1)];
    }
    
    return result;
}

- (void)deletePersistantData {
    if ([[NSFileManager defaultManager] isDeletableFileAtPath:self.filePath]) {
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath:self.filePath error:&error];
        if (error) {
            NSLog(@"error while deletingfile at %@", self.filePath);
        }
    }
}

@end
