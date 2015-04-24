//
//  FNFLandingViewController.h
//  FitNFine
//
//  Created by Satheeshwaran on 8/18/14.
//  Copyright (c) 2014 Satheeshwaran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@interface FNFLandingViewController : UIViewController
@property (nonatomic,retain)NSMutableArray *contentArray;
@property (nonatomic,weak) IBOutlet UITableView *tableView;

@end
