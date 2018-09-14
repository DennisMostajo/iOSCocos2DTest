//
//  SelectPlayer.m
//  DennisDeadpool
//
//  Created by Dennis Mostajo on 11/23/13.
//  Copyright 2013 Dennis Mostajo. All rights reserved.
//

#import "SelectPlayer.h"


@implementation SelectPlayer
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	SelectPlayer *layer = [SelectPlayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init]))
    {
        CCLOG(@"EMPIEZA SELECCIONAR PERSONAJE");
        CGSize size = [[CCDirector sharedDirector] winSize];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"select.mp3" loop:YES];
        
        CCLabelTTF *_label = [[CCLabelTTF labelWithString:@"Selecciona tu Jugador"
                                   dimensions:CGSizeMake(320, 50) alignment:UITextAlignmentCenter
                                     fontName:@"8BITWONDERNominal" fontSize:10.0] retain];
        _label.position = ccp(size.width/2,
                              size.height-50);
        [self addChild:_label];
        
        
        // Standard method to create a button
        CCMenuItem *JugadorOne = [CCMenuItemImage
                                    itemFromNormalImage:@"Jugador1.png" selectedImage:@"Jugador1.png"
                                    target:self selector:@selector(JugadorUno:)];
        JugadorOne.position = ccp(150, 100);
        
        
        CCMenuItem *JugadorTwo = [CCMenuItemImage
                                  itemFromNormalImage:@"Jugador2.png" selectedImage:@"Jugador2.png"
                                  target:self selector:@selector(JugadorDos:)];
        JugadorTwo.position = ccp(210,100);
        
        CCMenuItem *JugadorThree = [CCMenuItemImage
                                  itemFromNormalImage:@"Jugador3.png" selectedImage:@"Jugador3.png"
                                  target:self selector:@selector(JugadorTres:)];
        JugadorThree.position = ccp(150, 30);
        
        
        CCMenuItem *JugadorFour = [CCMenuItemImage
                                  itemFromNormalImage:@"d1.png" selectedImage:@"d1.png"
                                  target:self selector:@selector(JugadorCuatro:)];
        JugadorFour.position = ccp(210,30);
        
        [CCMenuItemFont setFontName:@"8BITWONDERNominal"];
        [CCMenuItemFont setFontSize:15];
        
        CCMenuItemFont *Cancelar = [CCMenuItemFont itemWithString:@"Cancelar" target:self selector: @selector(Cancel)];
         Cancelar.position = ccp(50,-110);
        
    
        CCMenuItemFont *Okay = [CCMenuItemFont itemWithString:@"OK" target:self selector: @selector(Ok)];
        Okay.position = ccp(210, -110);

       
        
        CCMenu *starMenu = [CCMenu menuWithItems:JugadorOne,JugadorTwo,JugadorThree,JugadorFour,Cancelar,Okay, nil];
        starMenu.position = ccp(100,130);
        [self addChild:starMenu];
        
    
        Scorpion = [CCSprite spriteWithFile:@"ScorpionSelected.png"];
        Scorpion.position = ccp(-Scorpion.contentSize.width, 100);
        [self addChild:Scorpion];
        Smoke = [CCSprite spriteWithFile:@"SmokeSelected.png"];
        Smoke.position = ccp(-Smoke.contentSize.width, 100);
        [self addChild:Smoke];
        Dennis = [CCSprite spriteWithFile:@"DeadpoolSelected.png"];
        Dennis.position = ccp(-Dennis.contentSize.width, 100);
        [self addChild:Dennis];
        
        RIVAL = [CCSprite spriteWithFile:@"otherSelected.png"];
        RIVAL.position = ccp(-RIVAL.contentSize.width, 100);
        [self addChild:RIVAL];
        
      
    }
	
	return self;
}


- (void)JugadorUno:(id)sender {
    //[_label setString:@"Last button: *"];
    
    CCLOG(@"Jugador Uno");
    
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"select.wav"];
    CCAction *cambiarTamanio = [CCScaleTo actionWithDuration:0.2f scale:1.1f];
    [[SimpleAudioEngine sharedEngine] playEffect:@"Jugador1.wav"];
    [sender runAction:cambiarTamanio];
    
    [Scorpion runAction:[CCScaleTo actionWithDuration:0.0f scale:2.0f]];
    [Scorpion runAction:[CCMoveTo actionWithDuration:0.3f position:ccp(150, 200)]];
    
    [Smoke runAction:[CCScaleTo actionWithDuration:0.0f scale:1.0f]];
    [Smoke runAction:[CCMoveTo actionWithDuration:0.3f position:ccp(-Smoke.contentSize.width, 100)]];
    
    [Dennis runAction:[CCScaleTo actionWithDuration:0.0f scale:1.0f]];
    [Dennis runAction:[CCMoveTo actionWithDuration:0.3f position:ccp(-Dennis.contentSize.width, 100)]];
    
    [RIVAL runAction:[CCScaleTo actionWithDuration:0.0f scale:1.0f]];
    [RIVAL runAction:[CCMoveTo actionWithDuration:0.3f position:ccp(-RIVAL.contentSize.width, 100)]];
}

- (void)JugadorDos:(id)sender {
    //[_label setString:@"Last button: *"];
    
    CCLOG(@"Jugador Dos");
    [[SimpleAudioEngine sharedEngine] playEffect:@"select.wav"];
    CCAction *cambiarTamanio = [CCScaleTo actionWithDuration:0.2f scale:1.1f];
    [[SimpleAudioEngine sharedEngine] playEffect:@"Jugador2.wav"];
     [sender runAction:cambiarTamanio];
    
    [Smoke runAction:[CCScaleTo actionWithDuration:0.0f scale:2.0f]];
    [Smoke runAction:[CCMoveTo actionWithDuration:0.3f position:ccp(130, 200)]];
    
    [Scorpion runAction:[CCScaleTo actionWithDuration:0.0f scale:1.0f]];
    [Scorpion runAction:[CCMoveTo actionWithDuration:0.3f position:ccp(-Smoke.contentSize.width, 100)]];
    
    [Dennis runAction:[CCScaleTo actionWithDuration:0.0f scale:1.0f]];
    [Dennis runAction:[CCMoveTo actionWithDuration:0.3f position:ccp(-Dennis.contentSize.width, 100)]];
    
    [RIVAL runAction:[CCScaleTo actionWithDuration:0.0f scale:1.0f]];
    [RIVAL runAction:[CCMoveTo actionWithDuration:0.3f position:ccp(-RIVAL.contentSize.width, 100)]];
}

- (void)JugadorTres:(id)sender {
    //[_label setString:@"Last button: *"];
    
    CCLOG(@"Jugador Tres");
    [[SimpleAudioEngine sharedEngine] playEffect:@"select.wav"];
    CCAction *cambiarTamanio = [CCScaleTo actionWithDuration:0.2f scale:1.1f];
    [[SimpleAudioEngine sharedEngine] playEffect:@"Jugador3.wav"];
     [sender runAction:cambiarTamanio];
    
    [Dennis runAction:[CCScaleTo actionWithDuration:0.0f scale:2.0f]];
    [Dennis runAction:[CCMoveTo actionWithDuration:0.3f position:ccp(150, 180)]];
    
    [Smoke runAction:[CCScaleTo actionWithDuration:0.0f scale:1.0f]];
    [Smoke runAction:[CCMoveTo actionWithDuration:0.3f position:ccp(-Smoke.contentSize.width, 100)]];
    
    [Scorpion runAction:[CCScaleTo actionWithDuration:0.0f scale:1.0f]];
    [Scorpion runAction:[CCMoveTo actionWithDuration:0.3f position:ccp(-Dennis.contentSize.width, 100)]];
    
    [RIVAL runAction:[CCScaleTo actionWithDuration:0.0f scale:1.0f]];
    [RIVAL runAction:[CCMoveTo actionWithDuration:0.3f position:ccp(-RIVAL.contentSize.width, 100)]];
}

- (void)JugadorCuatro:(id)sender {
    //[_label setString:@"Last button: *"];
    
    CCLOG(@"Jugador Cuatro");
    [[SimpleAudioEngine sharedEngine] playEffect:@"select.wav"];
    CCAction *cambiarTamanio = [CCScaleTo actionWithDuration:0.2f scale:1.1f];
    [[SimpleAudioEngine sharedEngine] playEffect:@"Smokewins.wav"];
     [sender runAction:cambiarTamanio];
    
    [RIVAL runAction:[CCScaleTo actionWithDuration:0.0f scale:2.0f]];
    [RIVAL runAction:[CCMoveTo actionWithDuration:0.3f position:ccp(150, 200)]];
    
    [Smoke runAction:[CCScaleTo actionWithDuration:0.0f scale:1.0f]];
    [Smoke runAction:[CCMoveTo actionWithDuration:0.3f position:ccp(-Smoke.contentSize.width, 100)]];
    
    [Dennis runAction:[CCScaleTo actionWithDuration:0.0f scale:1.0f]];
    [Dennis runAction:[CCMoveTo actionWithDuration:0.3f position:ccp(-Dennis.contentSize.width, 100)]];
    
    [Scorpion runAction:[CCScaleTo actionWithDuration:0.0f scale:1.0f]];
    [Scorpion runAction:[CCMoveTo actionWithDuration:0.3f position:ccp(-RIVAL.contentSize.width, 100)]];
}


- (void)Cancel {
    //[_label setString:@"Last button: *"];
    
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"select.wav"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[Intro node] withColor:ccWHITE]];
}

- (void)Ok {
    //[_label setString:@"Last button: *"];
    
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"okay.wav"];
     [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[FightScene node] withColor:ccWHITE]];
}

@end
