//
//  Track.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-07-11.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "Track.h"

@implementation Track

-(id) init{
    self = [super init];
    if(self){
        _textures = [[NSMutableDictionary alloc] init];
        _tiles = [[NSMutableDictionary alloc] init];
        _trackTiles = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) draw : (Artist*) artist{
    //draw track
    //NSLog(@"drawing track");
    for(int x = 0; x < _Width; x++){
        for(int y = 0; y < _Height; y++){
            NSString* tileToGet = [_trackTiles objectAtIndex:(_Width * y + x)];
            tileToGet = [_tiles valueForKey:tileToGet];
            if(tileToGet != nil){
                Texture* t = [[ViewController getResourceManager] getTexture:tileToGet];
                [artist drawTexture:t position:GLKVector2Make(x * _tileSize, y * _tileSize) size:GLKVector2Make(_tileSize, _tileSize) rotation:0];
            }
        }
    }
}

-(void) load{
    for(NSString* key in _textures){
        _tileSize = [[[ViewController getResourceManager] loadTexture:key path:[_textures valueForKey:key]] getTextureInfo].width;
        //[[ViewController getResourceManager] loadTexture:key path:[_textures valueForKey:key]];
        //_tileSize = 400;
    }
}
-(void) unload{
    for(NSString* key in _textures){
        [[ViewController getResourceManager] deleteTexture:key];
    }
}


@end
