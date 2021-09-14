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
    
    Font* font;
    
    Button* pause;
    Button* menu;
}

@end

@implementation TestScene

//load
-(void) initialize{
    m_world = new b2World(b2Vec2(0,0));// init physics world
    m_debugDraw = new DebugDraw(PTM, [ViewController getResourceManager]);
    m_debugDraw->SetFlags(b2Draw::e_shapeBit + b2Draw::e_jointBit);
    m_world->SetDebugDraw(m_debugDraw);
    
    pbCache = [[PhysicsBodyCache alloc] init];
    
    [pbCache parseXMLFile:[[NSBundle mainBundle] URLForResource:@"Z9-Proton_bodies" withExtension:@"xml"]];
    
    //load needed textures
    [[ViewController getResourceManager] loadTexture:@"Z9-Proton-Tire" path:@"Z9-Proton-Tire-small.png"];
    [[ViewController getResourceManager] loadTexture:@"Z9-Proton" path:@"Z9-Proton-Orange-small.png"];
    
    [[ViewController getResourceManager] loadTexture:@"PauseButton" path:@"PauseButton.png"];
    [[ViewController getResourceManager] loadTexture:@"PauseButtonSecondary" path:@"PauseButtonSecondary.png"];
    
    [[ViewController getResourceManager] loadTexture:@"WhiteButton" path:@"WhiteButton.png"];
    [[ViewController getResourceManager] loadTexture:@"WhiteButtonSecondary" path:@"WhiteButtonSecondary.png"];
    
    [[ViewController getResourceManager] loadTexture:@"PopUpBackground" path:@"PopUpBackground.png"];
    
    track = [[ViewController getTrackCache].tracks valueForKey:@"Track"];
    [track loadWithPhysics:pbCache :m_world];
    
    car = [[Z9Proton alloc] initWithWorld:m_world withCache:pbCache withPosition:b2Vec2(track.startPosition.x / PTM, track.startPosition.y / PTM) withRotation:track.startRotation];
    
    car.driving = false;
    [ViewController getDirector].paused = false;
    
    font = [[Font alloc] initWithPath:@"AsapNEHE"];
    
    pause = [[Button alloc] initWithMainTexture:[[ViewController getResourceManager] getTexture:@"PauseButton"] withSecondary:[[ViewController getResourceManager] getTexture:@"PauseButtonSecondary"]];
    pause.x = 1250;
    pause.y = 75;
    menu = [[Button alloc] initWithMainTexture:[[ViewController getResourceManager] getTexture:@"WhiteButton"] withSecondary:[[ViewController getResourceManager] getTexture:@"WhiteButtonSecondary"]];
    menu.x = 666;
    menu.y = 220;
    [menu setText:@"Menu" withFont:font withColour:GLKVector3Make(0.4f, 0.4f, 0.9f) withSize:0.5];
}

//update
-(void) update{
    float32 timeStep = 1.0 / (float) 30;      //the length of time passed to simulate (seconds)
    int32 velocityIterations = 16;   //how strongly to correct velocity
    int32 positionIterations = 6;   //how strongly to correct position
    
    if(![ViewController getDirector].paused){
        [car update];
        
        car.braking = (left && right);
        if(car.braking) car.direction = STRAIGHT;
        else if (left) car.direction = LEFT;
        else if (right)car.direction = RIGHT;
        else car.direction = STRAIGHT;
        
        m_world->Step( timeStep, velocityIterations, positionIterations);
    }
}
//draw
-(void) draw : (Artist*) artist{
    float32 x = [car getBody]->GetPosition().x * PTM;
    float32 y = [car getBody]->GetPosition().y * PTM;
    //float32 r = [car getBody]->GetAngle();
    [artist updateSmoothCameraPosition: x : y rotation:0];
    [artist updateSmoothCamera];
    m_debugDraw->setViewMatrix(GLKMatrix4Translate(GLKMatrix4Identity, -artist.cameraPosition.x, -artist.cameraPosition.y, 0));
    
    //Texture* back = [[ViewController getResourceManager] getTexture:@"testtrack"];
    
    //[artist drawTexture:back position:GLKVector2Make(0, 0) size:GLKVector2Make(back.Width, back.Height) rotation:0];
    
    [track draw:artist withPosition:GLKVector2Make([car getBody]->GetPosition().x * PTM, [car getBody]->GetPosition().y * PTM)];
    
    [car draw:artist];
    
    //Texture* t = [[ViewController getResourceManager] getTexture:@"x-straight"];
    //[artist drawTexture:t position:GLKVector2Make(0, 0) size:GLKVector2Make(300, 300) rotation:0];
    
    m_world->DrawDebugData();
    
    /////*DRAW GUI TEST///////
    /*Texture* rButton = [[ViewController getResourceManager] getTexture:@"Right-Button"];
    Texture* bButton = [[ViewController getResourceManager] getTexture:@"Brake-Button"];
    
    [artist drawTextureWithoutView:rButton position:GLKVector2Make(10 + rButton.Width/2, artist.halfScreenHeight*2 - (10 + rButton.Height/2)) size:GLKVector2Make(rButton.Width, rButton.Height) rotation:GLKMathDegreesToRadians(180)];
    [artist drawTextureWithoutView:rButton position:GLKVector2Make(30 + rButton.Width*1.5, artist.halfScreenHeight*2 - (10 + rButton.Height/2)) size:GLKVector2Make(rButton.Width, rButton.Height) rotation:0];
    [artist drawTextureWithoutView:bButton position:GLKVector2Make(artist.halfScreenWidth*2 - (10 + bButton.Width/2), artist.halfScreenHeight*2 - (10 + bButton.Height/2)) size:GLKVector2Make(bButton.Width, bButton.Height) rotation:0];*/
    
    [pause draw:artist];
    
    int currentSpeed = car.currentSpeed;
    NSString* speed = [NSString stringWithFormat:@"%d", currentSpeed];
    [artist drawText:speed withFont:font withColour:GLKVector3Make(1 - 0.196, 1 - 0.58, 1 - 0.196) atPosition:GLKVector2Make(1225, 650) size:1];
    
    if([ViewController getDirector].paused){
        Texture* t = [[ViewController getResourceManager] getTexture:@"PopUpBackground"];
        [artist drawGUITexture:t position:GLKVector2Make(666, 375) size:GLKVector2Make(t.Width, t.Height) rotation:0];
        [menu draw:artist];
    }
}

//handle input
-(void) onTouchBegan: (NSSet*) touch{
    for(UITouch* t in touch){
        car.driving = true;
        CGPoint loc = [t locationInView:t.view];
        loc.x *= [ViewController getScale];
        loc.y *= [ViewController getScale];
        if([pause checkInput:loc]){
            pause.isPressed = true;
        }else{
            if(loc.x < 666){
                left = true;
            }
            else if(loc.x > 666){
                right = true;
            }
        }
        if([ViewController getDirector].paused){
            if([menu checkInput:loc]){
                menu.isPressed = true;
            }
        }
    }
}
-(void) onTouchMoved: (NSSet*) touch{
    for(UITouch* t in touch){
        CGPoint loc = [t locationInView:t.view];
        loc.x *= [ViewController getScale];
        loc.y *= [ViewController getScale];
        if([pause checkInput:loc]){
            pause.isPressed = true;
        }else{
            pause.isPressed = false;
//            if(loc.x < 666){
//                left = true;
//            }else left = false;
//            if(loc.x > 666){
//                right = true;
//            }else right = false;
        }
        if([ViewController getDirector].paused){
            if([menu checkInput:loc]){
                menu.isPressed = true;
            }else{
                menu.isPressed = false;
            }
        }
    }

}
-(void) onTouchEnded: (NSSet*) touch{
    for(UITouch* t in touch){
        CGPoint loc = [t locationInView:t.view];
        loc.x *= [ViewController getScale];
        loc.y *= [ViewController getScale];
        if([pause checkInput:loc]){
            [ViewController getDirector].paused = ![ViewController getDirector].paused;
            pause.isPressed = false;
        }else{
            if(loc.x < 666){
                left = false;
            }
            else if(loc.x > 666){
                right = false;
            }
        }
        if([ViewController getDirector].paused){
            if([menu checkInput:loc]){
                [[ViewController getDirector] setScene:@"MainMenu"];
                [self cleanup];
                menu.isPressed = false;
            }
        }
    }
}

//unload
-(void) cleanup{
    delete m_world;
    delete m_debugDraw;
    [[ViewController getResourceManager] deleteTexture:@"Z9-Proton-Tire"];
    [[ViewController getResourceManager] deleteTexture:@"Z9-Proton"];
    [[ViewController getResourceManager] deleteTexture:@"PauseButton"];
    [[ViewController getResourceManager] deleteTexture:@"PauseButtonSecondary"];
    [[ViewController getResourceManager] deleteTexture:@"WhiteButton"];
    [[ViewController getResourceManager] deleteTexture:@"WhiteButtonSecondary"];
    [[ViewController getResourceManager] deleteTexture:@"PopUpBackground"];
    [track unload];
    NSLog(@"Test Scene Clean Up!");
    NSLog( @"%@", [ViewController getResourceManager].Textures );
}

@end
