//
//  Intro.h
//  DennisDeadpool
//
//  Created by Dennis Mostajo on 11/23/13.
//  Copyright 2013 Dennis Mostajo. All rights reserved.
//

#import <GameKit/GameKit.h>
#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "cocos2d.h"
#import "SimpleAudioEngine.h"
#import "SelectPlayer.h"
#import "Defines.h"

@interface Intro : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    CCSprite *Dennis;
    CCAction *DennisTransform;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
@end