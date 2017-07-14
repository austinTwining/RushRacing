//
//  TileSetParser.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-07-13.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TileSetParser : NSObject <NSXMLParserDelegate>

@property (strong, nonatomic) NSMutableArray* tiles;

-(id) init;

-(NSMutableArray*) parseTileSet: (NSURL*) xmlPath;

@end

@interface TileTemplate : NSObject

@property (assign) NSString* ID;
@property (assign) NSString* name;
@property (assign) NSString* path;

-(id) init;

@end
