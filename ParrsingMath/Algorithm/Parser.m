//
//  Parser.m
//  ParrsingMath
//
//  Created by Maxim Shnirman on 04/09/2019.
//  Copyright © 2019 Maxim Shnirman. All rights reserved.
//

#import "Parser.h"
#import "Queue.h"
#import "Stack.h"
#import "NSString+Int.h"
#import "NSString+NSArray.h"

NSString * const CantParseInputExName = @"CantPaseInoutExName";
NSString * const BadParenthesisExName = @"BadParenthesisExName";

NSString * const ErrorIndex = @"ErrorIndex";
NSString * const NextToString = @"NextToString";

@interface Parser()
@property (strong, nonatomic) NSArray *oprators;
@property (strong, nonatomic) Stack *parenthesisStack;
@end


@implementation Parser

static float const e = 2.71828;
static NSString * const eSymbol = @"e";
static NSString * const leftParnthesis = @"(";
static NSString * const rightParnthesis = @")";

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    
    self.oprators = @[leftParnthesis,rightParnthesis,@"+",@"-",@"*",@"/",@"^"];
    self.parenthesisStack = [[Stack alloc] init];
    return self;
}

- (Queue *)parse:(NSString *)inputString {
    NSString *trimmed = [inputString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSArray *input = [trimmed toArray];
    Queue *inputQueue = [self tokenize:input];
    return inputQueue;
}

- (Queue *)tokenize:(NSArray *)input {
    Queue *result = [[Queue alloc] init];
    
    int inputIndex = 0;
    NSString *value = nil;
    
    for (NSString *object in input) {
        inputIndex++;
        
        if ([object isNumeric] && value == nil) {
            value = object;
            continue;
        } else if ([object isNumeric] && value != nil) {
            value = [value stringByAppendingString:object];
            continue;
        } else if ([object isEqualToString:eSymbol]) {
            if (value != nil) {
                [result enqueue:@([value intValue])];
                value = nil;
            }
            [result enqueue:@(e)];
        } else if ([self.oprators containsObject:object]) {
            [self validateParenthesis:object];
            
            if (value != nil) {
                [result enqueue:@([value intValue])];
                value = nil;
            }
            [result enqueue:object];
            value = nil;
        } else {
            [self handleWrongInput:input index:inputIndex];
        }
    }
    
    if (self.parenthesisStack.size > 0) {
        [self raiseExceptionType:BadParenthesisExName reason:@"Error bad parenthesis" userInfo:nil];
    }
    
    if (value != nil) {
        [result enqueue:@([value intValue])];
    }
    
#ifdef DEBUG
    [result print];
#endif
    
    return result;
}

- (void)validateParenthesis:(NSString *)object {
    NSString *peek = self.parenthesisStack.peek;
    
    if (peek != nil) {
        if ([peek isEqualToString:leftParnthesis] && [object isEqualToString:leftParnthesis]) {
            [self.parenthesisStack push:object];
        } else if ([peek isEqualToString:leftParnthesis] && [object isEqualToString:rightParnthesis]) {
            [self.parenthesisStack pop];
        }
    } else if ([object isEqualToString:leftParnthesis] || [object isEqualToString:rightParnthesis]) {
        [self.parenthesisStack push:object];
    }
}

- (void)handleWrongInput:(NSArray *)input index:(int)index {
    NSArray *subInput = [input subarrayWithRange:NSMakeRange(index, input.count - index)];
    NSString *nextToError = [subInput componentsJoinedByString:@""];
    [self raiseException:index nearChars:nextToError];
}

- (void)raiseException:(int)index nearChars:(NSString *)near {
    [self raiseExceptionType:CantParseInputExName reason:@"Input Error near" userInfo:@{ErrorIndex: @(index), NextToString: near}];
}

- (void)raiseExceptionType:(NSString *)error reason:(NSString *)reason userInfo:(NSDictionary *)userInfo {
    NSException *myException = [NSException
                                exceptionWithName:error
                                reason:reason
                                userInfo:userInfo];
    @throw myException;
}

@end
