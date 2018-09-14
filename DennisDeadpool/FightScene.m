//
//  FightScene.m
//  DennisDeadpool
//
//  Created by Dennis Mostajo on 11/23/13.
//  Copyright 2013 Dennis Mostajo. All rights reserved.
//

#import "FightScene.h"


@implementation FightScene
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	FightScene *layer = [FightScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init]))
    {
        CCLOG(@"EMPIEZA LA PELEA");
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        CCSprite *background;
        
        if (IS_IPAD())
        {
            background = [CCSprite spriteWithFile:@"iPadBackground.png"];
        }
        else
        {
            if (IS_IPHONE_5)
            {
                 background = [CCSprite spriteWithFile:@"iPhone5Background.png"];
            }
            else
            {
                 background = [CCSprite spriteWithFile:@"iPhone4SBackground.png"];
            }


        }
        
        background.position = CGPointMake(size.width/2, size.height/2);
        [self addChild:background z:-1];
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"FightMusicBackground.mp3" loop:YES];
        
        Joystick = [CCSprite spriteWithFile:@"BaseJoystick.png"];
        Joystick.position = ccp(65,65);
        Joystick.opacity = 50;
        [self addChild:Joystick];
        
        //CCAction *cambiarTamanio = [CCScaleTo actionWithDuration:0.0f scale:0.5f];
        // [self runAction:cambiarTamanio];
        
        self.isTouchEnabled = YES;
        
        [self Iniciar_Controles];
        
        [self Iniciar_Jugador];
        [self Iniciar_Enemigo];
     
        
        [self Iniciar_HUD];
        [self Iniciar_Intro];
                
    }
	
	return self;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector]convertToGL:location];
    
    CCSprite *botonARRIBA = (CCSprite *)[self getChildByTag:1];
    if (CGRectContainsPoint([botonARRIBA boundingBox], location))
    {
        [botonARRIBA runAction:[CCSequence actions:
                                [CCScaleTo actionWithDuration:0.1f
                                                        scale:0.7],
                                [CCScaleTo actionWithDuration:0.1f scale:0.5],
                                [CCCallFunc actionWithTarget:self selector:@selector(movimiento_arriba)]
                            
                                , nil]];
    }
    
    CCSprite *botonABAJO = (CCSprite *)[self getChildByTag:2];
    if (CGRectContainsPoint([botonABAJO boundingBox], location))
    {
        [botonABAJO runAction:[CCSequence actions:
                                [CCScaleTo actionWithDuration:0.1f scale:0.7],
                                [CCScaleTo actionWithDuration:0.1f scale:0.5],
                                [CCCallFunc actionWithTarget:self selector:@selector(movimiento_abajo)]
                                , nil]];
    }
    
    CCSprite *botonIZQUIERDA = (CCSprite *)[self getChildByTag:3];
    if (CGRectContainsPoint([botonIZQUIERDA boundingBox], location))
    {
        [botonIZQUIERDA runAction:[CCSequence actions:
                                [CCScaleTo actionWithDuration:0.1f scale:0.7],
                                [CCScaleTo actionWithDuration:0.1f scale:0.5],
                                [CCCallFunc actionWithTarget:self selector:@selector(movimiento_izquierda)]
                                , nil]];
    }
    
    CCSprite *botonDERECHA = (CCSprite *)[self getChildByTag:4];
    if (CGRectContainsPoint([botonDERECHA boundingBox], location))
    {
        [botonDERECHA runAction:[CCSequence actions:
                                [CCScaleTo actionWithDuration:0.1f scale:0.7],
                                [CCScaleTo actionWithDuration:0.1f scale:0.5],
                                [CCCallFunc actionWithTarget:self selector:@selector(movimiento_derecha)]
                                , nil]];
    }
    
    CCSprite *botonPUNCH = (CCSprite *)[self getChildByTag:5];
    if (CGRectContainsPoint([botonPUNCH boundingBox], location))
    {
        [botonPUNCH runAction:[CCSequence actions:
                                 [CCScaleTo actionWithDuration:0.1f scale:1.3],
                                 [CCScaleTo actionWithDuration:0.1f scale:1.0],
                                 [CCCallFunc actionWithTarget:self selector:@selector(golpe)]
                                 , nil]];
    }
    
    CCSprite *botonKICK = (CCSprite *)[self getChildByTag:6];
    if (CGRectContainsPoint([botonKICK boundingBox], location))
    {
        [botonKICK runAction:[CCSequence actions:
                                 [CCScaleTo actionWithDuration:0.1f scale:1.3],
                                 [CCScaleTo actionWithDuration:0.1f scale:1.0],
                                 [CCCallFunc actionWithTarget:self selector:@selector(patada)]
                                 , nil]];
    }
    
    CCSprite *botonPOWER = (CCSprite *)[self getChildByTag:7];
    if (CGRectContainsPoint([botonPOWER boundingBox], location))
    {
        [botonPOWER runAction:[CCSequence actions:
                                 [CCScaleTo actionWithDuration:0.1f scale:1.3],
                                 [CCScaleTo actionWithDuration:0.1f scale:1.0],
                                 [CCCallFunc actionWithTarget:self selector:@selector(poder)]
                                 , nil]];
    }
    
    CCSprite *botonTRANSFORM = (CCSprite *)[self getChildByTag:8];
    if (CGRectContainsPoint([botonTRANSFORM boundingBox], location))
    {
        [botonTRANSFORM runAction:[CCSequence actions:
                                 [CCScaleTo actionWithDuration:0.1f scale:1.3],
                                 [CCScaleTo actionWithDuration:0.1f scale:1.0],
                                 [CCCallFunc actionWithTarget:self selector:@selector(transformacion)]
                                 , nil]];
    }
    
    
}

-(void)Iniciar_Controles
{
    ARRIBA = [CCSprite spriteWithFile:@"Joystick.png"];
    ARRIBA.position = ccp(65,110);
    ARRIBA.opacity = 50;
    ARRIBA.scaleX = 0.5;
    ARRIBA.scaleY = 0.5;
    ARRIBA.tag = 1;
    [self addChild:ARRIBA z:1];
    
    ABAJO = [CCSprite spriteWithFile:@"Joystick.png"];
    ABAJO.position = ccp(65,20);
    ABAJO.opacity = 50;
    ABAJO.scaleX = 0.5;
    ABAJO.scaleY = 0.5;
    ABAJO.tag = 2;
    [self addChild:ABAJO z:1];
    
    IZQUIERDA = [CCSprite spriteWithFile:@"Joystick.png"];
    IZQUIERDA.position = ccp(20,65);
    IZQUIERDA.opacity = 50;
    IZQUIERDA.scaleX = 0.5;
    IZQUIERDA.scaleY = 0.5;
    IZQUIERDA.tag = 3;
    [self addChild:IZQUIERDA z:1];
    
    DERECHA = [CCSprite spriteWithFile:@"Joystick.png"];
    DERECHA.position = ccp(110
                           ,65);
    DERECHA.opacity = 50;
    DERECHA.scaleX = 0.5;
    DERECHA.scaleY = 0.5;
    DERECHA.tag = 4;
    [self addChild:DERECHA z:1];
    
    PUNCH = [CCSprite spriteWithFile:@"punch.png"];
    PUNCH.position = ccp(380,100);
    PUNCH.opacity = 95;
    //PUNCH.scaleX = 0.5;
    //PUNCH.scaleY = 0.5;
    PUNCH.tag = 5;
    [self addChild:PUNCH z:1];
    
    KICK = [CCSprite spriteWithFile:@"kick.png"];
    KICK.position = ccp(445,100);
    KICK.opacity = 95;
    //KICK.scaleX = 0.5;
    //KICK.scaleY = 0.5;
    KICK.tag = 6;
    [self addChild:KICK z:1];
    
    POWER = [CCSprite spriteWithFile:@"reverse.png"];
    POWER.position = ccp(380,35);
    POWER.opacity = 95;
    
    //POWER.scaleX = 0.5;
    //POWER.scaleY = 0.5;
    POWER.tag = 7;
    [self addChild:POWER z:1];
    
    TRANSFORM = [CCSprite spriteWithFile:@"special.png"];
    TRANSFORM.position = ccp(445,35);
    TRANSFORM.opacity = 95;
    //TRANSFORM.scaleX = 0.5;
    //TRANSFORM.scaleY = 0.5;
    TRANSFORM.tag = 8;
    [self addChild:TRANSFORM z:1];

}

-(void)Iniciar_Jugador
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    //CCSpriteBatchNode *DennisNode = [CCSpriteBatchNode batchNodeWithFile:@"DeadpoolAnimations.png"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"DeadpoolAnimations.plist"];
    
    Dennis  = [CCSprite spriteWithSpriteFrameName:@"DeadpoolNormal1.png"];
    Dennis.position   = ccp(55,70);
    
    
    NSMutableArray *DennisTransformIdleAnimFrames = [NSMutableArray array];
    
    for (int i=1; i<=6; i++)
    {
        [DennisTransformIdleAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"DeadpoolNormal%i.png", i]]];
    }
    
    CCAnimation *DennisIdleAnim = [CCAnimation
                                animationWithSpriteFrames:DennisTransformIdleAnimFrames delay:0.1f];
    DennisNormal = [[CCRepeatForever actionWithAction:
                        [CCAnimate actionWithAnimation:DennisIdleAnim]] retain];
    [Dennis runAction:[CCScaleTo actionWithDuration:0.0f scale:1.2f]];
    [Dennis runAction:DennisNormal];
    //[DennisNode addChild:Dennis z:10];
    
    //[self addChild:DennisNode z:5];
    [self addChild:Dennis z:0];
}

-(void)normal
{
 [Dennis stopAllActions];
  Dennis.position   = ccp(180,70);
 [Dennis runAction:DennisNormal];
}

-(void)peligro
{
    [Dennis stopAllActions];
    NSMutableArray *DennisDownAnimFrames = [NSMutableArray array];
    
        [DennisDownAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"DeadpoolDanger.png"]];
    
    Dennis.position   = ccp(Dennis.position.x,70);
    CCAnimation *punchAnim = [CCAnimation
                              animationWithSpriteFrames:DennisDownAnimFrames delay:0.1f];
    DennisDanger = [CCAnimate actionWithAnimation:punchAnim];
    [Dennis runAction:DennisDanger];
    //[Dennis runAction:DennisNormal];
    //[[SimpleAudioEngine sharedEngine] playEffect:@"punch.mp3"];
}

-(void)movimiento_arriba
{
    CCLOG(@"SALTA");
    [Dennis stopAllActions];
    Dennis.position = ccp(Dennis.position.x, 138);
    NSMutableArray *DennisJumpAnimFrames = [NSMutableArray array];
    for (int i=1; i<=10; i++)
    {
        [DennisJumpAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"DeadpoolJump%i.png", i]]];
    }
    
    CCAnimation *JumpAnimation = [CCAnimation animationWithSpriteFrames:DennisJumpAnimFrames delay:0.05f];
    CCAnimate *animateJump = [CCAnimate actionWithAnimation:JumpAnimation];
    CCMoveBy *moveUp = [CCMoveBy actionWithDuration:0.05f position:ccp(0, 60)];
    CCMoveBy *moveDown = [CCMoveBy actionWithDuration:0.05f position:ccp(0, -60)];
    CCSpawn *spawnJump = [CCSpawn actions:animateJump,moveUp,moveDown, nil];
    DennisArriba = [CCSequence actions:spawnJump ,nil];
    //DennisArriba = [CCAnimate actionWithAnimation:JumpAnimation];
    
    [Dennis runAction:DennisArriba];
    //[Dennis runAction:DennisNormal];
    //Dennis.position = ccp(Dennis.position.x, 70);
     [[SimpleAudioEngine sharedEngine] playEffect:@"jump.wav"];
    //[self enemigo_arriba];
}

-(void)movimiento_abajo
{
    CCLOG(@"AGACHARSE");
    [Dennis stopAllActions];
    NSMutableArray *DennisDownAnimFrames = [NSMutableArray array];
    for (int i=1; i<=3; i++)
    {
        [DennisDownAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"DeadpoolDown%i.png", i]]];
    }
     Dennis.position   = ccp(Dennis.position.x,70);
    CCAnimation *punchAnim = [CCAnimation
                              animationWithSpriteFrames:DennisDownAnimFrames delay:0.03f];
    DennisAbajo = [CCAnimate actionWithAnimation:punchAnim];
    [Dennis runAction:DennisAbajo];
    //[Dennis runAction:DennisNormal];
     [[SimpleAudioEngine sharedEngine] playEffect:@"down.wav"];

}

-(void)movimiento_izquierda
{
    CCLOG(@"posicion X Dennis:%f",Dennis.position.x);
    if (Dennis.position.x<=55)
    {
         [self movimiento_derecha];
    }
    else
    {
       
        [Dennis stopAllActions];
        CCLOG(@"ATRAS");
        NSMutableArray *DennisJumpAnimFrames = [NSMutableArray array];
        for (int i=1; i<=5; i++)
        {
            [DennisJumpAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"DeadpoolWalkLeft%i.png", i]]];
        }
        
        CCAnimation *JumpAnimation = [CCAnimation animationWithSpriteFrames:DennisJumpAnimFrames delay:0.05f];
        CCAnimate *animateJump = [CCAnimate actionWithAnimation:JumpAnimation];
        CCMoveBy *moveLeft = [CCMoveBy actionWithDuration:0.3f position:ccp(-40, 0)];
        CCSpawn *spawnJump = [CCSpawn actions:animateJump,moveLeft, nil];
        DennisAtras = [CCSequence actions:spawnJump ,nil];
        //DennisArriba = [CCAnimate actionWithAnimation:JumpAnimation];
        Dennis.position   = ccp(Dennis.position.x,70);
        [Dennis runAction:DennisAtras];
        [Dennis runAction:DennisNormal];
    }
}

-(void)movimiento_derecha
{
    CCLOG(@"posicion X Dennis:%f",Dennis.position.x);
    if (Dennis.position.x>=400)
    {
        [self movimiento_izquierda];
    }
    else
    {
        [Dennis stopAllActions];
        CCLOG(@"ADELANTE");
        NSMutableArray *DennisJumpAnimFrames = [NSMutableArray array];
        for (int i=1; i<=5; i++)
        {
            [DennisJumpAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"DeadpoolWalkRight%i.png", i]]];
        }
        
        CCAnimation *JumpAnimation = [CCAnimation animationWithSpriteFrames:DennisJumpAnimFrames delay:0.05f];
        CCAnimate *animateJump = [CCAnimate actionWithAnimation:JumpAnimation];
        CCMoveBy *moveLeft = [CCMoveBy actionWithDuration:0.3f position:ccp(+40, 0)];
        CCSpawn *spawnJump = [CCSpawn actions:animateJump,moveLeft, nil];
        DennisAdelante = [CCSequence actions:spawnJump ,nil];
        //DennisArriba = [CCAnimate actionWithAnimation:JumpAnimation];
        Dennis.position   = ccp(Dennis.position.x,70);
        [Dennis runAction:DennisAdelante];
        [Dennis runAction:DennisNormal];
    }
   

}

-(void)golpe
{
    CCLOG(@"PUÑETE");
    
    [Dennis stopAllActions];
    NSMutableArray *DennisDownAnimFrames = [NSMutableArray array];
    for (int i=1; i<=4; i++)
    {
        [DennisDownAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"DeadpoolPunch%i.png", i]]];
    }
    Dennis.position   = ccp(Dennis.position.x,70);
    CCAnimation *punchAnim = [CCAnimation
                              animationWithSpriteFrames:DennisDownAnimFrames delay:0.1f];
    DennisGolpe = [CCAnimate actionWithAnimation:punchAnim];
    [Dennis runAction:DennisGolpe];
    //[Dennis runAction:DennisNormal];
    [[SimpleAudioEngine sharedEngine] playEffect:@"punch.mp3"];
    //[self enemigo_golpe];
     [self scheduleOnce:@selector(checkForDennisHit) delay:0.2];
}

-(void)patada
{
    CCLOG(@"PATADA");
}

-(void)poder
{
    CCLOG(@"ESPADA");
    
    CCLOG(@"PODER FUERTE");
    
    CCLOG(@"PODER FUERTE");
    CCLOG(@"PODER FUERTE");
    CCLOG(@"PODER FUERTE");
    
    [Dennis stopAllActions];
    NSMutableArray *DennisDownAnimFrames = [NSMutableArray array];
    for (int i=1; i<=8; i++)
    {
        [DennisDownAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"DeadpoolSword%i.png", i]]];
    }
    Dennis.position   = ccp(Dennis.position.x+10,70);
    CCAnimation *punchAnim = [CCAnimation
                              animationWithSpriteFrames:DennisDownAnimFrames delay:0.1f];
    DennisPoder = [CCAnimate actionWithAnimation:punchAnim];
    [Dennis runAction:DennisPoder];
    //[Dennis runAction:DennisNormal];
     [[SimpleAudioEngine sharedEngine] playEffect:@"sword.mp3"];
     [self scheduleOnce:@selector(checkForDennisHit) delay:0.2];
}

-(void)transformacion
{
    CCLOG(@"TRANSFORMACION");
    [Dennis stopAllActions];
    NSMutableArray *DennisDownAnimFrames = [NSMutableArray array];
    for (int i=2; i<=10; i++)
    {
        [DennisDownAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"DeadpoolTransform%i.png", i]]];
    }
    Dennis.position   = ccp(Dennis.position.x,70);
    CCAnimation *punchAnim = [CCAnimation
                              animationWithSpriteFrames:DennisDownAnimFrames delay:0.1f];
    DennisTransformacion = [CCAnimate actionWithAnimation:punchAnim];
    [Dennis runAction:DennisTransformacion];
    //[Dennis runAction:DennisNormal];
     [[SimpleAudioEngine sharedEngine] playEffect:@"frostypower.wav"];
    
    [Smoke stopAllActions];
    NSMutableArray *SmokeTransformAnimFrames = [NSMutableArray array];
    for (int i=0; i<=13; i++)
    {
        [SmokeTransformAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"SmokeTransform%i.png", i]]];
    }
    Smoke.position   = ccp(Smoke.position.x,80);
    CCAnimation *transformAnim = [CCAnimation
                              animationWithSpriteFrames:SmokeTransformAnimFrames delay:0.1f];
    SmokeTransformacion = [CCAnimate actionWithAnimation:transformAnim];
    [Smoke runAction:SmokeTransformacion];
     [[SimpleAudioEngine sharedEngine] playEffect:@"enemytrans.wav"];
}

-(void)Iniciar_Enemigo
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    //CCSpriteBatchNode *DennisNode = [CCSpriteBatchNode batchNodeWithFile:@"DeadpoolAnimations.png"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"SmokeMoves.plist"];
    
    Smoke  = [CCSprite spriteWithSpriteFrameName:@"SmokeNormal0.png"];
    Smoke.position   = ccp(450,80);
    
    
    NSMutableArray *SmokeIdleAnimFrames = [NSMutableArray array];
    
    for (int i=0; i<=6; i++)
    {
        [SmokeIdleAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"SmokeNormal%i.png", i]]];
    }
    
    CCAnimation *SmokeIdleAnim = [CCAnimation
                                   animationWithSpriteFrames:SmokeIdleAnimFrames delay:0.1f];
    SmokeNormal = [[CCRepeatForever actionWithAction:
                     [CCAnimate actionWithAnimation:SmokeIdleAnim]] retain];
    [Smoke runAction:[CCScaleTo actionWithDuration:0.0f scale:1.4f]];
    [Smoke runAction:SmokeNormal];
    
    Smoke.flipX = YES;
    //[DennisNode addChild:Dennis z:10];
    
    //[self addChild:DennisNode z:5];
    [self addChild:Smoke z:0];
}

-(void)enemigo_arriba
{
    [Smoke stopAllActions];
     Smoke.position   = ccp(Smoke.position.x,80);
    NSMutableArray *SmokeJumpAnimFrames = [NSMutableArray array];
    for (int i=0; i<=4; i++)
    {
        [SmokeJumpAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"SmokeJump%i.png", i]]];
    }
    
    CCAnimation *JumpAnimation = [CCAnimation animationWithSpriteFrames:SmokeJumpAnimFrames delay:0.1f];
    CCAnimate *animateJump = [CCAnimate actionWithAnimation:JumpAnimation];
    CCMoveBy *moveUp = [CCMoveBy actionWithDuration:0.05f position:ccp(0, 30)];
    CCMoveBy *moveDown = [CCMoveBy actionWithDuration:0.01f position:ccp(0, -30)];
    SmokeArriba = [CCSequence actions:moveUp,animateJump,moveDown, nil];
   // SmokeArriba = [CCSequence actions:spawnJump ,nil];
    //DennisArriba = [CCAnimate actionWithAnimation:JumpAnimation];
    
    [Smoke runAction:SmokeArriba];
    //[Dennis runAction:DennisNormal];
    //Dennis.position = ccp(Dennis.position.x, 70);
    //[[SimpleAudioEngine sharedEngine] playEffect:@"jump.wav"];
}

-(void)enemigo_golpe
{
    [Smoke stopAllActions];
    NSMutableArray *DennisDownAnimFrames = [NSMutableArray array];
    for (int i=0; i<=5; i++)
    {
        [DennisDownAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"SmokePunch%i.png", i]]];
    }
    Smoke.position   = ccp(Smoke.position.x,70);
    CCAnimation *punchAnim = [CCAnimation
                              animationWithSpriteFrames:DennisDownAnimFrames delay:0.1f];
    SmokeGolpe = [CCAnimate actionWithAnimation:punchAnim];
    [Smoke runAction:SmokeGolpe];
  [[SimpleAudioEngine sharedEngine] playEffect:@"enemypunch.wav"];
     [self scheduleOnce:@selector(checkForSmokeHit) delay:0.2];
}

-(void)enemigo_adelante
{
      CCLOG(@"posicion X Smoke:%f",Smoke.position.x);
    if (Smoke.position.x<=50)
    {
         [self enemigo_atras];
    }
    else
    {
        [Smoke stopAllActions];
        CCLOG(@"ADELANTE");
        NSMutableArray *DennisJumpAnimFrames = [NSMutableArray array];
        for (int i=0; i<=8; i++)
        {
            [DennisJumpAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"SmokeWalkRight%i.png", i]]];
        }
        
        CCAnimation *JumpAnimation = [CCAnimation animationWithSpriteFrames:DennisJumpAnimFrames delay:0.05f];
        CCAnimate *animateJump = [CCAnimate actionWithAnimation:JumpAnimation];
        CCMoveBy *moveLeft = [CCMoveBy actionWithDuration:0.3f position:ccp(-40, 0)];
        CCSpawn *spawnJump = [CCSpawn actions:animateJump,moveLeft, nil];
        SmokeAdelante = [CCSequence actions:spawnJump ,nil];
        //DennisArriba = [CCAnimate actionWithAnimation:JumpAnimation];
        Smoke.position   = ccp(Smoke.position.x,80);
        [Smoke runAction:SmokeAdelante];
        [Smoke runAction:SmokeNormal];
    }
}

-(void)enemigo_atras
{
    CCLOG(@"posicion X Smoke:%f",Smoke.position.x);
    if (Smoke.position.x>=450)
    {
         [self enemigo_adelante];
    }
    else
    {
        [Smoke stopAllActions];
        CCLOG(@"ATRAS");
        NSMutableArray *DennisJumpAnimFrames = [NSMutableArray array];
        for (int i=0; i<=8; i++)
        {
            [DennisJumpAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"SmokeWalkLeft%i.png", i]]];
        }
        CCAnimation *JumpAnimation = [CCAnimation animationWithSpriteFrames:DennisJumpAnimFrames delay:0.05f];
        CCAnimate *animateJump = [CCAnimate actionWithAnimation:JumpAnimation];
        CCMoveBy *moveLeft = [CCMoveBy actionWithDuration:0.3f position:ccp(+40, 0)];
        CCSpawn *spawnJump = [CCSpawn actions:animateJump,moveLeft, nil];
        SmokeAtras = [CCSequence actions:spawnJump ,nil];
        //DennisArriba = [CCAnimate actionWithAnimation:JumpAnimation];
        Smoke.position   = ccp(Smoke.position.x,80);
        [Smoke runAction:SmokeAtras];
        [Smoke runAction:SmokeNormal];
    }
}

-(void)enemigo_AI
{
    CCLOG(@"inteligencia Artificial");
    int Desicion = 5;
    
    float intervalo = 4 - (Desicion * 0.4);
    
    [self schedule:@selector(enemigo_acciones_reaccion) interval:intervalo repeat:-1 delay:2];
}

-(void)enemigo_acciones_reaccion
{
    int lowerBound = 1;
    int upperBound = 6;
    int rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
    
    switch (rndValue) {
        case 1:
            [self enemigo_adelante];
            break;
        case 2:
            [self enemigo_atras];
            break;
        case 3:
            [self enemigo_arriba];
            break;
        case 4:
            [self enemigo_golpe];
            break;
        case 5:
            [self enemigo_golpe];
            break;
        case 6:
            [self enemigo_golpe];
            break;
            
        default:
            break;
    }
    [self enemigo_AI];
}

-(void)Iniciar_HUD
{
    CGSize winSize = [CCDirector sharedDirector].winSize;
    float healthBarHeight = winSize.height/1.2;
    DennisHealthBar = [CCProgressTimer progressWithSprite:[CCSprite spriteWithFile:@"barravida.png"]];
    DennisHealthBar.type = kCCProgressTimerTypeBar;
    [DennisHealthBar setScaleX:0.9];
    [DennisHealthBar setScaleY:0.8];
    DennisHealth = 100;
    DennisHealthBar.percentage = DennisHealth;
    DennisHealthBar.position = ccp(winSize.width/5, healthBarHeight);
    DennisHealthBar.midpoint = ccp(0, 0);
    DennisHealthBar.barChangeRate = ccp(1, 0);
    [self addChild:DennisHealthBar z:10];
    
    SmokeHealthBar = [CCProgressTimer progressWithSprite:[CCSprite spriteWithFile:@"barravida.png"]];
    SmokeHealthBar.type = kCCProgressTimerTypeBar;
    [SmokeHealthBar setScaleX:0.9];
    [SmokeHealthBar setScaleY:0.8];
    SmokeHealth = 100;
    SmokeHealthBar.percentage = SmokeHealth;
    SmokeHealthBar.position = ccp(winSize.width/1.25,healthBarHeight);
    SmokeHealthBar.midpoint = ccp(1, 0);
    SmokeHealthBar.barChangeRate = ccp(1, 0);
    [self addChild:SmokeHealthBar z:10];
    
    int labelOffset = 30;
    CCLabelTTF *ryuLabel = [CCLabelTTF labelWithString:@"Dennis Mostajo" fontName:@"8BITWONDERNominal" fontSize:10];
    ryuLabel.position = ccp(winSize.width/5,healthBarHeight + labelOffset);
    ryuLabel.color = ccGREEN;
    [self addChild:ryuLabel z:10];
    
    CCLabelTTF *enemyLabel = [CCLabelTTF labelWithString:@"Smoke Cocos 2D" fontName:@"8BITWONDERNominal" fontSize:10];
    enemyLabel.position = ccp(winSize.width/1.25,healthBarHeight + labelOffset);
    enemyLabel.color = ccGREEN;
    [self addChild:enemyLabel z:10];

}

- (void)checkForDennisHit {
    CGRect extendedReach = CGRectMake(Dennis.boundingBox.origin.x - 10, Dennis.boundingBox.origin.y - 10, Dennis.boundingBox.size.width + 10, Dennis.boundingBox.size.height + 10);
    if (CGRectIntersectsRect(extendedReach, Smoke.boundingBox)) {
        SmokeHealth -= 7;
        [SmokeHealthBar setPercentage:SmokeHealth];
        if (SmokeHealth <= 0) {
            // Display something then start the next level
            [self DennisWin];
        }
        [[SimpleAudioEngine sharedEngine] playEffect:@"Strong_Punch.mp3"];
    }
}

- (void)checkForSmokeHit {
    CGRect extendedReach = CGRectMake(Smoke.boundingBox.origin.x - 10, Smoke.boundingBox.origin.y - 10, Smoke.boundingBox.size.width + 10, Smoke.boundingBox.size.height + 10);
    if (CGRectIntersectsRect(extendedReach, Dennis.boundingBox)) {
        DennisHealth -= 7;
        [DennisHealthBar setPercentage:DennisHealth];
        if (DennisHealth <= 0) {
            // Display something then put player on the twitter screen.
            [self SmokeWin];
        }
        [[SimpleAudioEngine sharedEngine] playEffect:@"Strong_Punch.mp3" pitch:1.4 pan:1 gain:1];
    }
}


-(void)DennisWin
{
    [ModalAlert Tell:@"GANASTE!!\n\nEs divertido empezar otra pelea!!" onLayer:self option1:@"Fight!" okBlock:^{
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"Jugador3.wav"];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5 scene:[FightScene node]]];
    }];
}

-(void)SmokeWin
{
    [ModalAlert Tell:@"PERDISTE!!\n\nLo siento empezaras de nuevo!!" onLayer:self option1:@"Game Over!" okBlock:^{
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"enemytrans.wav"];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionCrossFade transitionWithDuration:0.5 scene:[Intro node]]];
    }];
}

-(void)Iniciar_Intro
{
    [ModalAlert Tell:[NSString stringWithFormat:@"%@\n\n%@", @"Dennis Mostajo", @"Muestra Cocos 2D"] onLayer:self option1:@"Fight!" okBlock:^{
        
       [self enemigo_AI];
    }];

  
}

@end
