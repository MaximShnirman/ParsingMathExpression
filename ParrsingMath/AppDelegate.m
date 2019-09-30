//
//  AppDelegate.m
//  ParrsingMath
//
//  Created by Maxim Shnirman on 03/09/2019.
//  Copyright © 2019 Maxim Shnirman. All rights reserved.
//

#import "AppDelegate.h"
#import "PersistanceManager.h"
#import "PersistantResultWindow.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (IBAction)deleteSavedResultsClicked:(id)sender {
    [[PersistanceManager sharedInstance] deletePersistantData];
}

- (IBAction)savedResultsClicked:(id)sender {
    NSArray* data = [[PersistanceManager sharedInstance] getPersistantData];
    PersistantResultWindow *persistanceWindow = [[PersistantResultWindow alloc] initWithDataSource:data];
    [persistanceWindow showWindow:self];
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem {
    if ([menuItem.identifier isEqualToString:@"SavedItems"] || [menuItem.identifier isEqualToString:@"DeleteItems"]) {
        if ([[PersistanceManager sharedInstance] getPersistantData] == nil) {
            menuItem.enabled = NO;
        } else {
            menuItem.enabled = YES;
        }
    }
    return menuItem.enabled;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    
}

@end
