//
//  FNFLandingViewController.m
//  FitNFine
//
//  Created by Satheeshwaran on 8/18/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import "FNFLandingViewController.h"
#import "FNFAppDelegate.h"
#import "FNFInsuranceBackendHelper.h"
#import "UIViewController+XHLoadingNavigationItemTitle.h"
#import "FNFInsuranceBackendHelper.h"
#import "FNFHospitalCheckInViewController.h"

@interface FNFLandingViewController ()
{
    int selectedPolicy;
}
@end

@implementation FNFLandingViewController

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
    
    
    [[FNFInsuranceBackendHelper sharedHelper] fetchAndCacheInformation];
    
    self.title = @"Fit N Fine";
    
    self.loadingNavigationItemTitleView.titleColor = [UIColor whiteColor];
    self.loadingNavigationItemTitleView.titleFont = [UIFont fontWithName:@"HelveticaNeue-Regular" size:20];
    
    [self startAnimationTitle];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(syncCompleted) name:@"SyncCompleted" object:nil];
    
    // Do any additional setup after loading the view.
}

- (void)syncCompleted
{
    self.contentArray = [[NSMutableArray alloc]init];
    self.contentArray = (NSMutableArray *)[[FNFInsuranceBackendHelper sharedHelper]getPolicies];
    NSLog(@"GET POLICIES : %@",[[FNFInsuranceBackendHelper sharedHelper]getPolicies]);
    [self.tableView reloadData];
    [self stopAnimationTitle];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


- (IBAction)checkInClicked:(id)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    if (indexPath != nil)
    {
        //satheeshwaran ---
        NSLog(@"policy Major value : %d",[[[self.contentArray objectAtIndex:indexPath.row]objectForKey:@"policyMajor"]intValue]);
        
        selectedPolicy = indexPath.row;
    }
}
#pragma UITableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contentArray count];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *nav = segue.destinationViewController;
        FNFHospitalCheckInViewController *target = (FNFHospitalCheckInViewController *)nav.topViewController;
        target.policyDictionary = [self.contentArray objectAtIndex:selectedPolicy];
    }
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"landingviewcell"];
    UIView *contentView = [cell.contentView viewWithTag:405];
    contentView.layer.borderWidth = 1.f;
    //contentView.layer.borderColor = [UIColor colorWithWhite:0.496 alpha:1.000].CGColor;
    contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    UILabel *policyNameLabel = (UILabel *)[cell.contentView viewWithTag:501];
    UILabel *policyIdLabel = (UILabel *)[cell.contentView viewWithTag:502];
    UILabel *policyHolderNameLabel = (UILabel *)[cell.contentView viewWithTag:503];
    UILabel *policyAmountLabel = (UILabel *)[cell.contentView viewWithTag:504];
    UILabel *policyMaturityDateLabel = (UILabel *)[cell.contentView viewWithTag:505];
    UILabel *policyDependentsLabel = (UILabel *)[cell.contentView viewWithTag:506];
    UILabel *policyPremiumLabel = (UILabel *)[cell.contentView viewWithTag:507];
    UILabel *policyNextDueDateLabel = (UILabel *)[cell.contentView viewWithTag:508];
    
    NSMutableDictionary *localDictionary = [self.contentArray objectAtIndex:indexPath.row];
    
    policyNameLabel.text = [localDictionary objectForKey:@"policyName"];
    policyIdLabel.text = [NSString stringWithFormat:@"%d",[[localDictionary objectForKey:@"policyNumber"]intValue]];
    policyHolderNameLabel.text = [localDictionary objectForKey:@"policyNominee"];
    policyAmountLabel.text = [NSString stringWithFormat:@"$ %d.00",[[localDictionary objectForKey:@"policyAmount"]intValue]];
    //    policyMaturityDateLabel.text = [localDictionary objectForKey:@"policyExpiryDate"];
    policyDependentsLabel.text = [localDictionary objectForKey:@"policyNomineeRelationShip"];
    policyPremiumLabel.text = [NSString stringWithFormat:@"$%d.00",[[localDictionary objectForKey:@"premiumAmount"]intValue]];
    //    policyNextDueDateLabel.text = [localDictionary objectForKey:@"policyExpiryDate"];
    
    
    return cell;
}
@end
