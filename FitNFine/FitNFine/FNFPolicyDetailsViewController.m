//
//  FNFPolicyDetailsViewController.m
//  FitNFine
//
//  Created by Satheeshwaran on 8/22/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import "FNFPolicyDetailsViewController.h"
#import "DZNSegmentedControl.h"
#import "BasicInformationView.h"
#import "DependentInformationView.h"
#import "PolicyDetailsView.h"
#import "UIScrollView+APParallaxHeader.h"
#import "ClaimHistoryCell.h"
#import "A3ParallaxScrollView.h"
#import "FNFInsuranceBackendHelper.h"
#import "FNFHospitalCheckInViewController.h"

#define _allowAppearance    YES
#define _bakgroundColor     [UIColor colorWithRed:0/255.0 green:87/255.0 blue:173/255.0 alpha:1.0]
#define _tintColor          [UIColor colorWithRed:20/255.0 green:200/255.0 blue:255/255.0 alpha:1.0]
#define _hairlineColor      [UIColor colorWithRed:0/255.0 green:36/255.0 blue:100/255.0 alpha:1.0]

@interface FNFPolicyDetailsViewController () <DZNSegmentedControlDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSInteger tableViewPadding;
    NSInteger navBarStatusBarHeight;
    NSInteger selectedPolicy;
}
@property (nonatomic, strong) DZNSegmentedControl *control;
@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, strong) UITableView *tableView;




@end

@implementation FNFPolicyDetailsViewController

+ (void)load
{
    
    [[DZNSegmentedControl appearance] setBackgroundColor:[UIColor yellowColor]];
    [[DZNSegmentedControl appearance] setTintColor:[UIColor darkGrayColor]];
    [[DZNSegmentedControl appearance] setHairlineColor:_hairlineColor];
    
    [[DZNSegmentedControl appearance] setFont:[UIFont fontWithName:@"EuphemiaUCAS" size:14.0]];
    [[DZNSegmentedControl appearance] setSelectionIndicatorHeight:2.5];
    [[DZNSegmentedControl appearance] setAnimationDuration:0.125];
}

- (void)loadView
{
    [super loadView];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationBarButtonItems];

    [self setUBasicInformationData];
    tableViewPadding = 5;
    navBarStatusBarHeight = 64;
    _menuItems = @[@"Basic Information" , @"Policy Details" , @"Dependents Information", @"Claims History"];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0+tableViewPadding, navBarStatusBarHeight+tableViewPadding+60, self.view.frame.size.width-tableViewPadding*2, (self.view.frame.size.height - navBarStatusBarHeight - tableViewPadding*2)-60) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.hidden = YES;

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // self.tableView.tableHeaderView = self.control;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
   
    //self.basicInformationView.frame = CGRectMake(0, navBarStatusBarHeight+56, self.basicInformationView.frame.size.width,self.basicInformationView.frame.size.height );
    self.basicInformationView.hidden = NO;
    self.dependentInformationView.hidden = YES;
    self.policyDetailsInformationView.hidden = YES;
    

    // create ParallaxScrollView
    self.basicInformationView.contentScrollView.delegate = self;

    CGSize contentSize = self.basicInformationView.contentScrollView.frame.size;
    contentSize.height *= 1.2f;
   // self.basicInformationView.contentScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.basicInformationView.contentScrollView.contentSize = contentSize;
    
    // add header and content
    CGRect headerFrame = self.basicInformationView.userPhotoImageView.frame;
    //headerFrame.origin.y -= 120.0f;
    self.basicInformationView.userPhotoImageView.frame = headerFrame;

    self.control.frame = CGRectMake(0,64,self.control.frame.size.width, 100);
    self.control.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.control];
    NSMutableArray* imageArray = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed: @"fater.png"],[UIImage imageNamed:@"son.png"],[UIImage imageNamed:@"mother.png"],nil];
    [self loadUserPictureControl:imageArray];
    [self initPageControl:[imageArray count]];
    [self loadPolicyDetailData];

}

-(void)setNavigationBarButtonItems
{
    /*UIImage *image = [UIImage imageNamed:@"share-icon.png"];
    UIButton* requestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    requestButton.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [requestButton setImage:image forState:UIControlStateNormal];
    [requestButton addTarget:self action:@selector(requestButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *button2 = [[UIBarButtonItem alloc] initWithCustomView:requestButton];
    
    UIButton* shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setImage:image forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *button3 = [[UIBarButtonItem alloc] initWithCustomView:requestButton];
    
    self.navigationController.navigationItem.rightBarButtonItems = [[NSArray alloc]initWithObjects:button2,button3,nil];*/
    UIBarButtonItem *optionBtn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share-icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(sharePressed)];
    
    UIBarButtonItem* button2 = [[UIBarButtonItem alloc]initWithTitle:@"Check In" style:UIBarButtonItemStylePlain target:self action:@selector(checkInPressed)];
    
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:button2,optionBtn, nil];
    
}
-(void)sharePressed
{
    UIImage *yourImage = [UIImage imageNamed:@"userProfilePicRound.png"];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObjects:yourImage, nil] applicationActivities:nil];
    activityVC.excludedActivityTypes = @[ UIActivityTypeMessage ,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    [self presentViewController:activityVC animated:YES completion:nil];
}
-(void)checkInPressed
{
        selectedPolicy = 0;
    [self performSegueWithIdentifier:@"hospitalSeague" sender:self];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *nav = segue.destinationViewController;
        FNFHospitalCheckInViewController *target = (FNFHospitalCheckInViewController *)nav.topViewController;
        target.policyDictionary = [self.policyDataArray objectAtIndex:selectedPolicy];
    }
}

- (void)loadClaimData {
    NSLog(@"Claim historyL: %@",[[FNFInsuranceBackendHelper sharedHelper]getClaims]);
    self.claimDataArray = [[NSMutableArray alloc]init];
    self.claimDataArray = (NSMutableArray *)[[FNFInsuranceBackendHelper sharedHelper]getClaims];
    [self.tableView reloadData];
}

- (void)setUBasicInformationData
{
    NSLog(@"Claim historyL: %@",[[FNFInsuranceBackendHelper sharedHelper]getClaims]);
    self.contentArray = [[NSMutableArray alloc]init];
    self.contentArray = (NSMutableArray *)[[FNFInsuranceBackendHelper sharedHelper]getUsers];
    NSMutableDictionary *localDictionary = (NSMutableDictionary *)[self.contentArray lastObject];
    self.basicInformationView.firstNameTextField.text = [localDictionary objectForKey:@"firstName"];
    self.basicInformationView.lastNameTextField.text = [localDictionary objectForKey:@"lastName"];
    //    self.basicInformationView.ageDOBTextField.text = [localDictionary objectForKey:@"dateOfBirth"];
    self.basicInformationView.PANIDTextField.text = [localDictionary objectForKey:@"panNumber"];
    self.basicInformationView.communicationAddressTextField.text = [localDictionary objectForKey:@"currentAddress"];
    self.basicInformationView.permanentAddressTextField.text = [localDictionary objectForKey:@"permenantAddress"];
    self.basicInformationView.mobileTextField.text = [NSString stringWithFormat:@"%d",[[localDictionary objectForKey:@"Mobile"]intValue]];
    self.basicInformationView.landlineTextField.text = [NSString stringWithFormat:@"%d",[[localDictionary objectForKey:@"Landline"]intValue]];
    self.basicInformationView.emailTextField.text = [localDictionary objectForKey:@"email"];
    self.basicInformationView.maritalTextField.text = [localDictionary objectForKey:@"maritalStatus"];
    self.basicInformationView.kidsTextField.text = [NSString stringWithFormat:@"%d",[[localDictionary objectForKey:@"numberOfKids"]intValue]];
    self.basicInformationView.fpassportNumberTextField.text = [localDictionary objectForKey:@"passportNumber"];
}
- (void)loadPolicyDetailData {
    self.policyDataArray = [[NSMutableArray alloc]init];
    self.policyDataArray = (NSMutableArray *)[[FNFInsuranceBackendHelper sharedHelper]getPolicies];
    NSMutableDictionary *localDictionary = (NSMutableDictionary *)[self.policyDataArray lastObject];
    //    self.policyDetailsInformationView.firstNameTextField.text = [localDictionary objectForKey:@"firstName"];
    
    // implement outlet and assign the value for the same
    

    self.policyDetailsInformationView.policyNumberLabel.text = [NSString stringWithFormat:@"%d", [[localDictionary objectForKey:@"policyNumber"]intValue]];
    self.policyDetailsInformationView.policyNameLabel.text = [localDictionary objectForKey:@"policyName"];
    self.policyDetailsInformationView.policyAmountLabel.text = [NSString stringWithFormat:@"%d",[[localDictionary objectForKey:@"policyAmount"]intValue]];
    self.policyDetailsInformationView.premiumAmountLabel.text = [NSString stringWithFormat:@"%d",[[localDictionary objectForKey:@"premiumAmount"]intValue]];
//    self.policyDetailsInformationView.policyStartDataLabel.text = [localDictionary objectForKey:@"policyStartDate"];
    self.policyDetailsInformationView.planLabel.text = [localDictionary objectForKey:@"planType"];
    self.policyDetailsInformationView.planTypeLabel.text = [localDictionary objectForKey:@"planType"];
    //    [localDictionary objectForKey:@"policyNumber"];
    self.policyDetailsInformationView.nomineeLabel.text = [localDictionary objectForKey:@"policyNomineeRelationShip"];
//    [localDictionary objectForKey:@"policyNomineeRelationShip"];
}
- (void)loadDependentDetailsData:(NSInteger)position {
    self.dependentDetailArray = [[NSMutableArray alloc]init];
    self.dependentDetailArray = (NSMutableArray *)[[FNFInsuranceBackendHelper sharedHelper]getDependents];
    NSLog(@"get dependencies : %@",[[FNFInsuranceBackendHelper sharedHelper]getDependents]);
    
    NSMutableDictionary *localDictionary = (NSMutableDictionary *)[self.dependentDetailArray objectAtIndex:position];
    self.dependentInformationView.firstNameTextField.text = [localDictionary objectForKey:@"firstName"];
    self.dependentInformationView.lastNameTextField.text = [localDictionary objectForKey:@"lastName"];
//    self.dependentInformationView.ageDOBTextField.text = [localDictionary objectForKey:@"dateOfBirth"];
    self.dependentInformationView.PANIDTextField.text = [NSString stringWithFormat:@"%d",[[localDictionary objectForKey:@"panNumber"]intValue]];
    self.dependentInformationView.communicationAddressTextField.text = [localDictionary objectForKey:@"currentAddress"];
    self.dependentInformationView.permanentAddressTextField.text = [localDictionary objectForKey:@"permenantAddress"];
    self.dependentInformationView.mobileTextField.text = [NSString stringWithFormat:@"%d",[[localDictionary objectForKey:@"mobile"]intValue]];
    self.dependentInformationView.landlineTextField.text = [NSString stringWithFormat:@"%d",[[localDictionary objectForKey:@"landLine"]intValue]];
    self.dependentInformationView.emailTextField.text = [localDictionary objectForKey:@"emailAddress"];
    self.dependentInformationView.maritalTextField.text = [localDictionary objectForKey:@"maritalStatus"];
    self.dependentInformationView.kidsTextField.text = [localDictionary objectForKey:@"Kids"];
    self.dependentInformationView.fpassportNumberTextField.text = [NSString stringWithFormat:@"%d",[[localDictionary objectForKey:@"passportNumber"]intValue]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // accelerate header just with half speed down, but with normal speed up
    if (scrollView.contentOffset.y > 0) {
        [self.basicInformationView.contentScrollView setAcceleration:A3DefaultAcceleration forView:self.basicInformationView.userPhotoImageView];
    }else{
        [self.basicInformationView.contentScrollView setAcceleration:CGPointMake(0.0f, 0.5f) forView:self.basicInformationView.userPhotoImageView];
    }
    if([self.dependentInformationView isHidden] == NO)
    {
    NSInteger pageControlPosition =(scrollView.contentOffset.x / self.dependentInformationView.userPictureScrollView.frame.size.width);
    [self.dependentInformationView.pageControl setCurrentPage:pageControlPosition];
        [self loadDependentDetailsData:pageControlPosition];
    }
    
    

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (DZNSegmentedControl *)control
{
    if (!_control)
    {
        _control = [[DZNSegmentedControl alloc] initWithItems:self.menuItems];
        _control.delegate = self;
        _control.selectedSegmentIndex = 0;
        _control.bouncySelectionIndicator = YES;
        
        _control.showsGroupingSeparators = YES;
        _control.inverseTitles = YES;
        _control.backgroundColor = [UIColor whiteColor];
       _control.tintColor = [UIColor colorWithRed:0.982 green:1.000 blue:0.449 alpha:1.000];
       _control.hairlineColor = [UIColor purpleColor];
        _control.showsCount = NO;
        _control.selectionIndicatorHeight = 2.f;
        
        [_control addTarget:self action:@selector(selectedSegment:) forControlEvents:UIControlEventValueChanged];
        

        
        
    }
    return _control;
}

//** Load Images in the ScrollView **//
- (void)loadUserPictureControl:(NSMutableArray *)profileImageArray {
     self.dependentInformationView.userPictureScrollView .pagingEnabled = YES;
    float xPos = 0.0;
    CGSize scrollSize = self.dependentInformationView.userPictureScrollView.frame.size;
    float contentWidth = (scrollSize.width * [profileImageArray count]);
    [self.dependentInformationView.userPictureScrollView setContentSize:CGSizeMake(contentWidth, scrollSize.height)];
    for (UIImage *profileImage in profileImageArray) {
        UIImageView *contentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(xPos, 0.0, scrollSize.width, scrollSize.height)];
        [contentImageView setImage:profileImage];
        [self.dependentInformationView.userPictureScrollView addSubview:contentImageView];
        xPos += scrollSize.width;
    }
    
    
}

- (void)initPageControl:(NSInteger )viewCount {
    
    //self.dependentInformationView.pageControl.frame = CGRectMake(0,self.dependentInformationView.pageControl.frame.origin.y,50,50);
    
    //self.dependentInformationView.pageControl.backgroundColor=[UIColor blueColor];
    self.dependentInformationView.pageControl.currentPageIndicatorTintColor  = [UIColor colorWithRed:33.0f/255.0f green:126.0f/255.0f blue:95.0f/255.0f alpha:1];
      self.dependentInformationView.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:84.0f/255.0f green:252.0f/255.0f blue:136.0f/255.0f alpha:1];
    [self.dependentInformationView.pageControl setNumberOfPages:viewCount];
    
    self.dependentInformationView.pageControl.currentPage = 0;  // Indicate which page in default (0 for first page)
    //[self.view addSubview:self.dependentInformationView.pageControl];
    
    [self.dependentInformationView.pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
    //[self.dependentInformationView.userPictureScrollView bringSubviewToFront:self.dependentInformationView.pageControl];
}

-(void)pageTurn:(UIPageControl *) page
{
    int c=page.currentPage;
    CGRect frame = self.dependentInformationView.userPictureScrollView .frame;
    frame.origin.x = frame.size.width * c;
    frame.origin.y = 0;
    [self.dependentInformationView.userPictureScrollView  scrollRectToVisible:frame animated:YES];

}


#pragma mark -
#pragma mark UITABLEVIEW DELEGATES
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.claimDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableViewIdentifier = @"tableViewCellID";
    ClaimHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ClaimHistoryCell" owner:self options:nil]lastObject];
    }
    if(self.claimDataArray!= nil)
    {
      NSLog(@"%@ and %@",(NSMutableDictionary *)[self.claimDataArray objectAtIndex:indexPath.row],(NSString*)[(NSMutableDictionary *)[self.claimDataArray objectAtIndex:indexPath.row] objectForKey:@"claimHospital"]);

        
    NSMutableDictionary *localDictionary = (NSMutableDictionary *)[self.claimDataArray objectAtIndex:indexPath.row];
    cell.hospitalNameLabel.text = [NSString stringWithFormat:@"%@",[localDictionary objectForKey:@"claimHospital"]] ;
    cell.policyIdLabel.text = [NSString stringWithFormat:@"%@", [localDictionary objectForKey:@"polictyNumber"]];
    cell.customerNameLabel.text = [NSString stringWithFormat:@"%@",[localDictionary objectForKey:@"claimFor"]];
    cell.billAmountLabel.text = [NSString stringWithFormat:@"%@",[localDictionary objectForKey:@"claimAmount"]];
    cell.addmittedDateLabel.text = [self changeToDateFormat:[NSString stringWithFormat:@"%@",[localDictionary objectForKey:@"claimStartDate"]] ];
    cell.dischargeDateLabel.text = [self changeToDateFormat:[NSString stringWithFormat:@"%@",[localDictionary objectForKey:@"claimEndDate"]]];
   // cell.nextDueDateLabel.text = [localDictionary objectForKey:@""];
    }
    return cell;
  
}
/**
 *	This method Changes Date To Format
 */
-(NSString*)changeToDateFormat:(NSString*)dateString
{
    NSString *stringFromDate = @"";
    if ([dateString length]>0) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yyyy HH:mm:ss aaa"];
        //   NSDate *date = [dateFormatter dateFromString:@"5/16/2012 2:50:52 PM"];//application.releaseDate];
        NSDate *date = [dateFormatter dateFromString:dateString];
        
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"MM/dd/yyyy"];
        
        stringFromDate = [dateFormatter1 stringFromDate:date];
        
        //NSLog(@"%@ :ReleaseDate: %@\ndate: %@",stringFromDate,dateString, date);
    }
    return stringFromDate;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115.0f;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 30.0;
//}


#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - ViewController Methods

- (void)selectedSegment:(DZNSegmentedControl *)control
{
    
    //remove the subviews before adding
    self.basicInformationView.hidden = YES;
    self.dependentInformationView.hidden = YES;
    self.policyDetailsInformationView.hidden = YES;
    self.tableView.hidden = YES;

    switch (control.selectedSegmentIndex) {
        case 0:
        {
            [self setUBasicInformationData];
            self.basicInformationView.hidden = NO;

        }
            break;
        case 1:
        {
            [self loadPolicyDetailData];
            self.policyDetailsInformationView.hidden = NO;
        }
            break;
        case 2:
        {
            [self loadDependentDetailsData:0];
            self.dependentInformationView.hidden = NO;

        }
            break;
        case 3:
        {
            self.tableView.hidden = NO;
            [self loadClaimData];
        }
            break;
        default:
            break;
    }
}


#pragma mark - UIBarPositioningDelegate Methods

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)view
{
    return UIBarPositionBottom;
}

@end
