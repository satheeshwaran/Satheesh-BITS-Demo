//
//  FNFRightSidePaneViewController.m
//  FitNFine
//
//  Created by Satheeshwaran on 8/18/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import "FNFRightSidePaneViewController.h"
#import "UIViewController+RESideMenu.h"
#import "FNFInsuranceBackendHelper.h"

@interface FNFRightSidePaneViewController ()

@end

@implementation FNFRightSidePaneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.notificationDataArray = [[NSMutableArray alloc]init];
    self.notificationDataArray = (NSMutableArray *)[[FNFInsuranceBackendHelper sharedHelper]getNotifications];
    NSLog(@"Notification data: %@",[[FNFInsuranceBackendHelper sharedHelper]getNotifications]);
    NSMutableDictionary *localDictionary = (NSMutableDictionary *)[self.notificationDataArray lastObject];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightSideBarCell"];
    
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:501];
    UIImageView *iconImage= (UIImageView *)[cell.contentView viewWithTag:500];
    UILabel *timeLabel = (UILabel *)[cell.contentView viewWithTag:502];
    //    iconImage.image =
    //    titleLabel.text = @"You are Checked into the Apollo Hospital - Chennai";
    //    timeLabel.text = @"Yesterday    |    03.30 pm";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self.sideMenuViewController hideMenuViewController];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
