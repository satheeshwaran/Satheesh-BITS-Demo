//
//  DetailWindowController.m
//  FitNFineDesktop
//
//  Created by Naveen on 24/08/14.
//  Copyright (c) 2014 Parse. All rights reserved.
//

#import "DetailWindowController.h"

@interface DetailWindowController ()
@property (weak) IBOutlet NSView *headerView;
@property (weak) IBOutlet NSTextField *policyNameLabel;

@end

@implementation DetailWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
