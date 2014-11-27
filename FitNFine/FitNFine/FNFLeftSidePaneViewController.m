//
//  FNFLeftSidePaneViewController.m
//  FitNFine
//
//  Created by Satheeshwaran on 8/18/14.
//  Copyright (c) 2014 Cognizant. All rights reserved.
//

#import "FNFLeftSidePaneViewController.h"
#import "RESideMenu.h"

@interface FNFLeftSidePaneViewController ()

@end

@implementation FNFLeftSidePaneViewController

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
- (IBAction)profileButtonClicked:(id)sender {
    [self.sideMenuViewController performSelector:@selector(profileClicked) withObject:nil];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sideBarCell"];
    
    UILabel *lbl = (UILabel *)[cell.contentView viewWithTag:101];
    UIImageView *img= (UIImageView *)[cell.contentView viewWithTag:100];
    
    switch (indexPath.row) {
        case 0:
        {
            lbl.text = @"Home";
            img.image = [UIImage imageNamed:@"menu_home"];

            break;
        }
        case 1:
        {
            lbl.text = @"Contact Us";
            img.image = [UIImage imageNamed:@"menu_contactus"];
            break;
        }
         case 2:
        {
            lbl.text = @"Settings";
            img.image = [UIImage imageNamed:@"menu_settings"];
            break;
        }
         case 3:
        {
            lbl.text = @"Logout";
            img.image = [UIImage imageNamed:@"menu_logout"];
            break;
        }
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            [self.sideMenuViewController hideMenuViewController];
            break;
        }
        case 1:
        {
            [self.sideMenuViewController performSelector:@selector(contactUsClicked) withObject:nil];
            [self.sideMenuViewController hideMenuViewController];
            break;
        }
        case 2:
        {
            [self.sideMenuViewController performSelector:@selector(settingsClicked) withObject:nil];
            [self.sideMenuViewController hideMenuViewController];
            break;
        }
        case 3:
        {
            [self.sideMenuViewController performSelector:@selector(logoutClicked) withObject:nil];
            [self.sideMenuViewController hideMenuViewController];

            break;
        }
        default:
            break;
    }
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
