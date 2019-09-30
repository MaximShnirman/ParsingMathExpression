//
//  ResultWindow.h
//  ParrsingMath
//
//  Created by Maxim Shnirman on 05/09/2019.
//  Copyright © 2019 Maxim Shnirman. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol ResultWindowDelegate <NSObject>

/**
 delegate called on back button click

 @param resultWindow NSWindowController object
 */
- (void)backClick:(NSWindowController *)resultWindow;
@end

@interface ResultWindow : NSWindowController
- (instancetype)initWithResult:(NSString *)result delegate:(id<ResultWindowDelegate>)delegate frame:(NSRect)frame;
- (void)setResult:(NSString *)result;

@property (weak) IBOutlet NSTextField *resultTextField;
@property (weak) IBOutlet NSButton *goBackButton;
@end

