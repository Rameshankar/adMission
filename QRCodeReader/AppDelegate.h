//
//  AppDelegate.h
//  adMission
//
//  Created by Satyen Vats on 06/06/2014.
//  Copyright (c) 2014 Motifworks. All rights reserved.
//

#import "adMissionSettings.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) adMissionSettings *settings;

+ (AppDelegate *)delegate;
+ (adMissionSettings *)settings;

@end
