//
//  Car.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-05-09.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//
#include <Box2D/Box2D.h>

#import <Foundation/Foundation.h>

#import "Tire.h"

typedef enum {
    LEFT,
    RIGHT,
    STRAIGHT
    
} Direction;

@interface Car : NSObject

@property (strong, nonatomic) NSMutableArray* tires;

@property (assign) tireProperties frontTireProps;
@property (assign) tireProperties backTireProps;

@property (assign) Direction direction;

-(id) initWithWorld: (b2World*) world;

-(void) update;

-(b2Body*) getBody;

@end
