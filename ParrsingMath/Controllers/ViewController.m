//
//  ViewController.m
//  ParrsingMath
//
//  Created by Maxim Shnirman on 03/09/2019.
//  Copyright © 2019 Maxim Shnirman. All rights reserved.
//

#import "ViewController.h"
#import "Queue.h"
#import "Parser.h"
#import "Calculator.h"
#import "EventMonitor.h"
#import "ResultWindow.h"
#import "PersistanceManager.h"

@interface ViewController() <ResultWindowDelegate>
@property (strong, nonatomic) NSString *onFirstTapInput;
@property (strong, nonatomic) ResultWindow *resultWindow;
@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [[EventMonitor sharedInstance] startMonitoringKeyboardEvents];
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(onThreeClicks:) name:EqualKeyThreeClicksNotification object:nil];
    [notificationCenter addObserver:self selector:@selector(onFirstClick:) name:EqualKeyFirstClickNotification object:nil];
    [notificationCenter addObserver:self selector:@selector(clickTimePassed:) name:ClickTimerPassedNotification object:nil];
}

- (void)viewDidAppear {
    [super viewDidAppear];
    [self.inputField resignFirstResponder];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - notifications
- (void)onThreeClicks:(NSNotification *)notifiaction {
    [self removeEqualSignFromInput];
    [self calculate:self.onFirstTapInput];
}

- (void)onFirstClick:(NSNotification *)notifiaction {
    self.onFirstTapInput = self.inputField.stringValue;
}

- (void)clickTimePassed:(NSNotification *)notification {
    self.onFirstTapInput = nil;
}

#pragma mark - actions
- (IBAction)didClickCalculate:(id)sender {
    [self calculate:self.inputField.stringValue];
}

#pragma mark - delegate
- (void)backClick:(NSWindowController *)resultWindow {
    [resultWindow close];
    self.resultWindow = nil;
}

#pragma mark - Calculatetable implementation
- (void)calculate:(NSString *)input {
    Parser *parser = [Parser new];
    
    @try {
        Queue *parssedExpresion = [parser parse:input];
        Calculator *calculator = [Calculator new];
        double result = [calculator calculate:parssedExpresion];
        [self showResultWithText:result];
        [[PersistanceManager sharedInstance] saveInput:input result:result];
    } @catch (NSException *exception) {
        NSString *exType = exception.name;
        NSString *reason = exception.reason;
        
        if ([exType isEqualToString:UnhandledExceptionExName]) {
             [self showErrorWithText:reason];
        } else if ([exType isEqualToString:CantParseInputExName]) {
            NSString *nextToString = exception.userInfo[NextToString];
            [self showErrorWithText:[NSString stringWithFormat:@"%@ '%@'", reason, nextToString]];
        } else if ([exType isEqualToString:CantDevideByZeroExName]) {
            [self showErrorWithText:reason];
        } else if ([exType isEqualToString:BadParenthesisExName]) {
            [self showErrorWithText:reason];
        }
    }
}

- (void)showResultWithText:(double)result {
    NSString *resultStr = [NSString stringWithFormat:@"%f", result];
    
    if (self.resultWindow == nil) {
        self.resultWindow = [[ResultWindow alloc] initWithResult:resultStr delegate:self frame:self.view.window.frame];
        [self.resultWindow showWindow:self];
    } else {
        [self.resultWindow setResult:resultStr];
    }
}

- (void)showErrorWithText:(NSString *)error {
    NSAlert *alert = [NSAlert new];
    [alert setMessageText:error];
    [alert addButtonWithTitle:NSLocalizedString(@"OK",nil)];
    NSInteger okBtn = [alert runModal];
    
    if (okBtn == NSAlertFirstButtonReturn) {
        if(self.onFirstTapInput.length > 0) {
            [self removeEqualSignFromInput];
        }
    }
}

- (void)removeEqualSignFromInput {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.00001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.inputField.stringValue = self.onFirstTapInput;
    });
}

@end
