//
//  Shader.h
//  GLGame
//
//  Created by Austin-James Twining on 2017-04-07.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES3/glext.h>
#import <GLKit/GLKit.h>

@interface Shader : NSObject

@property GLuint programID;

-(id) init;

-(void) start;
-(void) stop;

-(void) compile: (GLchar*) vertexSource : (GLchar*) fragmentSource;

-(void) setFloat: (const GLchar*) name : (GLfloat) value;
-(void) setInteger: (const GLchar*) name : (GLint) value;
-(void) setVector2f: (const GLchar*) name : (GLfloat) x : (GLfloat) y;
-(void) setVector2f: (const GLchar*) name : (GLKVector2) value;
-(void) setVector3f: (const GLchar*) name : (GLfloat) x : (GLfloat) y : (GLfloat) z;
-(void) setVector3f: (const GLchar*) name : (GLKVector3) value;
-(void) setVector4f: (const GLchar*) name : (GLfloat) x : (GLfloat) y : (GLfloat) z : (GLfloat) w;
-(void) setVector4f: (const GLchar*) name : (GLKVector4) value;
-(void) setMatrix4: (const GLchar*) name : (GLKMatrix4) value;

@end
