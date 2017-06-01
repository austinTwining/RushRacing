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

@class Scene;

@interface Director : NSObject

+(void) setCurrentScene : (NSString*) name;

+(void) addScene : (Scene*) scene withName: (NSString*) name shouldBeCurrent: (GLboolean) setCurrent;
+(void) deleteScene : (NSString*) name;

+(void) update;
+(void) draw : (Artist*) artist;

@end
