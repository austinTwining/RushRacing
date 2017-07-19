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
        _backgroundTiles = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) draw : (Artist*) artist{
    //draw background
    for(int x = 0; x < _Width; x++){
        for(int y = 0; y < _Height; y++){
            NSString* tileToGet = [_backgroundTiles objectAtIndex:(_Width * y + x)];
            tileToGet = [_tiles valueForKey:tileToGet];
            if(tileToGet != nil){
                Texture* t = [[ViewController getResourceManager] getTexture:tileToGet];
                [artist drawTexture:t position:GLKVector2Make(x * _tileSize, y * _tileSize) size:GLKVector2Make(_tileSize, _tileSize) rotation:0];
            }
        }
    }
    
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

-(void) draw : (Artist*) artist withPosition : (GLKVector2) position{
    float xp = floor(position.x / _tileSize);
    float yp = floor(position.y / _tileSize);
    if(xp > _Width) xp = _Width;
    else if(xp < 0) xp = 0;
    if(yp > _Height) yp = _Height;
    else if(yp < 0) yp = 0;
    //draw background
    for(int x = xp - 2; x < xp + 4; x++){
        for(int y = yp - 2; y < yp + 3; y++){
            NSString* tileToGet;
            if(x >= 0 && x < _Width && y >= 0 && y < _Height){
                tileToGet = [_backgroundTiles objectAtIndex:(_Width * y + x)];
                tileToGet = [_tiles valueForKey:tileToGet];
            }
            if(tileToGet != nil){
                Texture* t = [[ViewController getResourceManager] getTexture:tileToGet];
                [artist drawTexture:t position:GLKVector2Make(x * _tileSize, y * _tileSize) size:GLKVector2Make(_tileSize, _tileSize) rotation:0];
            }
        }
    }
    
    //draw track
    //NSLog(@"drawing track");
    for(int x = xp - 2; x < xp + 4; x++){
        for(int y = yp - 2; y < yp + 3; y++){
            NSString* tileToGet;
            if(x >= 0 && x < _Width && y >= 0 && y < _Height){
                tileToGet = [_trackTiles objectAtIndex:(_Width * y + x)];
                tileToGet = [_tiles valueForKey:tileToGet];
            }
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
        //_tileSize = 200;
    }
}
-(void) loadWithPhysics: (PhysicsBodyCache*) pbc : (b2World*) world{
    for(NSString* key in _textures){
        _tileSize = [[[ViewController getResourceManager] loadTexture:key path:[_textures valueForKey:key]] getTextureInfo].width;
    }
    
    for(int x = 0; x < _Width; x++){
        for(int y = 0; y < _Height; y++){
            NSString* tileToGet;
            tileToGet = [_trackTiles objectAtIndex:(_Width * y + x)];
            tileToGet = [_tiles valueForKey:tileToGet];
            if(tileToGet != nil){
                [pbc createBody:tileToGet withWorld:world withPosition:b2Vec2(x * (_tileSize / PTM), y * (_tileSize / PTM))];
            }
        }
    }

}
-(void) unload{
    for(NSString* key in _textures){
        [[ViewController getResourceManager] deleteTexture:key];
    }
}


@end
