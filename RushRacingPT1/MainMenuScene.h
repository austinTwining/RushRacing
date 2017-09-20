//
//  MainMenuScene.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-08-04.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "Scene.h"
#import "Button.h"
#import "Font.h"
#import "TestScene.h"

@interface MainMenuScene : Scene

//load
-(void) initialize;

//update
-(void) update;
//draw
-(void) draw : (Artist*) artist;

//handle input
-(void) onTouchBegan: (NSSet*) touch;
-(void) onTouchMoved: (NSSet*) touch;
-(void) onTouchEnded: (NSSet*) touch;

//unload
-(void) cleanup;

@end
