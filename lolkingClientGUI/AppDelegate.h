//
//  AppDelegate.h
//  lolkingClientGUI
//
//  Created by Ran Bao on 11/5/13.
//  Copyright (c) 2013 R&B. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *summonerNameEntry;
@property (weak) IBOutlet NSTextField *currentLevelDisplay;
@property (weak) IBOutlet NSTextField *rankedLevelDisplay;
@property (weak) IBOutlet NSTextField *rankScoreDisplay;
@property (weak) IBOutlet NSTextField *averageKDADisplay;
@property (weak) IBOutlet NSTextField *winsDisplay;
@property (weak) IBOutlet NSTextField *loosesDisplay;
@property (weak) IBOutlet NSTextField *currentProgress;
@property (weak) IBOutlet NSPopUpButton *regionSelector;
@property (weak) IBOutlet NSImageView *summonerIcon;
@property (weak) IBOutlet NSTextField *version;

@end
