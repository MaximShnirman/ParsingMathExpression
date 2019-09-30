//
//  EventMonitor.m
//  ParrsingMath
//
//  Created by Maxim Shnirman on 04/09/2019.
//  Copyright © 2019 Maxim Shnirman. All rights reserved.
//

#import "EventMonitor.h"
#import <AppKit/AppKit.h>

NSString * const EqualKeyThreeClicksNotification = @"EqualKeyThreeClicksNotification";
NSString * const EqualKeyFirstClickNotification = @"EqualKeyFirstClickNotification";
NSString * const ClickTimerPassedNotification = @"ClickTimerPassedNotification";

@interface EventMonitor()
@property (strong, nonatomic) NSMutableArray *equalClicks;
@end


@implementation EventMonitor : NSObject

static double defaultClickThreshold = 0.3;
static int defaultClickAmount = 3;

static EventMonitor *sharedInstance = nil;

+ (EventMonitor *)sharedInstance {
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
    self.equalClicks = [NSMutableArray new];
    self.equalClickAmount = defaultClickAmount;
    self.equalClickThreshold = defaultClickThreshold;
    return self;
}

- (void)startMonitoringKeyboardEvents {
    [NSEvent addLocalMonitorForEventsMatchingMask:NSEventMaskKeyDown handler:^NSEvent *(NSEvent *event) {
        if ([event.characters isEqualToString:@"="]) {
            NSDate *now = [NSDate date];
            NSInteger count = self.equalClicks.count;
            int clicksRequired = (self.equalClickAmount - 1);

            if (count > 0) {
                NSDate *lastDate = self.equalClicks[count - 1];
                NSTimeInterval timeSinceLastClick = [now timeIntervalSinceDate:lastDate];

                if (timeSinceLastClick < self.equalClickThreshold && count < clicksRequired) {
                    [self.equalClicks addObject:now];
                    [self setTimerToVerifyNextClick:2];
                } else if (timeSinceLastClick < self.equalClickThreshold && count == clicksRequired) {
                    [self.equalClicks removeAllObjects];
                    [[NSNotificationCenter defaultCenter] postNotificationName:EqualKeyThreeClicksNotification object:nil userInfo:@{}];
#ifdef DEBUG
                    NSLog(@"3 clicks detected");
#endif
                } else if (timeSinceLastClick >= self.equalClickThreshold) {
                    [self.equalClicks removeAllObjects];
#ifdef DEBUG
                    NSLog(@"3rd clicks time passed");
#endif
                }
            } else {
                [[NSNotificationCenter defaultCenter] postNotificationName:EqualKeyFirstClickNotification object:nil userInfo:@{}];
                [self.equalClicks addObject:now];
                [self setTimerToVerifyNextClick:1];
            }
        }

        return event;
    }];
}

- (void)setTimerToVerifyNextClick:(int)count {
    [NSTimer scheduledTimerWithTimeInterval:self.equalClickThreshold repeats:NO block:^(NSTimer *timer) {
        if (self.equalClicks.count == count) {
            [[NSNotificationCenter defaultCenter] postNotificationName:ClickTimerPassedNotification object:nil userInfo:@{}];
            [self.equalClicks removeAllObjects];
#ifdef DEBUG
            NSLog(@"%d clicks time passed", count);
#endif
        }
    }];
}

@end
