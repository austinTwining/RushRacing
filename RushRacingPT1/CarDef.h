//
//  CarDef.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-07-04.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#include <Box2D/Box2D.h>
#include <vector>

#import <Foundation/Foundation.h>

@interface CarDef : NSObject

@property (assign) float maxPower;
@property (assign) float maxForwardSpeed;
@property (assign) float maxBackwardSpeed;
@property (assign) float maxLateralImpulse;

@property (assign) b2BodyDef bodyDef;
@property std::vector<b2FixtureDef> fixDefs;

-(id) init;

@end
