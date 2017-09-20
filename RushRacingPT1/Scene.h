//
//  Scene.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-05-01.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Director.h"
#import "ResourceManager.h"
#import "ViewController.h"

@class Artist;

@interface Scene : NSObject

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
