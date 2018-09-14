//
//  SelectPlayer.h
//  DennisDeadpool
//
//  Created by Dennis Mostajo on 11/23/13.
//  Copyright 2013 Dennis Mostajo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"
#import "Defines.h"
#import "Intro.h"
#import "FightScene.h"

@interface SelectPlayer : CCLayer
{
    CCSprite *Scorpion;
    CCSprite *Smoke;
    CCSprite *Dennis;
    CCSprite *RIVAL;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
@end
