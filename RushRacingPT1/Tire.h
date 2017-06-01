//
//  Tire.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-05-07.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//
#include <Box2D/Box2D.h>

#import <Foundation/Foundation.h>

typedef struct{
    float maxForwardSpeed;
    float maxBackwardSpeed;
    float maxDriveForce;
    float maxLateralImpulse;
} tireProperties;

@interface Tire : NSObject

@property (assign) float maxForwardSpeed;
@property (assign) float maxBackwardSpeed;
@property (assign) float maxDriveForce;
@property (assign) float maxLateralImpulse;

-(id) initWithWorld: (b2World*) world;
-(id) initWithWorld: (b2World*) world
         properties: (tireProperties) props;

-(void) setCharacteristics: (tireProperties) props;

-(void) update;

-(b2Body*) getBody;

@end
