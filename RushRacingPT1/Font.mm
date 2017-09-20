//
//  Font.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-08-01.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "Font.h"

@implementation Font

-(id) initWithPath: (NSString*) path{
    self = [super init];
    if(self){
        _characters = [[NSMutableDictionary alloc] init];
        _name = path;
        
        NSString* atlasPath = [[NSBundle mainBundle] pathForResource:path ofType:@"png"];
        
        _atlasSize = [[ViewController getResourceManager] loadTexture:path path:atlasPath].Width;
        
        NSString* fontPath = [[NSBundle mainBundle] pathForResource:path ofType:@"fnt"];
        NSString* fontContents = [NSString stringWithContentsOfFile:fontPath encoding:NSUTF8StringEncoding error:nil];
        NSArray* lines = [fontContents componentsSeparatedByString:@"\n"];
        for(NSString* line in lines){
            Character* c = [self loadCharacter: [self processLine:line]];
            NSString* ch = [NSString stringWithFormat:@"%c", c.ID];
            _characters[ch] = c;
        }
    }
    return self;
}

-(NSMutableDictionary*) processLine: (NSString*) line{
    NSMutableDictionary* values = [[NSMutableDictionary alloc] init];
    NSArray* rawPairs = [line componentsSeparatedByString:@" "];
    for(NSString* rawPair in rawPairs){
        NSArray* pair = [rawPair componentsSeparatedByString:@"="];
        if(pair.count == 2){
            NSString* key = pair.firstObject;
            NSString* value = pair.lastObject;
            values[key] = value;
        }
    }
    return values;
}

-(Character*) loadCharacter: (NSMutableDictionary*) values{
    Character* ch = [[Character alloc] init];
    
    NSString* idString = [values valueForKey:@"id"];
    if(idString == nil) return nil;
    NSString* xString = [values valueForKey:@"x"];
    NSString* yString = [values valueForKey:@"y"];
    NSString* widthString = [values valueForKey:@"width"];
    NSString* heightString = [values valueForKey:@"height"];
    NSString* xoffsetString = [values valueForKey:@"xoffset"];
    NSString* yoffsetString = [values valueForKey:@"yoffset"];
    NSString* xadvanceString = [values valueForKey:@"xadvance"];
    
    ch.ID = idString.intValue;
    ch.xTexCoord = xString.doubleValue / _atlasSize;
    ch.yTexCoord = yString.doubleValue / _atlasSize;
    ch.width = widthString.doubleValue / _atlasSize;
    ch.height = heightString.doubleValue / _atlasSize;
    ch.xOffset = xoffsetString.doubleValue / _atlasSize;
    ch.yOffset = yoffsetString.doubleValue / _atlasSize;
    ch.xAdvance = xadvanceString.doubleValue / _atlasSize;
    
    return ch;
}

@end
