//
//  EventMonitor.h
//  ParrsingMath
//
//  Created by Maxim Shnirman on 04/09/2019.
//  Copyright © 2019 Maxim Shnirman. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const EqualKeyThreeClicksNotification;
extern NSString * const EqualKeyFirstClickNotification;
extern NSString * const ClickTimerPassedNotification;

@interface EventMonitor : NSObject

/**
 shared access for using EventMonitor
 @return an instance of EventMonitor
 */
+ (EventMonitor *)sharedInstance;
/**
 start monitoring NSEvent for '=' key input. ClickTimerPassedNotification will be sent when equalClickThreshold time is passed for the nth keydown of '='. EqualKeyFirstClickNotification will be sent when first time '=' was clicked. EqualKeyThreeClicksNotification will be sent on the 3rd time '=' was clicked
 */
- (void)startMonitoringKeyboardEvents;

/**
 time threashold for which ClickTimerPassedNotification is sent
 */
@property (assign, nonatomic) double equalClickThreshold;

/**
 sets how many times '=' is clicked
 */
@property (assign, nonatomic) int equalClickAmount;
@end

