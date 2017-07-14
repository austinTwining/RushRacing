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
@property NSString* currentTrackLayer;

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
        _currentTrackLayer = [attributeDict valueForKey:@"name"];
    }else if([elementName isEqualToString:@"tile"]){
        //NSLog(@"tile");
        if([_currentTrackLayer isEqualToString:@"Track"]){
            [_currentTrack.trackTiles addObject:[attributeDict valueForKey:@"gid"]];
        }
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {

}
@end
