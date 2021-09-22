//
//  PhysicsBodyCache.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-07-07.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//
#include <Box2D/Box2D.h>

#import <Foundation/Foundation.h>
#import "Artist.h"
#import "Track.h"

@class TrackCollisionTemplate;

@interface PhysicsBodyCache : NSObject <NSXMLParserDelegate>

@property (strong, nonatomic) NSMutableDictionary* bodies;

-(id) init;
-(id) initWithRatio : (float) aRatio;

-(b2Body*) createBody : (NSString*) name withWorld : (b2World*) world;
-(b2Body*) createBody : (NSString*) name withWorld : (b2World*) world withPosition : (b2Vec2) position;
-(b2Body*) createBody : (NSString*) name withWorld : (b2World*) world withPosition : (b2Vec2) position withRotation : (float) rotation;

-(void) createPerimiterBody: (TrackCollisionTemplate*)cTemp withWorld : (b2World*) world;

-(void) parseXMLFile : (NSURL*) xmlPath;
-(void) deleteBody : (NSString*) name;
-(void) deleteAllBodies;

@end

@interface BodyTemplate : NSObject

@property (assign) NSString* name;
@property (assign) bool isDynamic;

@property (strong, nonatomic) NSMutableArray* fixtureTemplates;

-(id) init;

@end

@interface FixtureTemplate : NSObject

@property (assign) float density;
@property (assign) float friction;
@property (assign) float restitution;
@property (assign) NSString* fixtureType;

@property (strong, nonatomic) NSMutableArray* polygons;
@property (strong, nonatomic) NSMutableArray* circles;

-(id) init;

@end

@interface PolygonTemplate : NSObject

@property (strong, nonatomic) NSMutableArray* vertices;

-(id) init;

@end

@interface CircleTemplate : NSObject

@property (assign) float x;
@property (assign) float y;
@property (assign) float radius;

-(id) init;

@end

@interface Vector2f : NSObject

@property (assign) float x;
@property (assign) float y;

-(id) init;

@end
