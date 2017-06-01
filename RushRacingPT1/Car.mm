//
//  Car.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-05-09.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "Car.h"

#define DEGTORAD 0.0174532925199432957f
#define RADTODEG 57.295779513082320876f

// maxPower, maxForwardSpeed, maxBackwardSpeed, maxLateralImpulse
CarProperties cProps[] = {
    {300.0f, 97.0f, 20.0f, 3.0f} //Z9-Proton
};

@interface Car(){
    b2Body* m_body;
    
    b2RevoluteJoint* frJoint;
    b2RevoluteJoint* flJoint;
    
    b2World* m_world;
}

@end

@implementation Car

-(id) initWithWorld:(b2World *)world type:(CarType)type{
    self = [super init];
    if(self){
        _tires = [NSMutableArray arrayWithCapacity:4];
        m_world = world;
        
        _direction = STRAIGHT;
        
        //body definition
        b2BodyDef myBodyDef;
        myBodyDef.type = b2_dynamicBody;
        myBodyDef.position.Set(0, 0);
        
        //shape definition
        b2PolygonShape polygonShape;
        polygonShape.SetAsBox(2.25, 4.5); //a 2.25x4.5 rectangle
        
        //fixture definition
        b2FixtureDef myFixtureDef;
        myFixtureDef.shape = &polygonShape;
        myFixtureDef.density = 1;
        myFixtureDef.friction = 0;
        
        // body
        m_body = world->CreateBody(&myBodyDef);
        
        //add a fixture to the static body
        m_body->CreateFixture(&myFixtureDef);
        
        m_body->SetUserData((__bridge void*)self);
        
        //set up tires
        b2RevoluteJointDef jointDef;
        jointDef.bodyA = m_body;
        jointDef.enableLimit = true;
        jointDef.lowerAngle = 0;//with both these at zero...
        jointDef.upperAngle = 0;//...the joint will not move
        jointDef.localAnchorB.SetZero();//joint anchor in tire is always center
        
        tireProperties tProps;
        tProps.maxForwardSpeed = cProps[type].maxForwardSpeed;
        tProps.maxBackwardSpeed = cProps[type].maxBackwardSpeed;
        tProps.maxDriveForce = cProps[type].maxPower;
        tProps.maxLateralImpulse = cProps[type].maxLateralImpulse;
        
        //back left tire
        Tire* tire = [[Tire alloc] initWithWorld:world properties:tProps];
        jointDef.bodyB = [tire getBody];
        jointDef.localAnchorA.Set(-1.2, 2.25);
        world->CreateJoint( &jointDef );
        [_tires addObject:tire];
        
        //back right tire
        tire = [[Tire alloc] initWithWorld:world properties:tProps];
        jointDef.bodyB = [tire getBody];
        jointDef.localAnchorA.Set(1.2, 2.25);
        world->CreateJoint( &jointDef );
        [_tires addObject:tire];
        
        //front left tire
        tire = [[Tire alloc] initWithWorld:world properties:tProps];
        jointDef.bodyB = [tire getBody];
        jointDef.localAnchorA.Set(-1.2, -2.25);
        flJoint = (b2RevoluteJoint*)world->CreateJoint(&jointDef);
        [_tires addObject:tire];
        
        //front right tire
        tire = [[Tire alloc] initWithWorld:world properties:tProps];
        jointDef.bodyB = [tire getBody];
        jointDef.localAnchorA.Set(1.3, -2.25);
        frJoint = (b2RevoluteJoint*)world->CreateJoint(&jointDef);
        [_tires addObject:tire];
    }
    return self;
}

-(void) update{
    for(int i = 0; i < [_tires count]; i++){
        [_tires[i] update];
    }
    
    //control steering
    float lockAngle = 35 * DEGTORAD;
    float turnSpeedPerSec = 320 * DEGTORAD;//from lock to lock in 0.5 sec
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
    float angleNow = flJoint->GetJointAngle();
    float angleToTurn = desiredAngle - angleNow;
    angleToTurn = b2Clamp(angleToTurn, -turnPerTimeStep, turnPerTimeStep);
    float newAngle = angleNow + angleToTurn;
    flJoint->SetLimits(newAngle, newAngle);
    frJoint->SetLimits(newAngle, newAngle);
    
    //float currentSpeed = b2Dot([self getForwardVelocity], m_body->GetWorldVector(b2Vec2(0,-1)));
    //NSLog(@"V: %f", [self mPerSecToKMPerHr:currentSpeed]); // print out speed in km/h
}

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
