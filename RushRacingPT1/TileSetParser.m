//
//  TileSetParser.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-07-13.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "TileSetParser.h"

@interface TileSetParser(){
}

@property NSXMLParser* parser;

@property TileTemplate* currentTile;

@end

@implementation TileSetParser

-(id) init{
    self = [super init];
    if(self){
    }
    return self;
}

-(NSMutableArray*) parseTileSet: (NSURL*) xmlPath{
    _tiles = [[NSMutableArray alloc] init];
    
    self.parser = [[NSXMLParser alloc] initWithContentsOfURL:xmlPath];
    self.parser.delegate = self;
    [self.parser parse];
    
    NSLog(@"parsing");
    
    return _tiles;
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    
    if([elementName isEqualToString:@"tile"]){
        _currentTile = [[TileTemplate alloc] init];
        _currentTile.ID = [attributeDict valueForKey:@"id"];
    }else if([elementName isEqualToString:@"image"]){
        _currentTile.name = [[attributeDict valueForKey:@"source"] stringByReplacingOccurrencesOfString:@".png" withString:@""];
        _currentTile.path = [attributeDict valueForKey:@"source"];
    }
    
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    if([elementName isEqualToString:@"tile"]){
        [_tiles addObject:_currentTile];
    }
}

@end

@implementation TileTemplate

-(id) init{
    self = [super init];
    if(self){}
    return self;
}

@end


