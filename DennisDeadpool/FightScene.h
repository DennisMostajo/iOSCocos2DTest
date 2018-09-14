//
//  FightScene.h
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
#import "SelectPlayer.h"
#import "ModalAlert.h"
#import <Social/Social.h>


@interface FightScene : CCLayer
{
   //---Joystick----//
    CCSprite *Joystick;
    CCSprite *ARRIBA;
    CCSprite *ABAJO;
    CCSprite *IZQUIERDA;
    CCSprite *DERECHA;
    CCSprite *PUNCH;
    CCSprite *KICK;
    CCSprite *POWER;
    CCSprite *TRANSFORM;
    
   //---PLayer----//
    CCSprite *Dennis;
    CCAction *DennisNormal;
    CCAction *DennisArriba;
    CCAction *DennisAbajo;
    CCAction *DennisAdelante;
    CCAction *DennisAtras;
    CCAction *DennisGolpe;
    CCAction *DennisPatada;
    CCAction *DennisPoder;
    CCAction *DennisTransformacion;
    CCAction *DennisDanger;
    
    //---Enemy-----//
    CCSprite *Smoke;
    CCAction *SmokeNormal;
    CCAction *SmokeArriba;
    //CCAction *DennisAbajo;
    CCAction *SmokeAdelante;
    CCAction *SmokeAtras;
    CCAction *SmokeGolpe;
    //CCAction *DennisPatada;
    //CCAction *DennisPoder;
    CCAction *SmokeTransformacion;
    //CCAction *DennisDanger;
    
    //---Barra de vidas---//
    CCProgressTimer *DennisHealthBar;
    CCProgressTimer *SmokeHealthBar;
    float DennisHealth;
    float SmokeHealth;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
