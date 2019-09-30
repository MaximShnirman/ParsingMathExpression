//
//  ResultWindow.m
//  ParrsingMath
//
//  Created by Maxim Shnirman on 05/09/2019.
//  Copyright © 2019 Maxim Shnirman. All rights reserved.
//

#import "ResultWindow.h"

@interface ResultWindow ()
@property (strong, nonatomic) NSString *resultString;
@property (weak, nonatomic) id <ResultWindowDelegate> delegate;
@property (assign, nonatomic) NSRect frame;
@end


@implementation ResultWindow

static const CGFloat offset = 20.0;

- (instancetype)initWithResult:(NSString *)result delegate:(id<ResultWindowDelegate>)delegate frame:(NSRect)frame {
    if(!(self = [super initWithWindowNibName:@"ResultWindow" owner:self])) {
        return nil;
    }
    
    self.resultString = result;
    self.delegate = delegate;
    self.frame = NSMakeRect(frame.origin.x + offset, frame.origin.y - offset, frame.size.width, frame.size.height) ;
    
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    self.resultTextField.stringValue = self.resultString;
    [self.window setFrame:self.frame display:YES];
}

- (void)setResult:(NSString *)result {
    self.resultString = result;
    self.resultTextField.stringValue = self.resultString;
}

- (IBAction)didClickBackButton:(NSButton *)sender {
    NSLog(@"back tap");
    if (self.delegate && [self.delegate respondsToSelector:@selector(backClick:)]) {
        [self.delegate backClick:self];
    }
}

@end
