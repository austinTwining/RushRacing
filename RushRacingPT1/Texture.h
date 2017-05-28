//
//  Texture.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-05-24.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface Texture : NSObject

@property (nonatomic, strong) GLKTextureInfo* textureInfo;

@property (assign) GLuint Width;
@property (assign) GLuint Height;

-(id) init : (GLKTextureInfo*) texInfo;

-(void) bind;

-(GLKTextureInfo*) getTextureInfo;

@end
