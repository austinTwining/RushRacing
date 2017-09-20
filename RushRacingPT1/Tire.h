//
//  Tire.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-05-07.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//
#include <Box2D/Box2D.h>

#import "ViewController.h"

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

typedef struct{
    float maxForwardSpeed;
    float maxBackwardSpeed;
    float maxDriveForce;
    float maxLateralImpulse;
} TireProperties;

@interface Tire : NSObject

@property (assign) float maxForwardSpeed;
@property (assign) float maxBackwardSpeed;
@property (assign) float maxDriveForce;
@property (assign) float maxLateralImpulse;

@property (assign) bool driving;
@property (assign) bool drifting;
@property (assign) bool braking;

-(id) initWithWorld: (b2World*) world;
-(id) initWithWorld: (b2World*) world
         properties: (TireProperties) props
           withBody: (b2Body*) aBody;

-(void) setCharacteristics: (TireProperties) props;

-(void) update;

-(b2Body*) getBody;

@end
