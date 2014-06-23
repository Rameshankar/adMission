//
//  adMissionSettings.m
//  adMission
//
//  Created by Satyen Vats on 08/06/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "adMissionSettings.h"

@implementation adMissionSettings

- (id)init
{
    self = [super init];
    if (self) {
        NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
        NSData *savedUserData = [standardDefaults objectForKey:@"admissionsettings"];
        if (savedUserData != nil) {
            self = [NSKeyedUnarchiver unarchiveObjectWithData:savedUserData];
        } else {
            self.scanMode = TRUE;
            self.soundMode = TRUE;
            self.pauseMode = FALSE;
            self.validScanList = [[NSMutableArray alloc] init];
            self.invalidScanList = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

#pragma mark - NSEncoding

- (id)initWithCoder:(NSCoder *)decoder {
 
    if (self = [super init]) {
        self.scanMode = [[decoder decodeObjectForKey:@"scanMode"] boolValue];
        self.soundMode = [[decoder decodeObjectForKey:@"soundMode"] boolValue];
        self.pauseMode = [[decoder decodeObjectForKey:@"scanMode"] boolValue];
        self.validScanList = [decoder decodeObjectForKey:@"validScanList"];
        self.invalidScanList = [decoder decodeObjectForKey:@"invalidScanList"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[NSNumber numberWithBool:self.scanMode] forKey:@"scanMode"];
    [encoder encodeObject:[NSNumber numberWithBool:self.soundMode] forKey:@"soundMode"];
    [encoder encodeObject:[NSNumber numberWithBool:self.pauseMode] forKey:@"pauseMode"];
    [encoder encodeObject:self.validScanList forKey:@"validScanList"];
    [encoder encodeObject:self.invalidScanList forKey:@"invalidScanList"];
}

- (BOOL)addToValidScan:(NSString *)scanedValue;
{
    if ([self.validScanList containsObject:scanedValue]) {
        return FALSE;
    }
    [self.validScanList addObject:scanedValue];
    return TRUE;
}

- (BOOL)addToInvalidScan:(NSString *)scanedValue;
{
    if ([self.invalidScanList containsObject:scanedValue]) {
        return FALSE;
    }
    [self.invalidScanList addObject:scanedValue];
    return TRUE;
}

@end
