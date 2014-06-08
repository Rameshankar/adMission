//
//  StartViewController.m
//  adMission
//
//  Created by Satyen Vats on 06/06/2014.
//  Copyright (c) 2014 Motifworks. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController

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
    
    self.soundLabel.font              = [UIFont fontWithName:@"OpenSans-CondensedLight" size:18];
    self.startScanningLabel.font      = [UIFont fontWithName:@"OpenSans-CondensedBold" size:21];
    self.continuousScanningLabel.font = [UIFont fontWithName:@"OpenSans-CondensedLight" size:18];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startScanning:(id)sender {
   
}

- (IBAction)continuousScanning:(id)sender {
     NSLog(@"continuousScanning");
}

- (IBAction)sound:(id)sender {
     NSLog(@"soundScanning");
}
@end
