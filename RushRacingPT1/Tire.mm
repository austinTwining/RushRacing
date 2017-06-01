//
//  Tire.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-05-07.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "Tire.h"

@interface Tire(){
    b2Body* m_body;
}

@end

@implementation Tire

-(id) initWithWorld: (b2World*) world{
    self = [super init];
    if(self){
        //body definition
        b2BodyDef myBodyDef;
        myBodyDef.type = b2_dynamicBody;
        myBodyDef.position.Set(0, 0);
        
        //shape definition
        b2PolygonShape polygonShape;
        polygonShape.SetAsBox(0.5, 1); //a 0.5x1 rectangle
        
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
    }
    
    return self;
}

-(id) initWithWorld: (b2World*) world
         properties: (tireProperties) props{
    self = [super init];
    if(self){
        //set properties
        _maxForwardSpeed = props.maxForwardSpeed;
        _maxBackwardSpeed = props.maxBackwardSpeed;
        _maxDriveForce = props.maxDriveForce;
        _maxLateralImpulse = props.maxLateralImpulse;
        
        //body definition
        b2BodyDef myBodyDef;
        myBodyDef.type = b2_dynamicBody;
        myBodyDef.position.Set(0, 0);
        
        //shape definition
        b2PolygonShape polygonShape;
        polygonShape.SetAsBox(0.5, 1); //a 0.5x1 rectangle
        
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
    }
    
    return self;
}

-(void) setCharacteristics: (tireProperties) props{
    //set properties
    _maxForwardSpeed = props.maxForwardSpeed;
    _maxBackwardSpeed = props.maxBackwardSpeed;
    _maxDriveForce = props.maxDriveForce;
    _maxLateralImpulse = props.maxLateralImpulse;
}

-(void) update{
    //update friction
    b2Vec2 impulse = m_body->GetMass() * -[self getLateralVelocity];
    if (impulse.Length() > _maxLateralImpulse) impulse *= _maxLateralImpulse / impulse.Length();
    m_body->ApplyLinearImpulse(impulse, m_body->GetWorldCenter(), true);
    
    m_body->ApplyAngularImpulse(0.1f * m_body->GetInertia() * -m_body->GetAngularVelocity(), true);
    
    //add drag
    b2Vec2 currentForwardNormal = m_body->GetWorldVector(b2Vec2(0,-1));
    float currentForwardSpeed = currentForwardNormal.Normalize();
    float dragForceMagnitude = -2 * currentForwardSpeed;
    m_body->ApplyForce(dragForceMagnitude * currentForwardNormal, m_body->GetWorldCenter(), true);
    
    //update drive force
    float currentSpeed = b2Dot([self getForwardVelocity], currentForwardNormal);
    
    float force = 0;
    if(_maxForwardSpeed > currentSpeed) force = _maxDriveForce;
    else return;
    
    m_body->ApplyForce(force * currentForwardNormal, m_body->GetWorldCenter(), true);
}

-(b2Vec2) getLateralVelocity{
    b2Vec2 currentRightNormal = m_body->GetWorldVector(b2Vec2(1,0));
    return b2Dot(currentRightNormal, m_body->GetLinearVelocity()) * currentRightNormal;
}

-(b2Vec2) getForwardVelocity{
    b2Vec2 currentForwardNormal = m_body->GetWorldVector(b2Vec2(0,-1));
    return b2Dot(currentForwardNormal, m_body->GetLinearVelocity()) * currentForwardNormal;
}

-(b2Body*) getBody{
    return m_body;
}

@end
