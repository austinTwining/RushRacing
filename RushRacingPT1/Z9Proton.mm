//
//  Z9Proton.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-07-08.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "Z9Proton.h"

//  (-28.0000, -44.0000)  ,  (27.0000, -44.0000)  ,  (27.0000, 41.0000)  ,  (-28.0000, 41.0000)

@implementation Z9Proton

-(id) initWithWorld: (b2World*) world{
    self = [super initWithWorld:world withBody: [[ViewController getPhysicsBodyCache] createBody:@"Z9-Proton-Orange-small" withWorld:world]];
    if(self){
        //set up tires
        b2RevoluteJointDef jointDef;
        jointDef.bodyA = [super getBody];
        jointDef.enableLimit = true;
        jointDef.lowerAngle = 0;//with both these at zero...
        jointDef.upperAngle = 0;//...the joint will not move
        jointDef.localAnchorB.SetZero();//joint anchor in tire is always center
        
        TireProperties tirePropertiesFront;
        tirePropertiesFront.maxForwardSpeed   = 23;
        tirePropertiesFront.maxBackwardSpeed  = 10;
        tirePropertiesFront.maxDriveForce     = 15;
        tirePropertiesFront.maxLateralImpulse = 1.8;
        
        TireProperties tirePropertiesBack;
        tirePropertiesBack.maxForwardSpeed   = 23;
        tirePropertiesBack.maxBackwardSpeed  = 10;
        tirePropertiesBack.maxDriveForce     = 20;
        tirePropertiesBack.maxLateralImpulse = 1.5;
        
        //back left tire
        Tire* tire = [[Tire alloc] initWithWorld:world properties:tirePropertiesBack withBody: [[ViewController getPhysicsBodyCache] createBody:@"Z9-Proton-Tire-small" withWorld:world]];
        jointDef.bodyB = [tire getBody];
        jointDef.localAnchorA.Set(-0.875, 1.28);
        world->CreateJoint( &jointDef );
        [super.tires addObject:tire];
        
        //back right tire
        tire = [[Tire alloc] initWithWorld:world properties:tirePropertiesBack withBody: [[ViewController getPhysicsBodyCache] createBody:@"Z9-Proton-Tire-small" withWorld:world]];
        jointDef.bodyB = [tire getBody];
        jointDef.localAnchorA.Set(0.844, 1.28);
        world->CreateJoint( &jointDef );
        [super.tires addObject:tire];
        
        //front left tire
        tire = [[Tire alloc] initWithWorld:world properties:tirePropertiesFront withBody: [[ViewController getPhysicsBodyCache] createBody:@"Z9-Proton-Tire-small" withWorld:world]];
        jointDef.bodyB = [tire getBody];
        jointDef.localAnchorA.Set(0.844, -1.375);
        super.flJoint = (b2RevoluteJoint*)world->CreateJoint(&jointDef);
        [super.tires addObject:tire];
        
        //front right tire
        tire = [[Tire alloc] initWithWorld:world properties:tirePropertiesFront withBody: [[ViewController getPhysicsBodyCache] createBody:@"Z9-Proton-Tire-small" withWorld:world]];
        jointDef.bodyB = [tire getBody];
        jointDef.localAnchorA.Set(-0.875, -1.375);
        super.frJoint = (b2RevoluteJoint*)world->CreateJoint(&jointDef);
        [super.tires addObject:tire];
    }
    return self;
}

-(id) initWithWorld: (b2World*) world
       withPosition: (b2Vec2) position{
    self = [super initWithWorld:world withBody: [[ViewController getPhysicsBodyCache] createBody:@"Z9-Proton-Orange-small" withWorld:world withPosition:position]];
    if(self){
        //set up tires
        b2RevoluteJointDef jointDef;
        jointDef.bodyA = [super getBody];
        jointDef.enableLimit = true;
        jointDef.lowerAngle = 0;//with both these at zero...
        jointDef.upperAngle = 0;//...the joint will not move
        jointDef.localAnchorB.SetZero();//joint anchor in tire is always center
        
        TireProperties tirePropertiesFront;
        tirePropertiesFront.maxForwardSpeed   = 23;
        tirePropertiesFront.maxBackwardSpeed  = 10;
        tirePropertiesFront.maxDriveForce     = 15;
        tirePropertiesFront.maxLateralImpulse = 1.8;
        
        TireProperties tirePropertiesBack;
        tirePropertiesBack.maxForwardSpeed   = 23;
        tirePropertiesBack.maxBackwardSpeed  = 10;
        tirePropertiesBack.maxDriveForce     = 20;
        tirePropertiesBack.maxLateralImpulse = 1.5;
        
        //back left tire
        Tire* tire = [[Tire alloc] initWithWorld:world properties:tirePropertiesBack withBody: [[ViewController getPhysicsBodyCache] createBody:@"Z9-Proton-Tire-small" withWorld:world withPosition:position]];
        jointDef.bodyB = [tire getBody];
        jointDef.localAnchorA.Set(-0.875, 1.28);
        world->CreateJoint( &jointDef );
        [super.tires addObject:tire];
        
        //back right tire
        tire = [[Tire alloc] initWithWorld:world properties:tirePropertiesBack withBody: [[ViewController getPhysicsBodyCache] createBody:@"Z9-Proton-Tire-small" withWorld:world withPosition:position]];
        jointDef.bodyB = [tire getBody];
        jointDef.localAnchorA.Set(0.844, 1.28);
        world->CreateJoint( &jointDef );
        [super.tires addObject:tire];
        
        //front left tire
        tire = [[Tire alloc] initWithWorld:world properties:tirePropertiesFront withBody: [[ViewController getPhysicsBodyCache] createBody:@"Z9-Proton-Tire-small" withWorld:world withPosition:position]];
        jointDef.bodyB = [tire getBody];
        jointDef.localAnchorA.Set(0.844, -1.375);
        super.flJoint = (b2RevoluteJoint*)world->CreateJoint(&jointDef);
        [super.tires addObject:tire];
        
        //front right tire
        tire = [[Tire alloc] initWithWorld:world properties:tirePropertiesFront withBody: [[ViewController getPhysicsBodyCache] createBody:@"Z9-Proton-Tire-small" withWorld:world withPosition:position]];
        jointDef.bodyB = [tire getBody];
        jointDef.localAnchorA.Set(-0.875, -1.375);
        super.frJoint = (b2RevoluteJoint*)world->CreateJoint(&jointDef);
        [super.tires addObject:tire];
    }
    return self;
}

-(id) initWithWorld: (b2World*) world
       withPosition: (b2Vec2) position
       withRotation: (float) rotation{
    self = [super initWithWorld:world withBody: [[ViewController getPhysicsBodyCache] createBody:@"Z9-Proton-Orange-small" withWorld:world withPosition:position withRotation:rotation]];
    if(self){
        //set up tires
        b2RevoluteJointDef jointDef;
        jointDef.bodyA = [super getBody];
        jointDef.enableLimit = true;
        jointDef.lowerAngle = 0;//with both these at zero...
        jointDef.upperAngle = 0;//...the joint will not move
        jointDef.localAnchorB.SetZero();//joint anchor in tire is always center
        
        TireProperties tirePropertiesFront;
        tirePropertiesFront.maxForwardSpeed   = 23;
        tirePropertiesFront.maxBackwardSpeed  = 10;
        tirePropertiesFront.maxDriveForce     = 15;
        tirePropertiesFront.maxLateralImpulse = 1.8;
        
        TireProperties tirePropertiesBack;
        tirePropertiesBack.maxForwardSpeed   = 23;
        tirePropertiesBack.maxBackwardSpeed  = 10;
        tirePropertiesBack.maxDriveForce     = 20;
        tirePropertiesBack.maxLateralImpulse = 1.5;
        
        //back left tire
        Tire* tire = [[Tire alloc] initWithWorld:world properties:tirePropertiesBack withBody: [[ViewController getPhysicsBodyCache] createBody:@"Z9-Proton-Tire-small" withWorld:world withPosition:position]];
        jointDef.bodyB = [tire getBody];
        jointDef.localAnchorA.Set(-0.875, 1.28);
        world->CreateJoint( &jointDef );
        [super.tires addObject:tire];
        
        //back right tire
        tire = [[Tire alloc] initWithWorld:world properties:tirePropertiesBack withBody: [[ViewController getPhysicsBodyCache] createBody:@"Z9-Proton-Tire-small" withWorld:world withPosition:position]];
        jointDef.bodyB = [tire getBody];
        jointDef.localAnchorA.Set(0.844, 1.28);
        world->CreateJoint( &jointDef );
        [super.tires addObject:tire];
        
        //front left tire
        tire = [[Tire alloc] initWithWorld:world properties:tirePropertiesFront withBody: [[ViewController getPhysicsBodyCache] createBody:@"Z9-Proton-Tire-small" withWorld:world withPosition:position]];
        jointDef.bodyB = [tire getBody];
        jointDef.localAnchorA.Set(0.844, -1.375);
        super.flJoint = (b2RevoluteJoint*)world->CreateJoint(&jointDef);
        [super.tires addObject:tire];
        
        //front right tire
        tire = [[Tire alloc] initWithWorld:world properties:tirePropertiesFront withBody: [[ViewController getPhysicsBodyCache] createBody:@"Z9-Proton-Tire-small" withWorld:world withPosition:position]];
        jointDef.bodyB = [tire getBody];
        jointDef.localAnchorA.Set(-0.875, -1.375);
        super.frJoint = (b2RevoluteJoint*)world->CreateJoint(&jointDef);
        [super.tires addObject:tire];
    }
    return self;
}

-(void) update{
    [super update];
}
-(void) draw: (Artist*) artist{
    Texture* tt = [super.resourceManager getTexture:@"Z9-Proton-Tire"];
    for(Tire* t in super.tires){
        float32 tx = [t getBody]->GetPosition().x * PTM;
        float32 ty = [t getBody]->GetPosition().y * PTM;
        float32 tr = [t getBody]->GetAngle();
        
        [artist drawTexture:tt position:GLKVector2Make(tx, ty) size:GLKVector2Make(tt.Width, tt.Height) rotation:tr];
    }

    float32 x = [super getBody]->GetPosition().x * PTM;
    float32 y = [super getBody]->GetPosition().y * PTM;
    float32 r = [super getBody]->GetAngle();
    Texture* t = [super.resourceManager getTexture:@"Z9-Proton"];
    [artist drawTexture:t position:GLKVector2Make(x, y) size:GLKVector2Make(t.Width, t.Height) rotation:r];
}

@end
