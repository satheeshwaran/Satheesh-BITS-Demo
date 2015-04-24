//
//  CXTYBeaconHelper.h
//  FitNFine
//
//  Created by Satheeshwaran on 11/28/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXTYBeacon.h"
#import "CXTYRogueBeacon.h"

@interface CXTYBeaconHelper : NSObject

- (void)getAllRegisteredBeaconsForApiKey:(NSString *)apiKey  andCompletionHandler:(void (^)(NSMutableArray* registeredBeacons)) handler;
- (void)getAllRogueBeaconsForApiKey:(NSString *)apiKey  andCompletionHandler:(void (^)(NSMutableArray* registeredBeacons)) handler;

- (CXTYBeacon *)getExistingRegBeaconWithUUID:(NSString *)UUID;
- (CXTYRogueBeacon *)getExistingRogueBeaconWithUUID:(NSString *)UUID;

@end
