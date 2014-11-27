
//
//  JambulScannerClass.h
//  Scanner
//
//  Created by Preethi on 28/05/13.
//  Copyright (c) 2013 CTS. All rights reserved.
//

/**
    BarCode Scanner component takes the barcode which is scanned and returns the scanned data and the scanned image. The developer has to implement the delegate scanCompleted: which will be called back once the barcode is scanned.
 */

#import <Foundation/Foundation.h>
#import "ZBarReaderViewController.h"

//Protocol(Delegate) implementation - to notify sscanning is done
@protocol JambulBarCodeScannerDelegate<NSObject>
@required
- (void)scanCompleted:(NSString *)data andScannedImage:(UIImage *)image;
@optional
- (void)scanDidCancel;
@end

@interface JambulBarCodeScanner : NSObject<ZBarReaderDelegate>

@property (nonatomic,assign) id<JambulBarCodeScannerDelegate> delegate;

/**
 On calling this method, the camera scans the barcode.
 @param viewController viewController in which the scanner(camera) should be present.
 @return void.
  */
-(void)scanBarCode:(UIViewController*)viewController;
@end

