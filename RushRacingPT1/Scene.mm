//
//  Scene.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-05-31.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "Scene.h"

@implementation Scene

//load
-(void) initialize{NSLog(@"Implement in sub class");}
//update
-(void) update{NSLog(@"Implement in sub class");}
//draw
-(void) draw : (Artist*) artist{NSLog(@"Implement in sub class");}
//handle input
-(void) onTouchBegan: (NSSet*) touch{NSLog(@"Implement in sub class");}
-(void) onTouchMoved: (NSSet*) touch{NSLog(@"Implement in sub class");}
-(void) onTouchEnded: (NSSet*) touch{NSLog(@"Implement in sub class");}
//unload
-(void) cleanup{NSLog(@"Implement in sub class");}

@end
