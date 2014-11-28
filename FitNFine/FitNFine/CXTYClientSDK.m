//
//  CXTYClientSDK.m
//  FitNFine
//
//  Created by Satheeshwaran on 11/28/14.
//  Copyright (c) 2014 Cognizant. All rights reserved.
//

#import "CXTYClientSDK.h"
#import "CXTYCoreDataHelper.h"
#import "CXTYBeaconHelper.h"
#import "CXTYConstants.h"
#import "CXTYBeaconAnalyticsHelper.h"

@interface CXTYClientSDK()
{
    BOOL completedRegBeacon;
    BOOL completedRogueBeacon;
    BOOL completedAnalytics;
}

@property (nonatomic,copy)NSString *APIKey;
@property (nonatomic,strong)CXTYCoreDataHelper *coreDataHelper;
@property (nonatomic,strong)NSMutableArray *registeredBeacons;
@property (nonatomic,strong)NSMutableArray *rogueBeaoncs;

@end

@implementation CXTYClientSDK

static CXTYClientSDK  *sharedInstance = nil;
static NSString *coreDataModelName = @"CXTYDataModel";

+ (void)setSharedInstance:(id)controller
{
    sharedInstance = controller;
}

+ (instancetype)sharedInstance
{
    return sharedInstance;
}

+ (instancetype)sharedInstanceWithAPIKey:(NSString *)apiKey {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] initWithAPIKey:apiKey];
    });
    
    return sharedInstance;
}

- (instancetype)initWithAPIKey:(NSString *)apiKey
{
    self = [super init];
    if (self) {
        _APIKey = apiKey;
        _coreDataHelper = [CXTYCoreDataHelper sharedHelperWithModelName:coreDataModelName];
        //[_coreDataHelper createPersistentStoreCoordinator];
        [_coreDataHelper createManagedObjectContexts];
    }
    return self;
}

- (void)refreshSDKSettings
{
    CXTYBeaconHelper *beaconHelper = [[CXTYBeaconHelper alloc]init];
    
    [beaconHelper getAllRegisteredBeaconsForApiKey:self.APIKey andCompletionHandler:^(NSMutableArray *registeredBeacons) {
        completedRegBeacon = YES;
        self.registeredBeacons = registeredBeacons;
        [self checkWhetherToPostNotification];
    }];
    [beaconHelper getAllRogueBeaconsForApiKey:self.APIKey andCompletionHandler:^(NSMutableArray *registeredBeacons) {
        completedRogueBeacon = YES;
        self.rogueBeaoncs = registeredBeacons;
        [self checkWhetherToPostNotification];
    }];

}

- (void)pushAnalytics
{
    CXTYBeaconAnalyticsHelper *analyticsHelper = [[CXTYBeaconAnalyticsHelper alloc]init];
    [analyticsHelper postAllAnalyticsObjectsToServerWithAPIKey:self.APIKey];
}

- (void)checkWhetherToPostNotification
{
    if(completedRogueBeacon && completedRegBeacon)
    {
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:NOTIFICATION_FOR_SDK_REFRESH_SUCCESS object:nil]];
    }
}

- (NSMutableArray *)getRegisteredBeacons
{
    return self.registeredBeacons;
}

- (NSMutableArray *)getRogueBeacons
{
    return self.rogueBeaoncs;
}

- (void)postAnalyticsData:(NSMutableArray *)analyticsData
{
    
}
@end
