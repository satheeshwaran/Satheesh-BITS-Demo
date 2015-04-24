//
//  CXTYBeaconAnalytics.h
//  FitNFine
//
//  Created by Satheeshwaran on 11/28/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CXTYBeaconAnalytics : NSManagedObject

@property (nonatomic, retain) NSString * analytics_app_id;
@property (nonatomic, retain) NSString * beacon_uuid;
@property (nonatomic, retain) NSString * user_id;
@property (nonatomic, retain) NSString * user_name;
@property (nonatomic, retain) NSDate * session_start_time;
@property (nonatomic, retain) NSDate * session_end_time;
@property (nonatomic, retain) NSNumber * session_duration;
@property (nonatomic, retain) NSNumber * sync_flag;

@end
