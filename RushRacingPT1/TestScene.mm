//
//  TestScene.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-05-31.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "TestScene.h"
#include "DebugDraw.h"
#import "PhysicsBodyCache.h"

#import "Z9Proton.h"

@interface TestScene(){
    b2World* m_world;
    DebugDraw* m_debugDraw;
    
    PhysicsBodyCache* pbCache;
    
    Car* car;
}

@end

@implementation TestScene

//load
-(void) initialize{
    m_world = new b2World(b2Vec2(0,0));// init physics world
    m_debugDraw = new DebugDraw(PTM, super.resourceManager);
    m_debugDraw->SetFlags(b2Draw::e_shapeBit + b2Draw::e_jointBit);
    m_world->SetDebugDraw(m_debugDraw);
    
    pbCache = [[PhysicsBodyCache alloc] init];
    
    [pbCache parseXMLFile:[[NSBundle mainBundle] URLForResource:@"Z9-Proton_bodies" withExtension:@"xml"]];
    
    //load needed textures
    [super.resourceManager loadTexture:@"Z9-Proton-Tire" path:@"Z9-Proton-Tire.png"];
    [super.resourceManager loadTexture:@"Z9-Proton" path:@"Z9-Proton-Orange.png"];
    [super.resourceManager loadTexture:@"testtrack" path:@"smaller@1.5x.png"];
    
    car = [[Z9Proton alloc] initWithWorld:m_world withCache:pbCache];
}

//update
-(void) update{
    float32 timeStep = 1.0 / (float) 30;      //the length of time passed to simulate (seconds)
    int32 velocityIterations = 16;   //how strongly to correct velocity
    int32 positionIterations = 6;   //how strongly to correct position
    
    [car update];
    
    m_world->Step( timeStep, velocityIterations, positionIterations);
}
//draw
-(void) draw : (Artist*) artist{
    float32 x = [car getBody]->GetPosition().x * PTM;
    float32 y = [car getBody]->GetPosition().y * PTM;
    [artist updateCameraPosition: x : y];
    m_debugDraw->setViewMatrix(GLKMatrix4Translate(GLKMatrix4Identity, -artist.cameraPosition.x, -artist.cameraPosition.y, 0));
    
    Texture* back = [super.resourceManager getTexture:@"testtrack"];
    
    [artist drawTexture:back position:GLKVector2Make(0, 0) size:GLKVector2Make(back.Width, back.Height) rotation:0];
    
    [car draw:artist];
    
    //m_world->DrawDebugData();
}

//handle input
-(void) onTouchBegan: (NSSet*) touch{
    for(UITouch* t in touch){
        CGPoint loc = [t locationInView:t.view];
        if(loc.x < 333) {
            car.direction = LEFT;
        }
        else if(loc.x > 333){
            car.direction = RIGHT;
        }
    }
}
-(void) onTouchMoved: (NSSet*) touch{
    
}
-(void) onTouchEnded: (NSSet*) touch{
    for(UITouch* t in touch){
        CGPoint loc = [t locationInView:t.view];
        if(loc.x < 333){
            car.direction = STRAIGHT;
        }
        else if(loc.x > 333){
            car.direction = STRAIGHT;
        }
    }
}

//unload
-(void) cleanup{
    delete m_world;
}

@end
