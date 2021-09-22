//
//  ViewController.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-04-08.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

#import "Artist.h"
#import "Director.h"
#import "ResourceManager.h"
#import "TrackCache.h"

@class TrackCache;
@class PhysicsBodyCache;
@class Director;

@interface ViewController : GLKViewController

@property (strong, nonatomic) EAGLContext *context;
@property (strong, nonatomic) GLKBaseEffect *effect;

+(ResourceManager*) getResourceManager;
+(PhysicsBodyCache*) getPhysicsBodyCache;
+(TrackCache*) getTrackCache;
+(Director*) getDirector;
+(int) getScale;

@end

@interface Vec2 : NSObject
@property (assign) float x;
@property (assign) float y;
-(id)init;
@end

