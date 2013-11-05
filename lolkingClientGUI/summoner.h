//
//  summoner.h
//  lolkingClient
//
//  Created by Ran Bao on 11/4/13.
//  Copyright (c) 2013 R&B. All rights reserved.
//

#import <Foundation/Foundation.h>
#define SEARCH_URL_TEMPLATE @"http://www.lolking.net/search?name="

@interface summoner : NSObject
-(id)initWithSummonerName:(NSString*)summonerName region:(NSString*)summonerRegion;
-(NSString *)description;
-(NSString *)getCurrentLevel;
-(NSString *)getRankedLevel;
-(NSString *)getRankedScore;
-(NSString *)getRankedWins;
-(NSString *)getRankedLooses;
-(NSString *)getKDA;
-(NSData *)getIcon;

@end
