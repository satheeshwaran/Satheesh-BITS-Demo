//
//  FNFInsuranceBackendHelper.h
//  FitNFine
//
//  Created by Satheeshwaran on 8/23/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNFInsuranceBackendHelper : NSObject

+ (instancetype)sharedHelper;

- (void)fetchAndCacheInformation;
- (NSArray *)getUsers;
- (NSArray *)getPolicies;
- (NSArray *)getNotifications;
- (NSArray *)getHospitals;
- (NSArray *)getClaims;
- (NSArray *)getDependents;

@end
