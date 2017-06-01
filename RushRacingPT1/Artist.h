//
//  Artist.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-04-08.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import <OpenGLES/ES3/glext.h>

#import "Texture.h"
#import "Shader.h"

#define PTM 32

@interface Artist : NSObject

@property (strong, nonatomic) Shader* shader;

@property (assign) int halfScreenWidth;
@property (assign) int halfScreenHeight;

@property (assign) GLKVector2 cameraPosition;

-(id) initWithShader: (Shader*) shader;
-(id) initWithShader:(Shader *)shader halfScreenWidth:(int) hWidth halfScreenHeight:(int) hHeight;

-(void) updateCameraPosition: (GLfloat) x : (GLfloat) y;

-(void) drawTexture: (Texture*) tex position: (GLKVector2) position size: (GLKVector2) size rotation: (GLfloat) rotation;

@end
