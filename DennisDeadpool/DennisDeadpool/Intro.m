//
//  Intro.m
//  DennisDeadpool
//
//  Created by Dennis Mostajo on 11/23/13.
//  Copyright 2013 Dennis Mostajo. All rights reserved.
//

#import "Intro.h"


@implementation Intro

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Intro *layer = [Intro node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init]))
    {
        CCLOG(@"EMPIEZA EL INTRO");
        
        // Se mide el tamaño de la ventana
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        // se inserta la imagen de fondo como Background para los 3 diferentes dispositivos
        
        CCSprite *background;
        
        if (IS_IPAD())
        {
             background = [CCSprite spriteWithFile:@"ipadintrobg.jpg"];
        }
        else
        {
            
            if ([[CCDirector sharedDirector] enableRetinaDisplay:YES])
             // el dispositivo tiene Retina HD?
            {
                
                background = [CCSprite spriteWithFile:@"iphoneIntrobghd.jpg"];
                
                //cambiar tamaño
                //CCAction *cambiarTamanio = [CCScaleTo actionWithDuration:0.0f scale:0.5f];
               // [self runAction:cambiarTamanio];

                
            }
            else
            {
             background = [CCSprite spriteWithFile:@"iphoneintrobg.jpg"];
            
            //cambiar tamaño
            //CCAction *cambiarTamanio = [CCScaleTo actionWithDuration:0.0f scale:0.5f];
            //[self runAction:cambiarTamanio];
            }
        }
        
        background.position = CGPointMake(size.width/2, size.height/2);
        [self addChild:background z:0];
        
        // se pone musica de fondo
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"intro.mp3" loop:YES];
       
        // se crea boton simple para empezar el juego
        
        [CCMenuItemFont setFontName:@"8BITWONDERNominal"];
        [CCMenuItemFont setFontSize:15];
        CCMenuItemFont *startNew = [CCMenuItemFont itemWithString:@"Empezar Demo" target:self selector: @selector(newGame)];
        CCMenu *menu = [CCMenu menuWithItems:startNew, nil];
        [menu alignItemsVerticallyWithPadding: 20.0f];

        [menu setPosition:ccp( size.width/2, size.height/2 - 150)];
        [self addChild:menu];
        
        // se carga al juego la animacion de presentacion
        
        
        // cargando los sprites
        
        CCSpriteBatchNode *DennisNode = [CCSpriteBatchNode batchNodeWithFile:@"DeadpoolAnimations.png"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"DeadpoolAnimations.plist"];
        
        //iniciando con la primera imagen por default
        Dennis  = [CCSprite spriteWithSpriteFrameName:@"DeadpoolTransform0.png"];
        Dennis.position   = ccp(size.width/2, size.height/2);
        
        // se carga los frames para toda la animcion
        NSMutableArray *DennisTransformIdleAnimFrames = [NSMutableArray array];
        
        for (int i = 0; i<10; i++)
        {
            [DennisTransformIdleAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"DeadpoolTransform%i.png", i]]];

        }
        for (int i=1; i<6; i++)
        {
            [DennisTransformIdleAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"DeadpoolNormal%i.png", i]]];
        }
        
        for (int i=1; i<6; i++)
        {
            [DennisTransformIdleAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"DeadpoolNormal%i.png", i]]];
        }
        for (int i=1; i<6; i++)
        {
            [DennisTransformIdleAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"DeadpoolNormal%i.png", i]]];
        }
        
        // se determina tiempos de animacion
        CCAnimation *DennisIdleAnim = [CCAnimation
                                    animationWithSpriteFrames:DennisTransformIdleAnimFrames delay:0.1f];
        DennisTransform = [[CCRepeatForever actionWithAction:
                          [CCAnimate actionWithAnimation:DennisIdleAnim]] retain];
        [Dennis runAction:DennisTransform];
        [DennisNode addChild:Dennis z:10];
        
      [self addChild:DennisNode z:5];
    }
	
	return self;
}

- (void)newGame
{
    // accion del boton
    //efectos de sonido
    [[SimpleAudioEngine sharedEngine] playEffect:@"Skfite4.wav"];
    [[SimpleAudioEngine sharedEngine] playEffect:@"select.wav"];
    
    // transicion al siguiente Layer
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[SelectPlayer node] withColor:ccWHITE]];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

@end
