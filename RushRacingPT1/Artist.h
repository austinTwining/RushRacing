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

#define PTM 22

@interface Artist : NSObject

@property (strong, nonatomic) Shader* shader;

@property (assign) int halfScreenWidth;
@property (assign) int halfScreenHeight;

@property (assign) GLKVector3 cameraPosition;
@property (assign) GLKVector3 targetCameraPosition;

-(id) initWithShader: (Shader*) shader;
-(id) initWithShader:(Shader *)shader halfScreenWidth:(int) hWidth halfScreenHeight:(int) hHeight;

-(void) updateCameraPosition: (GLfloat) x : (GLfloat) y rotation: (GLfloat) r;
-(void) updateSmoothCameraPosition: (GLfloat) x : (GLfloat) y rotation: (GLfloat) r;
-(void) updateSmoothCamera;

-(void) drawTexture: (Texture*) tex position: (GLKVector2) position size: (GLKVector2) size rotation: (GLfloat) rotation;
-(void) drawTextureWithoutView: (Texture*) tex position: (GLKVector2) position size: (GLKVector2) size rotation: (GLfloat) rotation;

-(void) cleanup;

@end
