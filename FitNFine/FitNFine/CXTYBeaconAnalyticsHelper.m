//
//  CXTYBeaconAnalyticsHelper.m
//  FitNFine
//
//  Created by Satheeshwaran on 11/28/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import "CXTYBeaconAnalyticsHelper.h"
#import "CXTYBeaconAnalytics.h"
#import "CXTYConstants.h"
#import "CXTYCoreDataHelper.h"

@implementation CXTYBeaconAnalyticsHelper

- (void)postAllAnalyticsObjectsToServerWithAPIKey:(NSString *)apiKey
{
    
    NSString *urlStrng = [NSString stringWithFormat:@"%@%@",CONTEXTIVITY_WEB_API_BASE_URL,BEACON_ANALYTICS_SERVICE_URL];
    
    NSURL *serviceURL = [NSURL URLWithString:urlStrng];
    
    NSLog(@"serv url %@",urlStrng);
    
    
    
    for(CXTYBeaconAnalytics *analyticsObejct in [self getAllAnalyticsObjectsToBePosted])
    {
        
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:serviceURL];
        [urlRequest setHTTPMethod:@"POST"];
        [urlRequest setValue:apiKey forHTTPHeaderField:@"api_key"];

        NSMutableDictionary *postDict = [NSMutableDictionary dictionary];
        [postDict setObject:analyticsObejct.beacon_uuid forKey:@"beacon_uuid"];
        [postDict setObject:analyticsObejct.user_id forKey:@"user_id"];
        [postDict setObject:analyticsObejct.user_name forKey:@"user_name"];
        [postDict setObject:analyticsObejct.session_start_time.description forKey:@"session_start_time"];
        if(analyticsObejct.session_end_time == nil)
            analyticsObejct.session_end_time = [NSDate date];
        [postDict setObject:analyticsObejct.session_end_time.description forKey:@"session_end_time"];
        [postDict setObject:analyticsObejct.session_duration forKey:@"session_duration"];
        
        NSError *jsonWritingErr;
        
        [urlRequest setHTTPBody:[NSJSONSerialization dataWithJSONObject:postDict options:NSJSONWritingPrettyPrinted error:&jsonWritingErr]];
        
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            NSLog(@"response: %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            
            NSError *jsonReadingError;
            NSDictionary *beaconResults = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonReadingError];
            if([[beaconResults objectForKey:@"status"] isEqualToString:@"Success"])
            {
                analyticsObejct.sync_flag = 0;
                [[CXTYCoreDataHelper sharedHelper]saveContextToPersistentStore];
            }
            
        }];
    }
   
    
}

- (NSArray *)getAllAnalyticsObjectsToBePosted
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.predicate=[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"sync_flag==\"%d\"",1]];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CXTYBeaconAnalytics"
                                              inManagedObjectContext:[[CXTYCoreDataHelper sharedHelper] backgroundManagedObjectContext]];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [[[CXTYCoreDataHelper sharedHelper] backgroundManagedObjectContext]
                               executeFetchRequest:fetchRequest error:nil
                               ];
    
    return fetchedObjects;
}
@end
