//
//  Director.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-05-01.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Artist.h"
#import "Scene.h"

@interface Director : NSObject

-(id) init;

-(void) update;
-(void) draw : (Artist*) artist;

@end
