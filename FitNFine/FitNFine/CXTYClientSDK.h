//
//  CXTYClientSDK.h
//  FitNFine
//
//  Created by Satheeshwaran on 11/28/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXTYClientSDK : NSObject

+ (void)setSharedInstance:(id)controller;
+ (instancetype)sharedInstance;
+ (instancetype)sharedInstanceWithAPIKey:(NSString *)apiKey;
- (instancetype)initWithAPIKey:(NSString *)apiKey;

- (void)refreshSDKSettings;
- (void)pushAnalytics;
- (NSMutableArray *)getRegisteredBeacons;
- (NSMutableArray *)getRogueBeacons;

@end
