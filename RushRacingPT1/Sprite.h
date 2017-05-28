//
//  Sprite.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-04-08.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES3/glext.h>
#import <GLKit/GLKit.h>

#import "Loader.h"

@interface Sprite : NSObject

@property (nonatomic, strong) GLKTextureInfo* textureInfo;

@property (assign) GLKVector2 position;
@property (assign) float rotation;
@property (assign) GLKVector2 size;

@property GLuint VAO;
@property GLuint VBO;
@property GLuint EBO;

-(id) initWithTextureInfo: (GLKTextureInfo*) texInfo;

@end
