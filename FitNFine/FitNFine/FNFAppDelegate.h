//
//  FNFAppDelegate.h
//  FitNFine
//
//  Created by Satheeshwaran on 8/18/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNFBeaconCheckinAdvertiser.h"
#import "CXTYClientSDK.h"

@interface FNFAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FNFBeaconCheckinAdvertiser *beaconCheckInHelper;
@property (strong, nonatomic) CXTYClientSDK *sdk;
@end
