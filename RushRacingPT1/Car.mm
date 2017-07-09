//
//  Car.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-05-09.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "Car.h"

#import "ViewController.h"

#define DEGTORAD 0.0174532925199432957f
#define RADTODEG 57.295779513082320876f

@interface Car(){
    b2Body* m_body;
    
    b2World* m_world;
}

@end

@implementation Car

-(id) initWithWorld:(b2World *)world withBody:(b2Body *)aBody{
    self = [super init];
    if(self){
        _resourceManager = [ViewController getResourceManager];
        _tires = [NSMutableArray arrayWithCapacity:4];
        m_world = world;
        
        _direction = STRAIGHT;
        
        // body
        m_body = aBody;
        
        m_body->SetUserData((__bridge void*)self);
    }
    return self;
}

-(void) update{
    for(int i = 0; i < [_tires count]; i++){
        [_tires[i] update];
    }
    
    //control steering
    float lockAngle = 35 * DEGTORAD;
    float turnSpeedPerSec = 480 * DEGTORAD;//from lock to lock in 0.5 sec
    float turnPerTimeStep = turnSpeedPerSec / 60.0f;
    
    //set desired anle
    float desiredAngle = 0;
    switch (_direction) {
        case RIGHT:
            desiredAngle = lockAngle;
            break;
        case LEFT:
            desiredAngle = -lockAngle;
            break;
        case STRAIGHT:
            desiredAngle = 0;
            break;
            
        default:
            desiredAngle = 0;
            break;
    }
    
    //steering input
    float angleNow = _flJoint->GetJointAngle();
    float angleToTurn = desiredAngle - angleNow;
    angleToTurn = b2Clamp(angleToTurn, -turnPerTimeStep, turnPerTimeStep);
    float newAngle = angleNow + angleToTurn;
    _flJoint->SetLimits(newAngle, newAngle);
    _frJoint->SetLimits(newAngle, newAngle);
    
    float currentSpeed = b2Dot([self getForwardVelocity], m_body->GetWorldVector(b2Vec2(0,-1)));
    NSLog(@"V: %f", [self mPerSecToKMPerHr:currentSpeed]); // print out speed in km/h
}

-(void) draw: (Artist*) artist{}

//method to convert m/s to km/h
-(float) mPerSecToKMPerHr : (float) mPerSec{
    return (mPerSec * 18) / 5;
}

-(b2Vec2) getForwardVelocity{
    b2Vec2 currentForwardNormal = m_body->GetWorldVector(b2Vec2(0,-1));
    return b2Dot(currentForwardNormal, m_body->GetLinearVelocity()) * currentForwardNormal;
}

-(b2Body*) getBody{
    return m_body;
}

@end
