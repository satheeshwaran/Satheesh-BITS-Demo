//
//  FNFAppDelegate.m
//  FitNFine
//
//  Created by Satheeshwaran on 8/18/14.
//  Copyright (c) 2014 Cognizant. All rights reserved.
//

#import "FNFAppDelegate.h"
#import "JAMBULNotificationsHelper.h"

#import "ESTBeaconManager.h"
#import <Parse/Parse.h>
#import "FNFInsuranceBackendHelper.h"

#import "CXTYConstants.h"
#import "CXTYBeacon.h"
#import "CXTYBeaconHelper.h"
#import "CXTYBeaconAnalytics.h"
#import "CXTYCoreDataHelper.h"

#define UUID @"B9407F30-F5F8-466E-AFF9-25556B57FE6D"
#define MAJOR 57875
#define MINOR 533

@interface FNFAppDelegate()<ESTBeaconManagerDelegate>


@property (nonatomic, strong) ESTBeacon         *beacon;
@property (nonatomic, strong) ESTBeaconManager  *beaconManager;
@property (nonatomic, strong) ESTBeaconRegion   *beaconRegion;
@property (nonatomic, strong) NSMutableDictionary *analyticsObjects;

@end

@implementation FNFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    application.statusBarStyle = UIStatusBarStyleLightContent;
    
    [[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithRed:0.210 green:0.743 blue:0.471 alpha:1.000]];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.210 green:0.743 blue:0.471 alpha:1.000]];
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:0.995 green:0.990 blue:0.990 alpha:1.000]];

    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:255.0/255.0 green:250.0/250.0 blue:240.0/240.0 alpha:1.0], NSForegroundColorAttributeName,                                                                        [UIFont fontWithName:@"Helvetica Neue Regular" size:20.0], NSFontAttributeName, nil]];    
    
    [Parse setApplicationId:@"1DSp32FGHGYPTPCxfhPdLL2q8oM1m836LnZ2wUCg"
                  clientKey:@"YXAv6gNR60RNg1Mmv7kER9OHHFv7eusv5nL2MU3n"];
    
    self.sdk = [CXTYClientSDK sharedInstanceWithAPIKey:@"oSTfaZegbTB3j2QAnb0nA42LxobMT9l9"];
    [self.sdk refreshSDKSettings];
    [self.sdk pushAnalytics];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(syncCompleted) name:@"SyncCompleted" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SDKRefreshComplete) name:NOTIFICATION_FOR_SDK_REFRESH_SUCCESS object:nil];

    self.analyticsObjects = [NSMutableDictionary dictionary];
    
    //self registerForHospitalBeacons];
    
    return YES;
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [self.sdk refreshSDKSettings];
    [self.sdk pushAnalytics];
}

- (void)SDKRefreshComplete
{
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    
    NSArray *beaconsToListenTo = [self.sdk getRegisteredBeacons];
    
    for (CXTYBeacon *beacon in beaconsToListenTo) {
        
        ESTBeaconRegion *bRegion = [[ESTBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:beacon.beaconUUID]
                                                                     major:[beacon.beaonMajor intValue]
                                                                     minor:[beacon.beaconMinor intValue]
                                                                identifier:beacon.beaconName];
        [self.beaconManager startMonitoringForRegion:bRegion];

    }
}

- (void)syncCompleted
{
    NSLog(@"users: %@  notifications: %@ policies: %@ claims: %@ dependents: %@ hospitals: %@",    [[FNFInsuranceBackendHelper sharedHelper] getUsers],[[FNFInsuranceBackendHelper sharedHelper] getNotifications],[[FNFInsuranceBackendHelper sharedHelper] getPolicies],[[FNFInsuranceBackendHelper sharedHelper] getClaims],[[FNFInsuranceBackendHelper sharedHelper] getDependents],[[FNFInsuranceBackendHelper sharedHelper] getHospitals]);
}

- (void)registerForHospitalBeacons
{
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    
    self.beaconRegion = [[ESTBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:UUID]
                                                                 major:MAJOR
                                                                 minor:MINOR
                                                            identifier:@"RegionIdentifier"];
    
    [self.beaconManager startMonitoringForRegion:self.beaconRegion];
}

#pragma mark - ESTBeaconManager delegate

- (void)beaconManager:(ESTBeaconManager *)manager didEnterRegion:(ESTBeaconRegion *)region
{
    CXTYBeaconHelper *helper = [[CXTYBeaconHelper alloc]init];
    CXTYBeacon *beacon = [helper getExistingRegBeaconWithUUID:region.proximityUUID.UUIDString];
    
    if(beacon)
    [JAMBULNotificationsHelper scheduleNotificationNowWithtext:beacon.beaconWelcomeMessage action:beacon.beaconAction sound:nil launchImage:nil andInfo:nil];

    else
    [JAMBULNotificationsHelper scheduleNotificationNowWithtext:@"Welcome To Apollo Hospitals!!" action:beacon.beaconAction sound:nil launchImage:nil andInfo:nil];
    
    [self startAnalyticsForBeacon:beacon];
}

- (void)beaconManager:(ESTBeaconManager *)manager didExitRegion:(ESTBeaconRegion *)region
{
    CXTYBeaconHelper *helper = [[CXTYBeaconHelper alloc]init];
    CXTYBeacon *beacon = [helper getExistingRegBeaconWithUUID:region.proximityUUID.UUIDString];
    
    if(beacon)
        [JAMBULNotificationsHelper scheduleNotificationNowWithtext:beacon.beaconExitMessage action:beacon.beaconAction sound:nil launchImage:nil andInfo:nil];
    
    else
        [JAMBULNotificationsHelper scheduleNotificationNowWithtext:@"Thank You For Visiting Apollo Hospitals" action:beacon.beaconAction sound:nil launchImage:nil andInfo:nil];
    
    [self stopAnalyticsForBeacon:beacon];
}

- (void)startAnalyticsForBeacon:(CXTYBeacon *)beacon
{
    if(![self.analyticsObjects.allKeys containsObject:beacon.beaconUUID])
    {
        NSLog(@"analytics session started");
        CXTYBeaconAnalytics *analyticsObject = [NSEntityDescription
                                              insertNewObjectForEntityForName:@"CXTYBeaconAnalytics"
                                              inManagedObjectContext:[[CXTYCoreDataHelper sharedHelper] backgroundManagedObjectContext]];
        analyticsObject.beacon_uuid = beacon.beaconUUID;
        analyticsObject.session_start_time = [NSDate date];
        analyticsObject.user_name = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_name"];
        analyticsObject.user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
        
        [[CXTYCoreDataHelper sharedHelper] saveContextToPersistentStore];

        [self.analyticsObjects setObject:analyticsObject forKey:beacon.beaconUUID];
        NSLog(@"analytics %@", analyticsObject);

    }
    
}

- (void)stopAnalyticsForBeacon:(CXTYBeacon *)beacon
{
    if([self.analyticsObjects.allKeys containsObject:beacon.beaconUUID])
    {
        CXTYBeaconAnalytics *analyticsObject = [self.analyticsObjects objectForKey:beacon.beaconUUID];
        analyticsObject.session_end_time = [NSDate date];
        analyticsObject.session_duration = [NSNumber numberWithInt:[analyticsObject.session_end_time timeIntervalSinceDate:analyticsObject.session_start_time]];
        analyticsObject.sync_flag = [NSNumber numberWithInt:1];
        NSLog(@"analytics session stopped %f", [analyticsObject.session_end_time timeIntervalSinceDate:analyticsObject.session_start_time]);
        NSLog(@"session duration %@", analyticsObject.session_duration);
        NSLog(@"analytics %@", analyticsObject);

        [[CXTYCoreDataHelper sharedHelper] saveContextToPersistentStore];
        [self.analyticsObjects removeAllObjects];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
