//
//  adMissionSettings.h
//  adMission
//
//  Created by Satyen Vats on 08/06/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface adMissionSettings : NSObject

@property BOOL scanMode;
@property BOOL soundMode;
@property BOOL pauseMode;
@property NSMutableArray *validScanList;
@property NSMutableArray *invalidScanList;

- (BOOL)addToValidScan:(NSString *)scanedValue;
- (BOOL)addToInvalidScan:(NSString *)scanedValue;

@end
