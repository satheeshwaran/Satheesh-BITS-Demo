//
//  CXTYBeaconAnalyticsHelper.h
//  FitNFine
//
//  Created by Satheeshwaran on 11/28/14.
//  Copyright (c) 2014 Cognizant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXTYBeaconAnalyticsHelper : NSObject

- (void)postAllAnalyticsObjectsToServerWithAPIKey:(NSString *)apiKey;
@end
