//
//  FNFBeaconCheckinAdvertiser.m
//  FitNFine
//
//  Created by Satheeshwaran on 8/20/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import "FNFBeaconCheckinAdvertiser.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>




@interface FNFBeaconCheckinAdvertiser()<CBPeripheralManagerDelegate>

@property (nonatomic, strong)CBPeripheralManager *peripheralManager;

@property (nonatomic, copy)NSString *proxyID;
@property (nonatomic, copy)NSString *identifier;
@property (nonatomic, assign)int majorVal;
@property (nonatomic, assign)int minorVal;

@end

@implementation FNFBeaconCheckinAdvertiser

- (id)initWithProximityID:(NSString *)proxiID andIdentifier:(NSString *)identifier majorValue:(int)maj andMinorValue:(int)min
{
    
    self = [super init];
    if (self) {
        
        _proxyID = proxiID;
        _identifier = identifier;
        _majorVal = maj;
        _minorVal = min;
    }
    return self;
}
- (void)startAdvertisingWithIdentifier:(NSString *)identifier andProximityUUID:(NSString *)UUID major:(int)majorValue minor:(int)minorValue{
    
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:UUID];
    
    NSLog(@"uuid: %@ identifier: %@ major: %d minor: %d",UUID,identifier,majorValue,minorValue);
    
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid major:majorValue minor:minorValue identifier: identifier];
    
    
    NSDictionary *beaconPeripheralData = [beaconRegion peripheralDataWithMeasuredPower:nil];
    
    [self.peripheralManager startAdvertising:beaconPeripheralData];
    
    [self performSelector:@selector(stopCheckInProcess) withObject:nil afterDelay:10];
}

- (void)startCheckInProcess
{
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                     queue:nil
                                                                   options:nil];
    
    if (self.peripheralManager.state == CBPeripheralManagerStatePoweredOn) {
        
        [self startAdvertisingWithIdentifier:self.proxyID andProximityUUID:self.identifier major:self.majorVal minor:self.minorVal];
    }
}

- (void)stopCheckInProcess
{
    if(self.peripheralManager.state == CBPeripheralManagerStatePoweredOn)
    {
    NSLog(@"I guess beacon reciever should have recieved the signal, stopping check IN");
    [self.peripheralManager stopAdvertising];
    }
}
// =============================================================================
#pragma mark - CBPeripheralManagerDelegate

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error {
    
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    NSString *stateStr;
    
    switch (peripheral.state) {
        case CBPeripheralManagerStatePoweredOff:
        {
            stateStr = @"PoweredOff";
            break;
        }
        case CBPeripheralManagerStatePoweredOn:
        {
            stateStr = @"PoweredOn";
            
            [self startAdvertisingWithIdentifier:self.proxyID andProximityUUID:self.identifier major:self.majorVal minor:self.minorVal];
            
            break;
        }
        case CBPeripheralManagerStateResetting:
        {
            stateStr = @"Resetting";
            break;
        }
        case CBPeripheralManagerStateUnauthorized:
        {
            stateStr = @"Unauthorized";
            break;
        }
        case CBPeripheralManagerStateUnknown:
        {
            stateStr = @"Unknown";
            break;
        }
        case CBPeripheralManagerStateUnsupported:
        {
            stateStr = @"Unsupported";
            break;
        }
        default:
        {
            stateStr = nil;
            break;
        }
    }
    
    NSLog(@"state changed: %@",stateStr);
    
}
@end
