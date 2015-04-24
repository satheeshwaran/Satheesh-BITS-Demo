//
//  NotificationsHelper.h
//  
//
//  Created by Satheeshwaran on 5/2/13.
//  Copyright (c) 2013 Satheeshwaran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationsHelper : NSObject

/*!
 Description
 
 This method schedules a local notification for a fire date specified.
 
 alertText – the text that needs to be displayed in the notification.
 alertAction –  The alert action is the title of the right button of the alert or the value of the
 unlock slider, where the value replaces “unlock” in “slide to unlock”.
 soundfileName – the name of the sound file that is played during the notification fire event, if nil          it    defaults to the default tone set by the user.
 LaunchImage – set this image if you want to override the default launch image.
 userInfo – any extra information that you may want to add to the local notification, that may be used when handling notifications during their fire event.
 */
+ (UILocalNotification*) scheduleNotificationOn:(NSDate*) fireDate
                           text:(NSString*) alertText
                         action:(NSString*) alertAction
                          sound:(NSString*) soundfileName
                    launchImage:(NSString*) launchImage
                        andInfo:(NSDictionary*) userInfo;

/*!
 Description
 
 This method schedules a local notification immediately.
 
 alertText – the text that needs to be displayed in the notification.
 alertAction –  The alert action is the title of the right button of the alert or the value of the
 unlock slider, where the value replaces “unlock” in “slide to unlock”.
 soundfileName – the name of the sound file that is played during the notification fire event, if nil          it    defaults to the default tone set by the user.
 LaunchImage – set this image if you want to override the default launch image.
 userInfo – any extra information that you may want to add to the local notification, that may be used when handling notifications during their fire event.
 */
+ (UILocalNotification*) scheduleNotificationNowWithtext:(NSString*) alertText
                                                  action:(NSString*) alertAction
                                                   sound:(NSString*) soundfileName
                                             launchImage:(NSString*) launchImage
                                                 andInfo:(NSDictionary*) userInfo;

/*!
 This method clears the badge count on top of the application.
 */
+ (void) clearBadgeCount;

/*!
 Description
 
 This method helps in handling a received local notification, for now it shows an alert by default. Extend this behavior to perform whatever needed.
 */
+ (void) handleReceivedNotification:(UILocalNotification*) thisNotification;

/*!
 Description
 This method removes/cancels all previously scheduled notifications.
 */
+ (void) removePreviousNotifications;

/*!
 Description
 This method cancels a particular UILocalNotification specified by the argument notification.
 */
+ (void)cancelLocalNotification:(UILocalNotification*)notification;

@end
