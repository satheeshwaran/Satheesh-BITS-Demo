//
//  FNFInsuranceBackendHelper.m
//  FitNFine
//
//  Created by Satheeshwaran on 8/23/14.
//  Copyright (c) 2014 Cognizant. All rights reserved.
//

#import "FNFInsuranceBackendHelper.h"
#import <Parse/Parse.h>

@interface FNFInsuranceBackendHelper()
{
    NSArray *users;
    NSArray *policies;
    NSArray *hospitals;
    NSArray *claims;
    NSArray *notifications;
    NSArray *dependents;
}

@end

@implementation FNFInsuranceBackendHelper


static FNFInsuranceBackendHelper  *sharedHelper = nil;

+ (instancetype)sharedHelper
{
    static dispatch_once_t onceSyncKit;
    dispatch_once(&onceSyncKit, ^{
        sharedHelper = [[self alloc] init];
    });
    
    return sharedHelper;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}


- (void)fetchAndCacheInformation
{
    [self fetchUsers];
}

/**
 *	This method helps to set values to NSUserDefaults
 */

-(void)userDefaultsSetObject:(id)userObject forKey:(NSString *)userKey
{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userObject forKey:userKey];
    [userDefaults synchronize];
}

/**
 *	This method helps to get values from NSUserDefaults
 */

-(id)userDefaultsGetObjectForKey:(NSString *)userKey
{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:userKey];
}

- (void)fetchUsers
{
    PFQuery *query = [PFUser query];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d users.", objects.count);
            users = [NSArray arrayWithArray:objects];
            // Do something with the found objects
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
        [self fetchPolicies];

    }];

}

- (void)fetchNotifications
{
    PFQuery *query = [PFQuery queryWithClassName:@"Notification"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;

    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %d notifications.", objects.count);
            // Do something with the found objects
            notifications = [NSArray arrayWithArray:objects];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SyncCompleted" object:nil];

        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

- (void)fetchHospitals
{
    PFQuery *query = [PFQuery queryWithClassName:@"Hospital"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;

    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %d hospitals.", objects.count);
            // Do something with the found objects
            hospitals = [NSArray arrayWithArray:objects];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
        [self fetchClaims];

    }];
    
}

- (void)fetchClaims
{
    PFQuery *query = [PFQuery queryWithClassName:@"Claim"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %d claims.", objects.count);
            // Do something with the found objects
            claims = [NSArray arrayWithArray:objects];
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
        [self fetchNotifications];

    }];
    
}

- (void)fetchDependencies
{
    PFQuery *query = [PFQuery queryWithClassName:@"Dependent"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %d dependents.", objects.count);
            // Do something with the found objects
            dependents = [NSArray arrayWithArray:objects];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        [self fetchHospitals];

    }];
    
}

- (void)fetchPolicies
{
    PFQuery *query = [PFQuery queryWithClassName:@"Policy"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %d policies.", objects.count);
            // Do something with the found objects
            policies = [NSArray arrayWithArray:objects];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
        [self fetchDependencies];

    }];
}

- (NSArray *)getUsers
{
    if(users != nil)
        return users;
    else
        return [self userDefaultsGetObjectForKey:@"User"];
}

- (NSArray *)getPolicies
{
    if(policies != nil)
        return policies;
    else
        return [self userDefaultsGetObjectForKey:@"Policy"];
}


- (NSArray *)getNotifications
{
    if(notifications != nil)
        return notifications;
    else
        return [self userDefaultsGetObjectForKey:@"Notification"];
}


- (NSArray *)getHospitals
{
    if(hospitals != nil)
        return hospitals;
    else
        return [self userDefaultsGetObjectForKey:@"Hospital"];
}


- (NSArray *)getClaims
{
    if(claims != nil)
        return claims;
    else
        return [self userDefaultsGetObjectForKey:@"Claim"];
}

- (NSArray *)getDependents
{
    if(dependents != nil)
        return dependents;
    else
        return [self userDefaultsGetObjectForKey:@"Dependent"];
}

@end
