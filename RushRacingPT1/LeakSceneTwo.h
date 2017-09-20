//
//  LeakSceneTwo.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-08-08.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "Scene.h"
#import "LeakSceneOne.h"

@interface LeakSceneTwo : Scene

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
