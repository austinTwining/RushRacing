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
#import "Font.h"

#define PTM 22

@class Font;

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

-(void) drawText: (NSString*) text withFont: (Font*) font withColour: (GLKVector3) colour atPosition: (GLKVector2) position size: (float) size;
-(void) drawGUITexture: (Texture*) tex position: (GLKVector2) position size: (GLKVector2) size rotation: (GLfloat) rotation;

-(void) drawTexture: (Texture*) tex position: (GLKVector2) position size: (GLKVector2) size rotation: (GLfloat) rotation;

-(void) cleanup;

@end
