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
#import "TrackCache.h"

#import "Z9Proton.h"

@interface TestScene(){
    b2World* m_world;
    DebugDraw* m_debugDraw;
    
    PhysicsBodyCache* pbCache;
    
    Car* car;
    
    Track* track;
    
    bool left;
    bool right;
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
    [super.resourceManager loadTexture:@"Z9-Proton-Tire" path:@"Z9-Proton-Tire-small.png"];
    [super.resourceManager loadTexture:@"Z9-Proton" path:@"Z9-Proton-Orange-small.png"];
    //[super.resourceManager loadTexture:@"testtrack" path:@"smaller.png"];
    
    track = [[ViewController getTrackCache].tracks valueForKey:@"TestTrack"];
    [track load];
    
    car = [[Z9Proton alloc] initWithWorld:m_world withCache:pbCache];
    
    ///////*GUI TEST*/////////
    [super.resourceManager loadTexture:@"Right-Button" path:@"RightButton@3x.png"];
    [super.resourceManager loadTexture:@"Brake-Button" path:@"BrakeButton@3x.png"];
}

//update
-(void) update{
    float32 timeStep = 1.0 / (float) 30;      //the length of time passed to simulate (seconds)
    int32 velocityIterations = 16;   //how strongly to correct velocity
    int32 positionIterations = 6;   //how strongly to correct position
    
    [car update];
    
    car.braking = (left && right);
    if(car.braking) car.direction = STRAIGHT;
    else if (left) car.direction = LEFT;
    else if (right)car.direction = RIGHT;
    else car.direction = STRAIGHT;
    
    m_world->Step( timeStep, velocityIterations, positionIterations);
}
//draw
-(void) draw : (Artist*) artist{
    float32 x = [car getBody]->GetPosition().x * PTM;
    float32 y = [car getBody]->GetPosition().y * PTM;
    //float32 r = [car getBody]->GetAngle();
    [artist updateSmoothCameraPosition: x : y rotation:0];
    [artist updateSmoothCamera];
    m_debugDraw->setViewMatrix(GLKMatrix4Translate(GLKMatrix4Identity, -artist.cameraPosition.x, -artist.cameraPosition.y, 0));
    
    //Texture* back = [super.resourceManager getTexture:@"testtrack"];
    
    //[artist drawTexture:back position:GLKVector2Make(0, 0) size:GLKVector2Make(back.Width, back.Height) rotation:0];
    
    [track draw:artist];
    
    [car draw:artist];
    
    //Texture* t = [[ViewController getResourceManager] getTexture:@"x-straight"];
    //[artist drawTexture:t position:GLKVector2Make(0, 0) size:GLKVector2Make(300, 300) rotation:0];
    
    //m_world->DrawDebugData();
    
    /////*DRAW GUI TEST///////
    /*Texture* rButton = [super.resourceManager getTexture:@"Right-Button"];
    Texture* bButton = [super.resourceManager getTexture:@"Brake-Button"];
    
    [artist drawTextureWithoutView:rButton position:GLKVector2Make(10 + rButton.Width/2, artist.halfScreenHeight*2 - (10 + rButton.Height/2)) size:GLKVector2Make(rButton.Width, rButton.Height) rotation:GLKMathDegreesToRadians(180)];
    [artist drawTextureWithoutView:rButton position:GLKVector2Make(30 + rButton.Width*1.5, artist.halfScreenHeight*2 - (10 + rButton.Height/2)) size:GLKVector2Make(rButton.Width, rButton.Height) rotation:0];
    [artist drawTextureWithoutView:bButton position:GLKVector2Make(artist.halfScreenWidth*2 - (10 + bButton.Width/2), artist.halfScreenHeight*2 - (10 + bButton.Height/2)) size:GLKVector2Make(bButton.Width, bButton.Height) rotation:0];*/
    
}

//handle input
-(void) onTouchBegan: (NSSet*) touch{
    for(UITouch* t in touch){
        CGPoint loc = [t locationInView:t.view];
        /*float w = [super.resourceManager getTexture:@"Right-Button"].Width;
        //float h = [super.resourceManager getTexture:@"Right-Button"].Height;
        if(loc.x < (10 + w/2)) {
            car.direction = LEFT;
        }
        else if(loc.x > (10 + w/2) && loc.x < (15 + (w))){
            car.direction = RIGHT;
        }
        else if(loc.x > (500 + w/2)){
            car.braking = true;
        }*/
        
        if(loc.x < 333){
            left = true;
        }
        else if(loc.x > 333){
            right = true;
        }
    }
}
-(void) onTouchMoved: (NSSet*) touch{
    
}
-(void) onTouchEnded: (NSSet*) touch{
    for(UITouch* t in touch){
        CGPoint loc = [t locationInView:t.view];
        /*float w = [super.resourceManager getTexture:@"Right-Button"].Width;
        //float h = [super.resourceManager getTexture:@"Right-Button"].Height;
        if(loc.x < (10 + w/2)) {
            car.direction = STRAIGHT;
        }
        else if(loc.x > (10 + w/2) && loc.x < (15 + (w))){
            car.direction = STRAIGHT;
        }
        else if(loc.x > (500 + w/2)){
            car.braking = false;
        }*/
        
        if(loc.x < 333){
            left = false;
        }
        else if(loc.x > 333){
            right = false;
        }
    }
}

//unload
-(void) cleanup{
    delete m_world;
}

@end
