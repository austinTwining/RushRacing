//
//  TestScene.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-05-31.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "TestScene.h"

@interface TestScene(){
    Car* car;
    
    b2World* m_world;
}

@end

@implementation TestScene

//load
-(void) initialize{
    m_world = new b2World(b2Vec2(0,0));// init physics world
    
    //load needed textures
    [ResourceManager loadTexture:@"Z9-Proton" path:@"Z9-Proton-Orange.png"];
    
    
    car = [[Car alloc] initWithWorld:m_world type:Z9_PROTON];
}

//update
-(void) update{
    float32 timeStep = 1.0 / (float) 60;      //the length of time passed to simulate (seconds)
    int32 velocityIterations = 8;   //how strongly to correct velocity
    int32 positionIterations = 3;   //how strongly to correct position
    
    m_world->Step( timeStep, velocityIterations, positionIterations);
    //NSLog(@"FPS: %ld", (long)self.framesPerSecond);
}
//draw
-(void) draw : (Artist*) artist{
    [artist updateCameraPosition:[car getBody]->GetPosition().x * PTM :[car getBody]->GetPosition().y * PTM];
    
    [artist drawTexture:[ResourceManager getTexture:@"Z9-Proton"]
               position:GLKVector2Make([car getBody]->GetPosition().x * PTM, [car getBody]->GetPosition().y * PTM)
                   size:GLKVector2Make([[ResourceManager getTexture:@"Z9-Proton"] Width], [[ResourceManager getTexture:@"Z9-Proton"] Height])
               rotation:[car getBody]->GetAngle()];
}

//unload
-(void) cleanup{
    
}

@end
