//
//  Z9Proton.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-07-08.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//
#import "PhysicsBodyCache.h"
#import "Car.h"

@interface Z9Proton : Car

-(id) initWithWorld: (b2World*) world;
-(id) initWithWorld: (b2World*) world
       withPosition: (b2Vec2) position;
-(id) initWithWorld: (b2World*) world
       withPosition: (b2Vec2) position
       withRotation: (float) rotation;

-(void) update;
-(void) draw: (Artist*) artist;

@end
