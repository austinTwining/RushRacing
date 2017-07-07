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

@interface TestScene(){
    b2World* m_world;
    DebugDraw m_debugDraw;
    
    PhysicsBodyCache* pbCache;
    b2Body* b;
    b2Body* b2;
}

@end

@implementation TestScene

//load
-(void) initialize{
    m_world = new b2World(b2Vec2(0,0));// init physics world
    m_debugDraw.SetFlags(b2Draw::e_shapeBit + b2Draw::e_jointBit);
    m_world->SetDebugDraw(&m_debugDraw);
    
    pbCache = [[PhysicsBodyCache alloc] init];
    
    [pbCache parseXMLFile:[[NSBundle mainBundle] URLForResource:@"testshape2" withExtension:@"xml"]];
    
    b = [pbCache createBody:@"Z9-Proton-Orange" withWorld:m_world];
    
    //load needed textures
    [ResourceManager loadTexture:@"Z9-ProtonTire" path:@"Z9-Proton-Tire.png"];
    [ResourceManager loadTexture:@"Z9-Proton" path:@"Z9-Proton-Orange.png"];
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
    [artist updateCameraPosition: b->GetPosition().x * PTM : b->GetPosition().y * PTM];
    m_debugDraw.setViewMatrix(GLKMatrix4Translate(GLKMatrix4Identity, -artist.cameraPosition.x, -artist.cameraPosition.y, 0));
    
    Texture* t = [ResourceManager getTexture:@"Z9-Proton"];
    
    [artist drawTexture:t position:GLKVector2Make(b->GetPosition().x * PTM, b->GetPosition().y * PTM) size:GLKVector2Make(t.Width, t.Height) rotation:0];
    
    m_world->DrawDebugData();
}

//handle input
-(void) onTouchBegan: (NSSet*) touch{
    for(UITouch* t in touch){
        CGPoint loc = [t locationInView:t.view];
        if(loc.x < 333) {
        }//car.direction = LEFT;
        else if(loc.x > 333){
        }//car.direction = RIGHT;
    }
}
-(void) onTouchMoved: (NSSet*) touch{
    
}
-(void) onTouchEnded: (NSSet*) touch{
    for(UITouch* t in touch){
        CGPoint loc = [t locationInView:t.view];
        if(loc.x < 666){
        }//car.direction = STRAIGHT;
        else if(loc.x > 666){
        }//car.direction = STRAIGHT;
    }
}

//unload
-(void) cleanup{
    delete m_world;
}

@end
