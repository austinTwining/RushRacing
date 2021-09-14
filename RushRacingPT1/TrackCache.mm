//
//  TrackCache.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-07-10.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "TrackCache.h"

typedef enum{
    DOCTYPE_TRACK,
    DOCTYPE_TILESET
}DocType;

@interface TrackCache(){
}
@property NSXMLParser* parser;

@property TileSetParser* tileSetParser;

@property Track* currentTrack;
@property NSString* currentTrackName;
@property NSString* currentLayer;

@property NSMutableDictionary* tileSetPaths;

@end

@implementation TrackCache

-(id) init{
    self = [super init];
    
    if(self){
        _tracks = [[NSMutableDictionary alloc] init];
        _tileSetParser = [[TileSetParser alloc] init];
    }
    return self;
}

-(void) parseTrack: (NSString*) name path: (NSURL*) xmlPath{
    _currentTrackName = name;
    _parser = [[NSXMLParser alloc] initWithContentsOfURL:xmlPath];
    _parser.delegate = self;
    [_parser parse];
    
    for(NSString* gid in _tileSetPaths){
        NSMutableArray* tiles = [[NSMutableArray alloc] init];
        
        NSString* filename = _tileSetPaths[gid];
        filename = [filename stringByReplacingOccurrencesOfString:@".tsx" withString:@""];
        
        [tiles addObjectsFromArray:[_tileSetParser parseTileSet:[[NSBundle mainBundle] URLForResource:filename withExtension:@"tsx"]]];
        
        for(TileTemplate* t in tiles){
            _currentTrack.textures[t.name] = t.path;
            int actualID = t.ID.intValue + gid.intValue;
            _currentTrack.tiles[[NSString stringWithFormat:@"%d",actualID]] = t.name;
        }
    }
    
    _tracks[_currentTrackName] = _currentTrack;
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    if([elementName isEqualToString:@"map"]){
        _currentTrack = [[Track alloc] init];
        _tileSetPaths = [[NSMutableDictionary alloc] init];
        _currentTrack.Width = [attributeDict valueForKey:@"width"].intValue;
        _currentTrack.Height = [attributeDict valueForKey:@"height"].intValue;
    }else if([elementName isEqualToString:@"tileset"]){
        _tileSetPaths[[attributeDict valueForKey:@"firstgid"]] = [attributeDict valueForKey:@"source"];
    }else if([elementName isEqualToString:@"layer"]){
        //NSLog(@"layer");
        _currentLayer = [attributeDict valueForKey:@"name"];
    }else if([elementName isEqualToString:@"tile"]){
        //NSLog(@"tile");
        if([_currentLayer isEqualToString:@"Track"]){
            //Tiled no longer saves empty tiles as GID 0
            //so in the case of an empty tile replace with GID 0
            NSString* gid = [attributeDict valueForKey:@"gid"];
            if(gid == nil) gid = @"0";
            [_currentTrack.trackTiles addObject:gid];
        }else if ([_currentLayer isEqualToString:@"Background"]){
            //Tiled no longer saves empty tiles as GID 0
            //so in the case of an empty tile replace with GID 0
            NSString* gid = [attributeDict valueForKey:@"gid"];
            if(gid == nil) gid = @"0";
            [_currentTrack.backgroundTiles addObject:gid];
        }
    }else if([elementName isEqualToString:@"objectgroup"]){
        _currentLayer = [attributeDict valueForKey:@"name"];
    }else if([elementName isEqualToString:@"object"]){
        if([_currentLayer isEqualToString:@"KrimsKrams"]){
            float x = [attributeDict valueForKey:@"x"].floatValue;
            float y = [attributeDict valueForKey:@"y"].floatValue;
            float width = [attributeDict valueForKey:@"width"].floatValue;
            float height = [attributeDict valueForKey:@"height"].floatValue;
            y -= height/2;
            x += width/2;
            KrimsKramsTemplate* kk = [[KrimsKramsTemplate alloc] init];
            kk.ID = [attributeDict valueForKey:@"gid"];
            kk.x = x;
            kk.y = y;
            kk.width = width;
            kk.height = height;
            [_currentTrack.krimskrams addObject:kk];
        }else if ([_currentLayer isEqualToString:@"GameObjects"]){
            if([[attributeDict valueForKey:@"name"] containsString:@"StartPoint"]){
                float x = [attributeDict valueForKey:@"x"].floatValue;
                float y = [attributeDict valueForKey:@"y"].floatValue;
                float width = [attributeDict valueForKey:@"width"].floatValue;
                float height = [attributeDict valueForKey:@"height"].floatValue;
                
                x -= height/2;
                y += width/2;
                
                _currentTrack.startPosition = GLKVector2Make(x, y);
                _currentTrack.startRotation = GLKMathDegreesToRadians([attributeDict valueForKey:@"rotation"].floatValue);
            }
        }else if ([_currentLayer isEqualToString:@"TrackCollision"]){
            if([[attributeDict valueForKey:@"name"] containsString:@"Outside"]){
                _currentTrack.tCollisionTemp.xOutside = [attributeDict valueForKey:@"x"].floatValue;
                _currentTrack.tCollisionTemp.yOutside = [attributeDict valueForKey:@"y"].floatValue;
            }
            if([[attributeDict valueForKey:@"name"] containsString:@"Inside"]){
                _currentTrack.tCollisionTemp.xInside = [attributeDict valueForKey:@"x"].floatValue;
                _currentTrack.tCollisionTemp.yInside = [attributeDict valueForKey:@"y"].floatValue;
            }
        }
    }else if([elementName isEqualToString:@"polygon"]){
        if([_currentLayer isEqualToString:@"TrackCollision"]){
            
        }
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {

}
@end

@implementation KrimsKramsTemplate

-(id) init{
    self = [super init];
    if(self){}
    return self;
}

@end
