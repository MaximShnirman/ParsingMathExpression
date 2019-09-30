//
//  Calculator.m
//  ParrsingMath
//
//  Created by Maxim Shnirman on 04/09/2019.
//  Copyright © 2019 Maxim Shnirman. All rights reserved.
//

#import "Calculator.h"
#import "Queue.h"
#import "Stack.h"

NSString * const CantDevideByZeroExName = @"CantDevideByZeroExName";
NSString * const UnhandledExceptionExName = @"UnhandledExceptionExName";

@interface Calculator()
@property (strong, nonatomic) NSArray *operators;
@property (strong, nonatomic) NSDictionary *precedence;
@property (strong, nonatomic) NSDictionary *associativity;
@end

@implementation Calculator

static NSString * const leftParnthesis = @"(";
static NSString * const rightParnthesis = @")";
static NSString * const rightAssociativity = @"right";
static NSString * const leftAssociativity = @"left";

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }

    self.operators = @[@"^",@"*",@"/",@"+",@"-"];
    self.precedence = @{@"^": @(4),
                        @"*": @(3),
                        @"/": @(3),
                        @"+": @(2),
                        @"-": @(2)};
    self.associativity = @{@"^": rightAssociativity,
                           @"*": leftAssociativity,
                           @"/": leftAssociativity,
                           @"+": leftAssociativity,
                           @"-": leftAssociativity};
    
    return self;
}

- (double)calculate:(Queue *)queue {
    // Reverse Polish notation calculation
    Queue *RPN = [self getRPN:queue];
#ifdef DEBUG
    [RPN print];
#endif
    return [self sumRPN:RPN];
}

- (Queue *)getRPN:(Queue *)queue {
    Stack *operatorStack = [[Stack alloc] init];
    Queue *outputQueue = [[Queue alloc] init];
    NSInteger count = queue.count;
    id token = nil;
    
    for (int i=0; i<count; i++) {
        token = [queue dequeue];
        
        if ([token isKindOfClass:[NSNumber class]]) {
            [outputQueue enqueue:token];
            continue;
        } else if ([token isKindOfClass:[NSString class]]) {
            if ([self.operators containsObject:token]) {
                NSString *operator = [operatorStack peek];
                
                if (operator != nil) {
                    NSNumber *opPrecedence = self.precedence[operator];
                    NSNumber *tokenPrecedence = self.precedence[token];
                    NSString *opAssociativity = self.associativity[operator];
                    
                    while ((([opPrecedence intValue] > [tokenPrecedence intValue]) ||
                            (([opPrecedence intValue] == [tokenPrecedence intValue]) && [opAssociativity isEqualToString:leftAssociativity])) &&
                           ![operator isEqualToString:leftParnthesis]) {
                        [outputQueue enqueue:[operatorStack pop]];
                        
                        operator = [operatorStack peek];
                        if (operator != nil) {
                            opPrecedence = self.precedence[operator];
                            tokenPrecedence = self.precedence[token];
                            opAssociativity = self.associativity[operator];
                        } else {
                            break;
                        }
                    }
                }
                [operatorStack push:token];
                continue;
            } else if ([token isEqualToString:leftParnthesis]) {
                [operatorStack push:token];
                continue;
            } else if ([token isEqualToString:rightParnthesis]) {
                NSString *operator = [operatorStack peek];
                while (operator != nil && ![operator isEqualToString:leftParnthesis]) {
                    [outputQueue enqueue:[operatorStack pop]];
                    operator = [operatorStack peek];
                }
                if ([operator isEqualToString:leftParnthesis]) {
                    [operatorStack pop];
                }
                continue;
            }
        } else {
            [self raiseExceptionUnhandledError];
        }
    }
    
    if (operatorStack.size > 0) {
        NSInteger size = operatorStack.size;
        for (int i=0; i<size; i++) {
            [outputQueue enqueue:[operatorStack pop]];
        }
    }

    return outputQueue;
}

- (double)sumRPN:(Queue *)RPN {
    Stack *resultStack = [[Stack alloc] init];
    NSInteger count = RPN.count;
    id token = nil;
    
    for (int i=0; i<count; i++) {
        token = [RPN dequeue];
        
        if ([token isKindOfClass:[NSNumber class]]) {
            [resultStack push:token];
            continue;
        } else if ([token isKindOfClass:[NSString class]]) {
            double b = [[resultStack pop] doubleValue];
            double a = [[resultStack pop] doubleValue];
            double result = 0.0;
            
            if ([token isEqualToString:@"^"]) {
                result = [self power:a and:b];
            } else if ([token isEqualToString:@"*"]) {
                result = [self multiply:a and:b];
            } else if ([token isEqualToString:@"/"]) {
                result = [self devide:a and:b];
            } else if ([token isEqualToString:@"+"]) {
                result = [self add:a and:b];
            } else if ([token isEqualToString:@"-"]) {
                result = [self sub:a and:b];
            }
            [resultStack push:[NSNumber numberWithDouble:result]];
            
            continue;
        }
    }
    
    return [[resultStack pop] doubleValue];
}

- (double)power:(double)a and:(double)b {
    return pow(a, b);
}

- (double)multiply:(double)a and:(double)b {
    return a*b;
}

- (double)devide:(double)a and:(double)b {
    if (b == 0) {
        [self raiseExceptionCantDevideByZero];
    }
    return a/b;
}

- (double)add:(double)a and:(double)b {
    return a+b;
}

- (double)sub:(double)a and:(double)b {
    return a-b;
}

- (void)raiseExceptionCantDevideByZero {
    [self raiseExceptionType:CantDevideByZeroExName reason:@"Error cant devide by zero" userInfo:nil];
}

- (void)raiseExceptionUnhandledError {
    [self raiseExceptionType:UnhandledExceptionExName reason:@"Error wrong input in calculator?" userInfo:nil];
}

- (void)raiseExceptionType:(NSString *)error reason:(NSString *)reason userInfo:(NSDictionary *)userInfo {
    NSException *myException = [NSException
                                exceptionWithName:error
                                reason:reason
                                userInfo:userInfo];
    @throw myException;
}

@end
