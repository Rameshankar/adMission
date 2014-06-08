//
//  ScanViewController.h
//  adMission
//
//  Created by Satyen Vats on 06/06/2014.
//  Copyright (c) 2014 Motifworks. All rights reserved.
//

#import "StartViewController.h"

@interface ScanViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *validView;
@property (weak, nonatomic) IBOutlet UIView *invalidView;
@property (weak, nonatomic) IBOutlet UIView *continueScanningView;
@property (weak, nonatomic) IBOutlet UIView *stopScanningView;

@property (weak, nonatomic) IBOutlet UILabel *validLabel;
@property (weak, nonatomic) IBOutlet UILabel *invalidLabel;
@property (weak, nonatomic) IBOutlet UILabel *continueLabel;
@property (weak, nonatomic) IBOutlet UILabel *stopScanningLabel;
@property (weak, nonatomic) IBOutlet UILabel *backLabel;

@property (weak, nonatomic) IBOutlet UIImageView *photopic;
@property (weak, nonatomic) IBOutlet UIImageView *photoPicValid;

@property (strong, nonatomic) StartViewController *startScanningViewController;


- (IBAction)back:(id)sender;
- (IBAction)continueScan:(id)sender;
- (IBAction)stopScanning:(id)sender;

@end
