//
//  Car.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-05-09.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//
#include <Box2D/Box2D.h>

#import <Foundation/Foundation.h>

#import "Artist.h"
#import "ResourceManager.h"
#import "PhysicsBodyCache.h"

#import "Tire.h"

typedef enum {
    LEFT,
    RIGHT,
    STRAIGHT
    
} Direction;

@interface Car : NSObject

@property (assign) ResourceManager* resourceManager;

@property (assign) b2RevoluteJoint* frJoint;
@property (assign) b2RevoluteJoint* flJoint;

@property (assign) TireProperties tireProperties;

@property (strong, nonatomic) NSMutableArray* tires;

@property (assign) Direction direction;
@property (assign) bool braking;

-(id) initWithWorld: (b2World*) world withBody: (b2Body*) aBody;

-(void) update;
-(void) draw: (Artist*) artist;

-(b2Body*) getBody;

@end
