//
//  FNFAppDelegate.h
//  FitNFine
//
//  Created by Satheeshwaran on 8/18/14.
//  Copyright (c) 2014 Cognizant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNFBeaconCheckinAdvertiser.h"

@interface FNFAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FNFBeaconCheckinAdvertiser *beaconCheckInHelper;
@end
