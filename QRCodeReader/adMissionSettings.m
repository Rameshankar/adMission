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
        }
    }
    return self;
}

#pragma mark - NSEncoding

- (id)initWithCoder:(NSCoder *)decoder {
 
    if (self = [super init]) {
        self.scanMode = [[decoder decodeObjectForKey:@"scanMode"] boolValue];
        self.soundMode = [[decoder decodeObjectForKey:@"soundMode"] boolValue];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[NSNumber numberWithBool:self.scanMode] forKey:@"scanMode"];
    [encoder encodeObject:[NSNumber numberWithBool:self.soundMode] forKey:@"soundMode"];
}

@end
