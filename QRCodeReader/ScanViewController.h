//
//  ScanViewController.h
//  QRCodeReader
//
//  Created by Sankar on 06/06/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StartScanningViewController.h"

@interface ScanViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *validView;
@property (weak, nonatomic) IBOutlet UIView *invalidView;
@property (weak, nonatomic) IBOutlet UIView *stopScanningView;

@property (weak, nonatomic) IBOutlet UILabel *validLabel;
@property (weak, nonatomic) IBOutlet UILabel *invalidLabel;
@property (weak, nonatomic) IBOutlet UILabel *continueLabel;
@property (weak, nonatomic) IBOutlet UILabel *stopScanningLabel;

@property (weak, nonatomic) IBOutlet UIImageView *photopic;
@property (weak, nonatomic) IBOutlet UIImageView *photoPicValid;

@property (strong, nonatomic) StartScanningViewController *startScanningViewController;


- (IBAction)continue:(id)sender;
- (IBAction)stopScanning:(id)sender;

@end
