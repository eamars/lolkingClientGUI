//
//  summoner.m
//  lolkingClient
//
//  Created by Ran Bao on 11/4/13.
//  Copyright (c) 2013 R&B. All rights reserved.
//

#import "summoner.h"
#import "HTMLNode.h"
#import "HTMLParser.h"

@implementation summoner
{
	NSString *name;
	NSString *region;
	NSString *currentLevel;
	NSString *rankLevel;
	NSString *rankScore;
	NSString *rankWins;
	NSString *rankLooses;
	NSString *kda;
	NSString *icon;
	
}

-(void) initBriefData
{
	/* Download the data */
	// Combine the string with the sample url
	NSString *combinedSearchURL = [NSString stringWithFormat:@"%@%@", SEARCH_URL_TEMPLATE, name];
	
	// Construc search url with string
	NSURL *searchURL = [NSURL URLWithString:combinedSearchURL];
	
	// Download the content of result page
	NSData *data = [NSData dataWithContentsOfURL:searchURL];
	
	/* Parser html pages to extract useful data */
	HTMLParser *parser = [[HTMLParser alloc] initWithData:data error:nil];
	HTMLNode *bodyNode = [parser body];
	
	// Search for tags with "div"
	NSArray *divNodes = [bodyNode findChildTags:@"div"];
	
	for (HTMLNode *divNode in divNodes) {
		//Extract user part of html code
		if ([[divNode getAttributeNamed:@"style"] isEqualToString:@"float: left; text-align: center; padding: 5px; width: 262px;"])
		{
			NSArray *subDivNodes = [divNode findChildTags:@"div"];
			
			for (HTMLNode *subDivNode in subDivNodes){
				// Extract region
				if ([[subDivNode getAttributeNamed:@"style"] isEqualToString:@"font-size: 14px; display: block;"])
				{
					// if the region not fit, skip
					if (![[subDivNode allContents] isEqualToString:region]) {
						continue;
					}
					
				}
				// Extract currentlevel
				if ([[subDivNode getAttributeNamed:@"style"] isEqualToString:@"font-size: 12px; margin-top: 4px;"])
				{
					currentLevel = [subDivNode allContents];
				}
				// Extract RankedLevel
				if ([[subDivNode getAttributeNamed:@"style"] isEqualToString:@"font-size: 14px; color: #FFF; text-shadow: 0 0 1px #000;"])
				{
					rankLevel = [subDivNode allContents];
				}
				// Extract RankedScore
				if ([[subDivNode getAttributeNamed:@"style"] isEqualToString:@"display: inline-block; vertical-align: middle; font: bold 24px/32px \"Trebuchet MS\"; margin-left: 0px;"])
				{
					rankScore = [subDivNode allContents];
				}
				// if no rank
				if ([[subDivNode getAttributeNamed:@"style"] isEqualToString:@"font-size: 18px; color: #FFF; text-shadow: 0 0 1px #000;"])
				{
					rankLevel = [subDivNode allContents];
					rankScore = @"0";
				}
				
				if ([[subDivNode getAttributeNamed:@"style"] isEqualToString:@"display: table; width: 100%"])
				{
					NSArray *spanNodes = [subDivNode findChildTags:@"span"];
					for (HTMLNode *spanNode in spanNodes){
						//wins
						if ([[spanNode getAttributeNamed:@"style"] isEqualToString:@"font-weight: bold; font-size: 18px; line-height: 28px; color: #6C3;"]) {
							rankWins = [spanNode allContents];
						}
						//looses
						if ([[spanNode getAttributeNamed:@"style"] isEqualToString:@"font-weight: bold; font-size: 18px; line-height: 28px; color: #D77;"]) {
							rankLooses = [spanNode allContents];
						}
						//avg kda
						if ([[spanNode getAttributeNamed:@"style"] isEqualToString:@"font-weight: bold; font-size: 18px; line-height: 28px; color: #DA2;"]) {
							kda = [spanNode allContents];
						}
						
					}
				}
				// Extract Icons
				if ([[subDivNode getAttributeNamed:@"class"] isEqualToString:@"summoner_icon_64"])
				{
					NSString *iconURL = [subDivNode getAttributeNamed:@"style"];
					NSString *cutString = [[[[iconURL componentsSeparatedByString:@"profile_icons/"] objectAtIndex:1] componentsSeparatedByString:@")"] objectAtIndex:0];
					NSString *fullIconURL = [NSString stringWithFormat:@"%@%@", @"http://lkimg.zamimg.com/shared/riot/images/profile_icons/", cutString];
					
					icon = fullIconURL;
				}
			}
			
		}
	}

}

-(id) initWithSummonerName:(NSString *)summonerName region:(NSString *)summoneRegion{
	if (self = [super init]) {
		name = summonerName;
		region = summoneRegion;
		[self initBriefData];
	}
	return self;
}
-(NSString *)description{
	return [NSString stringWithFormat:@"Name: %@\nRegion: %@\nCurrentLevel: %@\nRankedLevel: %@\nRankedScore: %@\nRankWins: %@\nRankLooses: %@\nKDA: %@\nProfileIcon:%@", name, region, currentLevel, rankLevel, rankScore, rankWins, rankLooses, kda, icon];
}

-(NSString *)getCurrentLevel{
	return currentLevel;
}
-(NSString *)getRankedLevel{
	return rankLevel;
}
-(NSString *)getRankedScore{
	return rankScore;
}
-(NSString *)getRankedWins{
	return rankWins;
}
-(NSString *)getRankedLooses{
	return rankLooses;
}
-(NSString *)getKDA{
	return kda;
}
-(NSData *)getIcon{
	NSData *summonericon = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:icon]];
	return summonericon;
}


@end
