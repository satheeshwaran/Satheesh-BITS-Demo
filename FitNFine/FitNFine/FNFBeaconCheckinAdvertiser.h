//
//  FNFBeaconCheckinAdvertiser.h
//  FitNFine
//
//  Created by Satheeshwaran on 8/20/14.
//  Copyright (c) 2014 Cognizant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FNFBeaconCheckinAdvertiser : NSObject

- (id)initWithProximityID:(NSString *)proxiID andIdentifier:(NSString *)identifier majorValue:(int)maj andMinorValue:(int)min;
- (void)startCheckInProcess;
- (void)stopCheckInProcess;

@end
