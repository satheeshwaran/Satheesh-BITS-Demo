//
//  AppDelegate.m
//  ParseOSXStarterProject
//
//  Copyright 2014 Parse, Inc. All rights reserved.
//

#import <ParseOSX/Parse.h>

#import "AppDelegate.h"
#import <IOBluetooth/IOBluetooth.h>
#import "FNFInsuranceBackendHelper.h"
//#import "MainViewController.h"
#import "CustomTableCellView.h"

#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

#define UUID_REJECTED @"B9407F30-F5F8-466E-AFF9-25556B57FE6D"

#define MAJOR 57875
#define MINOR 533


@interface AppDelegate() <CBCentralManagerDelegate, CBPeripheralDelegate>
{
    NSMutableArray *patientCheckIns;
    NSArray *rejectedBeacons;
}
//@property (nonatomic,strong) MainViewController *mainViewController;

@property (nonatomic, strong) CBCentralManager *manager;

@property (nonatomic, strong) NSMutableArray *beacons;
@property (nonatomic, strong) NSMutableDictionary *foundBeacons;

@property (nonatomic) BOOL canScan;
@property (nonatomic) BOOL isScanning;

@property (nonatomic, strong) NSTimer *scanTimer;


@property (weak) IBOutlet NSTableView *tableViewList;
@property (weak) IBOutlet NSSearchField *searchTextField;

@end

static const NSTimeInterval kScanTimeInterval = 1.0;

#pragma mark -
#pragma mark NSApplicationDelegate

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    rejectedBeacons = @[@"B9407F30-F5F8-466E-AFF9-25556B57FE6D",@"F3D6EA1C-A1FA-465E-BE88-F2FCE072E985",@"88551D48-3D04-4CDE-BEB5-E884D1573AE5",@"2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6",@"3E8D2719-4C43-4A2B-B54F-E83BDF35675C",@"DFC04066-8BC4-4570-8E43-E4E3F301B4A0"];
    
    patientCheckIns = [NSMutableArray array];

    [Parse setApplicationId:@"1DSp32FGHGYPTPCxfhPdLL2q8oM1m836LnZ2wUCg"
                  clientKey:@"YXAv6gNR60RNg1Mmv7kER9OHHFv7eusv5nL2MU3n"];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(syncCompleted) name:@"SyncCompleted" object:nil];
    
    [[FNFInsuranceBackendHelper sharedHelper] fetchAndCacheInformation];
    
    // Insert code here to initialize your application
//    self.mainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
//    [self.window.contentView addSubview:self.mainViewController.view];
//    self.mainViewController.view.frame = ((NSView*)self.window.contentView).bounds;
}

- (void)patientCheckedIn:(NSArray *)arr
{
    
    NSString *userName =  [NSString stringWithFormat:@"%@ %@",[[arr objectAtIndex:0] objectForKey:@"firstName"],[[arr objectAtIndex:0] objectForKey:@"lastName"]];
    NSString *patienName = [NSString stringWithFormat:@"%@ %@",[[arr objectAtIndex:2] objectForKey:@"firstName"],[[arr objectAtIndex:2] objectForKey:@"lastName"]];
    NSString *policyID = [NSString stringWithFormat:@"%@",[[arr objectAtIndex:1] objectForKey:@"policyNumber"]];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjects:@[userName,patienName,policyID] forKeys:@[@"user",@"patient",@"policy"]];
    
    [patientCheckIns addObject:dict];
    
    [self.tableViewList reloadData];
    
}
#pragma mark -
#pragma mark NSTableViewDelegate
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return patientCheckIns.count;
}


- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    
    NSString *identifier = @"TheCell";
    CustomTableCellView *customTableViewCell = [tableView makeViewWithIdentifier:identifier owner:self];
    
    customTableViewCell.userNameTextFieldLabel.stringValue = [[patientCheckIns objectAtIndex:row] objectForKey:@"patient"];
    customTableViewCell.userNameLabel.stringValue = [[patientCheckIns objectAtIndex:row] objectForKey:@"user"];
    customTableViewCell.policyTextFieldLabel.stringValue = [[patientCheckIns objectAtIndex:row] objectForKey:@"policy"];
    
    customTableViewCell.checkInDate.stringValue = [NSString stringWithFormat:@"Just Now, %@", [self timeFromNSDate:[NSDate date]]];
    
    return customTableViewCell;
}

-  (NSDateComponents *)componentsForDate:(NSDate *)date
{
    if (date!=nil)
    {
        NSCalendar *gregorian = [[NSCalendar alloc]
                                 initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSDateComponents *dayComponents =
        [gregorian components:DATE_COMPONENTS fromDate:date];
        
        return dayComponents;
    }
    
    return nil;
}

- (NSString *)timeFromNSDate:(NSDate *)date
{
    int hour=[self componentsForDate:date].hour;
    int minute=[self componentsForDate:date].minute;
    
    
    NSString *returnDateString=@"";
    if (hour <= 9 ) {
        returnDateString=[NSString stringWithFormat:@"0%d", hour];
    }
    
    else {
        returnDateString=[NSString stringWithFormat:@"%d", hour];
    }
    
    if (minute <= 9 ) {
        returnDateString= [returnDateString stringByAppendingFormat:@":%@", [NSString stringWithFormat:@"0%d", minute]];
    }
    
    else {
        returnDateString= [returnDateString stringByAppendingFormat:@":%@", [NSString stringWithFormat:@"%d", minute]];
    }
    
    
    return returnDateString;
}
- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
{
    detailWindowController = [[DetailWindowController alloc]initWithWindowNibName:@"DetailWindow"];
    [detailWindowController showWindow:self];
}


- (void)syncCompleted
{
    NSLog(@"users: %@  notifications: %@ policies: %@ claims: %@ dependents: %@ hospitals: %@",    [[FNFInsuranceBackendHelper sharedHelper] getUsers],[[FNFInsuranceBackendHelper sharedHelper] getNotifications],[[FNFInsuranceBackendHelper sharedHelper] getPolicies],[[FNFInsuranceBackendHelper sharedHelper] getClaims],[[FNFInsuranceBackendHelper sharedHelper] getDependents],[[FNFInsuranceBackendHelper sharedHelper] getHospitals]);
    
    self.manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
}

-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    if (self.manager.state == CBCentralManagerStatePoweredOn)
    {
        self.canScan = YES;
        [self startScanning];
    }
    else
    {
        self.canScan = NO;
    }
    
    switch (central.state)
    {
        case CBCentralManagerStatePoweredOff:
            break;
        case CBCentralManagerStatePoweredOn:
            break;
        case CBCentralManagerStateResetting:
            break;
        case CBCentralManagerStateUnauthorized:
            break;
        case CBCentralManagerStateUnsupported:
            break;
        case CBCentralManagerStateUnknown:
        default:
            break;
    }
}

-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSData *advData = [advertisementData objectForKey:@"kCBAdvDataManufacturerData"];
    if ([self advDataIsBeacon:advData])
    {
        
        NSMutableDictionary *beacon = [NSMutableDictionary dictionaryWithDictionary:[self getBeaconInfoFromData:advData]];

        if ( [rejectedBeacons containsObject:beacon[@"uuid"]]) {
            NSLog(@"rejected hospital beacon with UUID %@",peripheral.identifier.UUIDString);
            return;
        }
        
        //rssi
        [beacon setObject:RSSI forKey:@"RSSI"];
        
        //peripheral uuid
        [beacon setObject:peripheral.identifier.UUIDString forKey:@"deviceUUID"];
        
        //distance
        NSNumber *distance = [self calculatedDistance:[beacon objectForKey:@"power"] RSSI:RSSI];
        if (distance) {
            [beacon setObject:distance forKey:@"distance"];
        }
        
        //proximity
        [beacon setObject:[self proximityFromDistance:distance] forKey:@"proximity"];
        
        //combined uuid
        NSString *uniqueUUID = peripheral.identifier.UUIDString;
        NSString *beaconUUID = beacon[@"uuid"];
        
        if (beaconUUID) {
            uniqueUUID = [uniqueUUID stringByAppendingString:beaconUUID];
        }
        
        //add to beacon dictionary
        [self.foundBeacons setObject:beacon forKey:uniqueUUID];
    }
}

- (NSString *)proximityFromDistance:(NSNumber *)distance
{
    if (distance == nil) {
        distance = @(-1);
    }
    
    if (distance.doubleValue >= 2.0)
        return @"Far";
    if (distance.doubleValue >= 0.25)
        return @"Near";
    if (distance.doubleValue >= 0)
        return @"immediate";
    return @"Unknown";
}

//algorythm taken from http://stackoverflow.com/a/20434019/814389
//I've seen this method mentioned a couple of times but cannot verify its accuracy
- (NSNumber *)calculatedDistance:(NSNumber *)txPowerNum RSSI:(NSNumber *)RSSINum
{
    int txPower = [txPowerNum intValue];
    double rssi = [RSSINum doubleValue];
    
    if (rssi == 0) {
        return nil; // if we cannot determine accuracy, return nil.
    }
    
    double ratio = rssi * 1.0 / txPower;
    if (ratio < 1.0) {
        return @(pow(ratio, 10.0));
    }
    else {
        double accuracy =  (0.89976) * pow(ratio, 7.7095) + 0.111;
        return @(accuracy);
    }
}

- (BOOL)advDataIsBeacon:(NSData *)data
{
    //TODO: could this be cleaner?
    Byte expectingBytes [4] = { 0x4c, 0x00, 0x02, 0x15 };
    NSData *expectingData = [NSData dataWithBytes:expectingBytes length:sizeof(expectingBytes)];
    
    if (data.length > expectingData.length)
    {
        if ([[data subdataWithRange:NSMakeRange(0, expectingData.length)] isEqual:expectingData])
        {
            return YES;
        }
    }
    
    return NO;
}

- (NSDictionary *)getBeaconInfoFromData:(NSData *)data
{
    NSRange uuidRange = NSMakeRange(4, 16);
    NSRange majorRange = NSMakeRange(20, 2);
    NSRange minorRange = NSMakeRange(22, 2);
    NSRange powerRange = NSMakeRange(24, 1);
    
    Byte uuidBytes[16];
    [data getBytes:&uuidBytes range:uuidRange];
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDBytes:uuidBytes];
    
    uint16_t majorBytes;
    [data getBytes:&majorBytes range:majorRange];
    uint16_t majorBytesBig = (majorBytes >> 8) | (majorBytes << 8);
    
    uint16_t minorBytes;
    [data getBytes:&minorBytes range:minorRange];
    uint16_t minorBytesBig = (minorBytes >> 8) | (minorBytes << 8);
    
    int8_t powerByte;
    [data getBytes:&powerByte range:powerRange];
    
    return @{ @"uuid" : uuid.UUIDString, @"major" : @(majorBytesBig), @"minor" : @(minorBytesBig), @"power" : @(powerByte) };
}

#pragma mark - Scanning

- (BOOL)startScanning
{
    if (self.canScan)
    {
        if (self.scanTimer)
            [self.scanTimer invalidate];
        
        self.isScanning = YES;
        
        [self.manager scanForPeripheralsWithServices:nil options:nil];
        
        self.scanTimer = [NSTimer scheduledTimerWithTimeInterval:kScanTimeInterval target:self selector:@selector(timerDidFire) userInfo:nil repeats:NO];
        
        NSLog(@"started scanning");
        return YES;
    }
    NSLog(@"unable to start scan");
    return NO;
}

- (void)stopScanning
{
    [self.manager stopScan];
    self.isScanning = NO;
    [self.scanTimer invalidate];
}

- (void)timerDidFire
{
    NSLog(@"found beacons during scan: %@",[self.foundBeacons allValues]);
    self.beacons = [[self.foundBeacons allValues] mutableCopy];
    
    [self.foundBeacons removeAllObjects];
    [self stopScanning];
    
    if(self.beacons.count>0)
        [self compareBeaconDataForMatchingUserData];
    else
        [self startScanning];

}

- (void)compareBeaconDataForMatchingUserData
{
    for (NSDictionary *beaconData in self.beacons)
    {
        for(id users in [[FNFInsuranceBackendHelper sharedHelper] getUsers])
        {
            if([[beaconData objectForKey:@"uuid"] isEqualToString:[users objectForKey:@"userUUID"]])
            {
                NSLog(@"found matching user");
                
                for(id policies in [[FNFInsuranceBackendHelper sharedHelper] getPolicies])
                {
                    if([[beaconData objectForKey:@"major"] integerValue] == [[policies objectForKey:@"policyMajor"] integerValue])
                    {
                        NSLog(@"found matching policy");
                        
                        for(id dependent in [[FNFInsuranceBackendHelper sharedHelper] getDependents])
                        {
                            if([[beaconData objectForKey:@"minor"] integerValue] == [[dependent objectForKey:@"dependentMinor"] integerValue])
                            {
                                NSLog(@"found matching patient");
                                NSArray *tArray =[NSArray arrayWithObjects:users,policies,dependent, nil];
                                [self foundPatientCheckByUserWithData:tArray];
                                return;
                            }
                        }
                    }
                }
            }
        }
    }
    
    [self startScanning];
}

- (void)foundPatientCheckByUserWithData:(NSArray *)arr
{
    [self performSelector:@selector(startScanning) withObject:nil afterDelay:10];
    
    NSLog(@"arr: %@",arr);
    
    [self patientCheckedIn:arr];
    

}

#pragma mark - Button Updating

-(void)setIsScanning:(BOOL)isScanning
{
    if (_isScanning != isScanning)
    {
        _isScanning = isScanning;
    }
}

-(void)setCanScan:(BOOL)canScan
{
    if (_canScan != canScan)
    {
        _canScan = canScan;
    }
}

#pragma mark - Lazy Loading

-(NSMutableDictionary *)foundBeacons
{
    if (!_foundBeacons) {
        _foundBeacons = [NSMutableDictionary new];
    }
    return _foundBeacons;
}


@end
