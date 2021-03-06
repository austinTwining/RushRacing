//
//  TrackCache.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-07-10.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Track.h"
#import "TileSetParser.h"

@interface TrackCache : NSObject <NSXMLParserDelegate>

@property (strong, nonatomic) NSMutableDictionary* tracks;

-(id) init;

-(void) parseTrack: (NSString*) name path: (NSURL*) xmlPath;

@end

@interface KrimsKramsTemplate : NSObject

@property (assign) NSString* ID;
@property (assign) float x;
@property (assign) float y;
@property (assign) float width;
@property (assign) float height;

-(id) init;

@end
