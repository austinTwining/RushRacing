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

@interface Artist : NSObject

@property (strong, nonatomic) Shader* shader;

@property (assign) GLKVector2 cameraPosition;

-(id) initWithShader: (Shader*) shader;

-(void) updateCameraPosition: (GLfloat) x : (GLfloat) y;
-(void) updateCameraPosition: (GLKVector2) camPos;

-(void) drawTexture: (Texture*) tex : (GLKVector2) position : (GLKVector2) size : (GLfloat) rotation;

@end
