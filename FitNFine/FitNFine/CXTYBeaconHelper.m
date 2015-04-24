//
//  CXTYBeaconHelper.m
//  FitNFine
//
//  Created by Satheeshwaran on 11/28/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import "CXTYBeaconHelper.h"
#import "CXTYConstants.h"
#import "CXTYBeacon.h"
#import "CXTYRogueBeacon.h"
#import "CXTYCoreDataHelper.h"

@implementation CXTYBeaconHelper

- (void)getAllRegisteredBeaconsForApiKey:(NSString *)apiKey  andCompletionHandler:(void (^)(NSMutableArray* registeredBeacons)) handler
{
    
    NSString *urlStrng = [NSString stringWithFormat:@"%@%@",CONTEXTIVITY_WEB_API_BASE_URL,REGISTERED_BEACONS_SERVICE_URL];
    
    NSURL *serviceURL = [NSURL URLWithString:urlStrng];
    
    NSLog(@"serv url %@",urlStrng);
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:serviceURL];
    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setValue:apiKey forHTTPHeaderField:@"api_key"];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSLog(@"response: %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        NSError *jsonReadingError;
        NSDictionary *beaconResults = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonReadingError];
        NSArray *beaconArray = [beaconResults objectForKey:@"results"];
        
        for (id object in beaconArray) {
            
            if([[CXTYCoreDataHelper sharedHelper] checkAttributeWithAttributeName:@"beaconUUID" InEntityWithEntityName:@"CXTYBeacon" ForPreviousItems:[object objectForKey:@"beacon_uuid"] inContext:[[CXTYCoreDataHelper sharedHelper] backgroundManagedObjectContext]])
            {
                CXTYBeacon *beaconObject = [self getExistingRegBeaconWithUUID:[object objectForKey:@"beacon_uuid"] ];
                if(beaconObject!=nil)
                {
                    beaconObject.beaconName = [object objectForKey:@"beacon_name"];
                    beaconObject.beaconUUID = [object objectForKey:@"beacon_uuid"];
                    beaconObject.beaconAppID = [object objectForKey:@"beacon_app_id"];
                    beaconObject.beaonMajor = [object objectForKey:@"beacon_major_value"];
                    beaconObject.beaconMinor = [object objectForKey:@"beacon_minor_value"];
                    beaconObject.beaconWelcomeMessage = [object objectForKey:@"beacon_broadcast_message"];
                    beaconObject.beaconExitMessage = [object objectForKey:@"beacon_exit_message"];
                    beaconObject.beaconAction = [object objectForKey:@"beacon_broadcast_action"];
                    beaconObject.beaconManufacturer = [object objectForKey:@"beacon_manufacturer"];
                    beaconObject.beaconLocation = [object objectForKey:@"beacon_location"];

                }
            }
            else
            {
                CXTYBeacon *beaconObject = [NSEntityDescription
                                            insertNewObjectForEntityForName:@"CXTYBeacon"
                                            inManagedObjectContext:[[CXTYCoreDataHelper sharedHelper] backgroundManagedObjectContext]];
                beaconObject.beaconName = [object objectForKey:@"beacon_name"];
                beaconObject.beaconUUID = [object objectForKey:@"beacon_uuid"];
                beaconObject.beaconAppID = [object objectForKey:@"beacon_app_id"];
                beaconObject.beaonMajor = [object objectForKey:@"beacon_major_value"];
                beaconObject.beaconMinor = [object objectForKey:@"beacon_minor_value"];
                beaconObject.beaconWelcomeMessage = [object objectForKey:@"beacon_broadcast_message"];
                beaconObject.beaconExitMessage = [object objectForKey:@"beacon_exit_message"];
                beaconObject.beaconAction = [object objectForKey:@"beacon_broadcast_action"];
                beaconObject.beaconManufacturer = [object objectForKey:@"beacon_manufacturer"];
                beaconObject.beaconLocation = [object objectForKey:@"beacon_location"];
            }


        }
        
        [[CXTYCoreDataHelper sharedHelper] saveContextToPersistentStore];

        handler([NSMutableArray arrayWithArray:[self getAllRegBacons]]);

    }];
    
}

- (void)getAllRogueBeaconsForApiKey:(NSString *)apiKey  andCompletionHandler:(void (^)(NSMutableArray* registeredBeacons)) handler
{
   
    NSString *urlStrng = [NSString stringWithFormat:@"%@%@",CONTEXTIVITY_WEB_API_BASE_URL,ROGUE_BEACONS_SERVICE_URL];
    
    NSURL *serviceURL = [NSURL URLWithString:urlStrng];
    
    NSLog(@"serv url %@",urlStrng);
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:serviceURL];
    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setValue:apiKey forHTTPHeaderField:@"api_key"];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSLog(@"response: %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        NSError *jsonReadingError;
        NSDictionary *beaconResults = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonReadingError];
        NSArray *beaconArray = [beaconResults objectForKey:@"results"];
        
        for (id object in beaconArray) {
            
            if([[CXTYCoreDataHelper sharedHelper] checkAttributeWithAttributeName:@"beaconUUID" InEntityWithEntityName:@"CXTYRogueBeacon" ForPreviousItems:[object objectForKey:@"beacon_uuid"] inContext:[[CXTYCoreDataHelper sharedHelper] backgroundManagedObjectContext]])
            {
                CXTYRogueBeacon *beaconObject = [self getExistingRogueBeaconWithUUID:[object objectForKey:@"beacon_uuid"] ];
                if(beaconObject!=nil)
                {
                    beaconObject.beaconName = [object objectForKey:@"beacon_name"];
                    beaconObject.beaconUUID = [object objectForKey:@"beacon_uuid"];
                    beaconObject.beaconAppID = [object objectForKey:@"beacon_app_id"];
                    beaconObject.beaonMajor = [object objectForKey:@"beacon_major_value"];
                    beaconObject.beaconMinor = [object objectForKey:@"beacon_minor_value"];
                    beaconObject.beaconWelcomeMessage = [object objectForKey:@"beacon_broadcast_message"];
                    beaconObject.beaconExitMessage = [object objectForKey:@"beacon_exit_message"];
                    beaconObject.beaconAction = [object objectForKey:@"beacon_broadcast_action"];
                    beaconObject.beaconManufacturer = [object objectForKey:@"beacon_manufacturer"];
                    beaconObject.beaconLocation = [object objectForKey:@"beacon_location"];
                    
                }
            }
            else
            {
            CXTYRogueBeacon *rogueBeaconObject = [NSEntityDescription
                                        insertNewObjectForEntityForName:@"CXTYRogueBeacon"
                                        inManagedObjectContext:[[CXTYCoreDataHelper sharedHelper] backgroundManagedObjectContext]];
            rogueBeaconObject.beaconName = [object objectForKey:@"beacon_name"];
            rogueBeaconObject.beaconUUID = [object objectForKey:@"beacon_uuid"];
            rogueBeaconObject.beaconAppID = [object objectForKey:@"beacon_app_id"];
            rogueBeaconObject.beaonMajor = [object objectForKey:@"beacon_major_value"];
            rogueBeaconObject.beaconMinor = [object objectForKey:@"beacon_minor_value"];
            rogueBeaconObject.beaconWelcomeMessage = [object objectForKey:@"beacon_broadcast_message"];
            rogueBeaconObject.beaconExitMessage = [object objectForKey:@"beacon_exit_message"];
            rogueBeaconObject.beaconAction = [object objectForKey:@"beacon_broadcast_action"];
            rogueBeaconObject.beaconManufacturer = [object objectForKey:@"beacon_manufacturer"];
            rogueBeaconObject.beaconLocation = [object objectForKey:@"beacon_location"];
            }
        }
        
        [[CXTYCoreDataHelper sharedHelper] saveContextToPersistentStore];
        
        handler([NSMutableArray arrayWithArray:[self getAllRogueBeacons]]);
        
    }];
    
}


- (NSArray *)getAllRegBacons
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CXTYBeacon"
                                              inManagedObjectContext:[[CXTYCoreDataHelper sharedHelper] backgroundManagedObjectContext]];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [[[CXTYCoreDataHelper sharedHelper] backgroundManagedObjectContext]
                               executeFetchRequest:fetchRequest error:nil
                               ];
    
    return fetchedObjects;

}

- (NSArray *)getAllRogueBeacons
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CXTYRogueBeacon"
                                              inManagedObjectContext:[[CXTYCoreDataHelper sharedHelper] backgroundManagedObjectContext]];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [[[CXTYCoreDataHelper sharedHelper] backgroundManagedObjectContext]
                               executeFetchRequest:fetchRequest error:nil
                               ];
    
        return fetchedObjects;

}

- (CXTYBeacon *)getExistingRegBeaconWithUUID:(NSString *)UUID
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.predicate=[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"beaconUUID ==\"%@\"",UUID]];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CXTYBeacon"
                                              inManagedObjectContext:[[CXTYCoreDataHelper sharedHelper] backgroundManagedObjectContext]];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [[[CXTYCoreDataHelper sharedHelper] backgroundManagedObjectContext]
                               executeFetchRequest:fetchRequest error:nil
                               ];
    
    if ([fetchedObjects count]>0) {
        return [fetchedObjects objectAtIndex:0];
    }
    
    return nil;
}

- (CXTYRogueBeacon *)getExistingRogueBeaconWithUUID:(NSString *)UUID
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.predicate=[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"beaconUUID ==\"%@\"",UUID]];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CXTYRogueBeacon"
                                              inManagedObjectContext:[[CXTYCoreDataHelper sharedHelper] backgroundManagedObjectContext]];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [[[CXTYCoreDataHelper sharedHelper] backgroundManagedObjectContext]
                               executeFetchRequest:fetchRequest error:nil
                               ];
    
    if ([fetchedObjects count]>0) {
        return [fetchedObjects objectAtIndex:0];
    }
    
    return nil;
}
@end
