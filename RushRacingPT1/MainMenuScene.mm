//
//  MainMenuScene.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-08-04.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "MainMenuScene.h"

@interface MainMenuScene(){
    Button* play;
    Button* store;
    Button* garage;
    Button* settings;
    
    Font* font;
}

@end

@implementation MainMenuScene

//load
-(void) initialize{
    [[ViewController getResourceManager] loadTexture:@"Logo" path:@"Logo@2x.png"];
    [[ViewController getResourceManager] loadTexture:@"Button" path:@"Button.png"];
    [[ViewController getResourceManager] loadTexture:@"ButtonSecondary" path:@"ButtonSecondary.png"];
    
    font = [[Font alloc] initWithPath:@"AsapNEHE"];
    
    GLKVector3 colour = GLKVector3Make(0.9f, 0.9f, 0.9f);
    
    play = [[Button alloc] initWithMainTexture:[[ViewController getResourceManager] getTexture:@"Button"] withSecondary:[[ViewController getResourceManager] getTexture:@"ButtonSecondary"]];
    play.x = 850 + (play.width/2);
    play.y = 150 + (play.height/2);
    [play setText:@"Play" withFont:font withColour:colour withSize:1];
    store = [[Button alloc] initWithMainTexture:[[ViewController getResourceManager] getTexture:@"Button"] withSecondary:[[ViewController getResourceManager] getTexture:@"ButtonSecondary"]];
    store.x = 850 + (store.width/2);
    store.y = 270 + (store.height/2);
    [store setText:@"Store" withFont:font withColour:colour withSize:1];
    garage = [[Button alloc] initWithMainTexture:[[ViewController getResourceManager] getTexture:@"Button"] withSecondary:[[ViewController getResourceManager] getTexture:@"ButtonSecondary"]];
    garage.x = 850 + (garage.width/2);
    garage.y = 390 + (garage.height/2);
    [garage setText:@"Garage" withFont:font withColour:colour withSize:1];
    settings = [[Button alloc] initWithMainTexture:[[ViewController getResourceManager] getTexture:@"Button"] withSecondary:[[ViewController getResourceManager] getTexture:@"ButtonSecondary"]];
    settings.x = 850 + (settings.width/2);
    settings.y = 510 + (settings.height/2);
    [settings setText:@"Settings" withFont:font withColour:colour withSize:1];
}

//update
-(void) update{
    
}
//draw
-(void) draw : (Artist*) artist{
    Texture* t = [[ViewController getResourceManager] getTexture:@"Logo"];
    [artist drawGUITexture:t position:GLKVector2Make(148 + (t.Width/2), 380) size:GLKVector2Make(t.Width, t.Height) rotation:0];
    [play draw:artist];
    [store draw:artist];
    [garage draw:artist];
    [settings draw:artist];
    
//    [artist drawText:@"Play" withFont:font withColour:GLKVector3Make(0.9f, 0.9f, 0.9f) atPosition:GLKVector2Make(975, 150) size:1];
//    [artist drawText:@"Store" withFont:font withColour:GLKVector3Make(0.9f, 0.9f, 0.9f) atPosition:GLKVector2Make(975, 270) size:1];
//    [artist drawText:@"Garage" withFont:font withColour:GLKVector3Make(0.9f, 0.9f, 0.9f) atPosition:GLKVector2Make(975, 390) size:1];
//    [artist drawText:@"Settings" withFont:font withColour:GLKVector3Make(0.9f, 0.9f, 0.9f) atPosition:GLKVector2Make(975, 510) size:1];
}

//handle input
-(void) onTouchBegan: (NSSet*) touch{
    for(UITouch* t in touch){
        CGPoint loc = [t locationInView:t.view];
        loc.x *= [ViewController getScale];
        loc.y *= [ViewController getScale];
        if([play checkInput:loc]){
            //create the initial scene *TEMPORARY*
            //Scene* s = [[TestScene alloc] initWithResourceManager:[ViewController getResourceManager]];
            //add the scene to the director
            //[[ViewController getDirector] deleteScene:@"MainMenu"];
            //[[ViewController getDirector] addScene:s withName:@"testScene" shouldBeCurrent:true];
            play.isPressed = true;
        }
        if([store checkInput:loc]) store.isPressed = true;
        if([garage checkInput:loc]) garage.isPressed = true;
        if([settings checkInput:loc]) settings.isPressed = true;
    }
}
-(void) onTouchMoved: (NSSet*) touch{
    for(UITouch* t in touch){
        CGPoint loc = [t locationInView:t.view];
        loc.x *= [ViewController getScale];
        loc.y *= [ViewController getScale];
        if([play checkInput:loc]) play.isPressed = true;
        else play.isPressed = false;
        if([store checkInput:loc]) store.isPressed = true;
        else store.isPressed = false;
        if([garage checkInput:loc]) garage.isPressed = true;
        else garage.isPressed = false;
        if([settings checkInput:loc]) settings.isPressed = true;
        else settings.isPressed = false;
    }
}
-(void) onTouchEnded: (NSSet*) touch{
    for(UITouch* t in touch){
        CGPoint loc = [t locationInView:t.view];
        loc.x *= [ViewController getScale];
        loc.y *= [ViewController getScale];
        if([play checkInput:loc]){
            play.isPressed = false;
            [[ViewController getDirector] setScene:@"testScene"];
            [self cleanup];
        }
        if([store checkInput:loc]) store.isPressed = false;
        if([garage checkInput:loc]) garage.isPressed = false;
        if([settings checkInput:loc]) settings.isPressed = false;
    }
}

//unload
-(void) cleanup{
    [[ViewController getResourceManager] deleteTexture:@"Logo"];
    [[ViewController getResourceManager] deleteTexture:@"Button"];
    [[ViewController getResourceManager] deleteTexture:@"ButtonSecondary"];
    NSLog(@"Main Menu Clean Up!");
    NSLog( @"%@", [ViewController getResourceManager].Textures );
}

@end
