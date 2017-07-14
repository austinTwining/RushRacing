//
//  Track.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-07-11.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "Artist.h"

@interface Track : NSObject

@property (assign) NSString* name;

@property (assign) int tileSize;

@property (assign) int Width;
@property (assign) int Height;

@property (strong, nonatomic) NSMutableDictionary* textures;
@property (strong, nonatomic) NSMutableDictionary* tiles;

@property (strong, nonatomic) NSMutableArray* trackTiles;

-(id) init;

-(void) draw : (Artist*) artist;

-(void) load;
-(void) unload;

@end
