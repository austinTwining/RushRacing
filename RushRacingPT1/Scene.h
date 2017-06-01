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

@interface Scene : NSObject

-(id) init;

//load
-(void) initialize;

//update
-(void) update;
//draw
-(void) draw : (Artist*) artist;

//unload
-(void) cleanup;

@end
