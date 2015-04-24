//
//  CXTYBeacon.h
//  FitNFine
//
//  Created by Satheeshwaran on 11/28/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CXTYBeacon : NSManagedObject

@property (nonatomic, retain) NSString * beaconAppID;
@property (nonatomic, retain) NSString * beaconUUID;
@property (nonatomic, retain) NSString * beaconName;
@property (nonatomic, retain) NSString * beaconManufacturer;
@property (nonatomic, retain) NSString * beaconLocation;
@property (nonatomic, retain) NSString * beaonMajor;
@property (nonatomic, retain) NSString * beaconMinor;
@property (nonatomic, retain) NSString * beaconWelcomeMessage;
@property (nonatomic, retain) NSString * beaconExitMessage;
@property (nonatomic, retain) NSString * beaconAction;

@end
