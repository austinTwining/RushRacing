//
//  Track.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-07-11.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//
#include <Box2D/Box2D.h>

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "PhysicsBodyCache.h"
#import "Artist.h"

@class Artist;
@class PhysicsBodyCache;

@interface TrackCollisionTemplate : NSObject

@property (assign) NSArray* outside;
@property (assign) NSArray* inside;
@property (assign) float xOutside;
@property (assign) float yOutside;
@property (assign) float xInside;
@property (assign) float yInside;

-(id) init;

@end

@interface Track : NSObject

@property (assign) NSString* name;

@property (assign) float tileSize;

@property (assign) int Width;
@property (assign) int Height;

@property TrackCollisionTemplate* tCollisionTemp;

@property (strong, nonatomic) NSMutableDictionary* textures;
@property (strong, nonatomic) NSMutableDictionary* tiles;

@property (strong, nonatomic) NSMutableArray* krimskrams;

@property (strong, nonatomic) NSMutableArray* trackTiles;
@property (strong, nonatomic) NSMutableArray* backgroundTiles;

//TEMPORARY
@property (assign) GLKVector2 startPosition;
@property (assign) float startRotation;

-(id) init;

-(void) draw : (Artist*) artist;
-(void) draw : (Artist*) artist withPosition : (GLKVector2) position;

-(void) load;
-(void) loadWithPhysics: (PhysicsBodyCache*) pbc : (b2World*) world;
-(void) unload;

@end
