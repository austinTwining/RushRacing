//
//  Scene.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-05-01.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Director.h"

@interface Scene : NSObject

//load
-(BOOL) load;

//update
-(void) update;
//draw
-(void) draw : (Artist*) artist;
//unload
-(void) unload;

@end
