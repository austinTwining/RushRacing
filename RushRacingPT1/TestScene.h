//
//  TestScene.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-05-31.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#include <Box2D/Box2D.h>

#import "Scene.h"
#import "ViewController.h"
#import "MainMenuScene.h"

@interface TestScene : Scene

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
