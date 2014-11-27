//
//  AppDelegate.h
//  ParseOSXStarterProject
//
//  Copyright 2014 Parse, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "DetailWindowController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    @private
    DetailWindowController *detailWindowController;
}

@property (assign) IBOutlet NSWindow *window;

@end
