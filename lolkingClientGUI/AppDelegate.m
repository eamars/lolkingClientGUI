//
//  AppDelegate.m
//  lolkingClientGUI
//
//  Created by Ran Bao on 11/5/13.
//  Copyright (c) 2013 R&B. All rights reserved.
//

#import "AppDelegate.h"
#import "summoner.h"
#import "version.h"

@interface AppDelegate()
{
	NSImage *defaultIcon;
}
@end
@implementation AppDelegate

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
	
	
	// Set enter event when press enter at summonerNameEntry
	[summonerNameEntry setTarget:self];
	[summonerNameEntry setAction:@selector(enterPressed:)];
	
	// Add items to regionselector
	NSArray *regions = [NSArray arrayWithObjects:@"Oceania", @"North America", @"Europe West", @"Europe Nordic", @"Brazil", @"Turkey", @"Russia", @"Latin America North", @"Latin America South", nil];
	[regionSelector removeAllItems];
	[regionSelector addItemsWithTitles:regions];
	
	//load default image
	NSString *defaultIconPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/katarina.png"];
	// Set default image for summoner icon
	defaultIcon = [[NSImage alloc] initWithContentsOfFile:defaultIconPath];
	
	// load version
	version.stringValue = [NSString stringWithFormat:@"Version: %@", VERSION];
	
	
	
	[self initwindow];
}



@synthesize window;
@synthesize summonerNameEntry;
@synthesize currentLevelDisplay;
@synthesize rankedLevelDisplay;
@synthesize rankScoreDisplay;
@synthesize averageKDADisplay;
@synthesize winsDisplay;
@synthesize loosesDisplay;
@synthesize regionSelector;
@synthesize currentProgress;
@synthesize summonerIcon;
@synthesize version;

- (IBAction)searchButtonPressed:(NSButton *)sender {
	
	[self flushSearchRequest];
}
-(void)enterPressed:(id)sender
{
	[self flushSearchRequest];
}

-(void)flushSearchRequest
{
	[self initwindow];
	currentProgress.stringValue = [currentProgress.stringValue stringByAppendingString:@"\nRetrieving summoner data from lolking..."];

	summoner *result = [[summoner alloc] initWithSummonerName:summonerNameEntry.stringValue region:regionSelector.selectedItem.title];
	
	//currentProgress.stringValue = @"Displaying...";
	//set data
	currentLevelDisplay.stringValue = [result getCurrentLevel];
	rankedLevelDisplay.stringValue = [result getRankedLevel];
	rankScoreDisplay.stringValue = [result getRankedScore];
	averageKDADisplay.stringValue = [result getKDA];
	winsDisplay.stringValue = [result getRankedWins];
	loosesDisplay.stringValue = [result getRankedLooses];
	NSImage *icon = [[NSImage alloc] initWithData:[result getIcon]];
	[summonerIcon setImage:icon];
	
}

-(void)initwindow{
	// Set default progress
	currentProgress.stringValue = @"Stand by...";
	
	// set default icon
	[summonerIcon setImage:defaultIcon];
	
	
	
	//set default data
	currentLevelDisplay.stringValue = @"0";
	rankedLevelDisplay.stringValue = @"No Rating";
	rankScoreDisplay.stringValue = @"0";
	averageKDADisplay.stringValue = @"0/0/0";
	winsDisplay.stringValue = @"0";
	loosesDisplay.stringValue = @"0";
}



@end

