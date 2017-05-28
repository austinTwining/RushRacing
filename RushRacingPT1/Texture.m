//
//  Texture.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-05-24.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "Texture.h"

@implementation Texture

-(id) init : (GLKTextureInfo*) texInfo{
    self = [super init];
    
    if(self){
        [self bind];
        _textureInfo = texInfo;
        _Width = _textureInfo.width;
        _Height = _textureInfo.height;
        glTexParameteri(_textureInfo.target, GL_TEXTURE_WRAP_S, GL_REPEAT);
        glTexParameteri(_textureInfo.target, GL_TEXTURE_WRAP_T, GL_REPEAT);
        glTexParameteri(_textureInfo.target, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        glTexParameteri(_textureInfo.target, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    }
    
    return self;
}

-(void) bind { glBindTexture(_textureInfo.target, _textureInfo.name); }

-(GLKTextureInfo*) getTextureInfo { return _textureInfo; }

@end
