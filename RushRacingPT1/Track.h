//
//  Track.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-07-11.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//
#include <Box2D/Box2d.h>

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "PhysicsBodyCache.h"
#import "Artist.h"

@interface Track : NSObject

@property (assign) NSString* name;

@property (assign) float tileSize;

@property (assign) int Width;
@property (assign) int Height;

@property (strong, nonatomic) NSMutableDictionary* textures;
@property (strong, nonatomic) NSMutableDictionary* tiles;

@property (strong, nonatomic) NSMutableArray* trackTiles;
@property (strong, nonatomic) NSMutableArray* backgroundTiles;

@property (assign) GLKVector2 startPosition;

-(id) init;

-(void) draw : (Artist*) artist;
-(void) draw : (Artist*) artist withPosition : (GLKVector2) position;

-(void) load;
-(void) loadWithPhysics: (PhysicsBodyCache*) pbc : (b2World*) world;
-(void) unload;

@end
