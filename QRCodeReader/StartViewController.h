//
//  StartScanningViewController.h
//  adMission
//
//  Created by Satyen Vats on 06/06/2014.
//  Copyright (c) 2014 Motifworks. All rights reserved.
//

@interface StartViewController : UIViewController{
    
}

@property (weak, nonatomic) IBOutlet UILabel *soundLabel;
@property (weak, nonatomic) IBOutlet UILabel *startScanningLabel;
@property (weak, nonatomic) IBOutlet UILabel *continuousScanningLabel;

- (IBAction)sound:(id)sender;
- (IBAction)startScanning:(id)sender;
- (IBAction)continuousScanning:(id)sender;

@end
