//
//  Shader.m
//  GLGame
//
//  Created by Austin-James Twining on 2017-04-07.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "Shader.h"

@interface Shader(){
    const GLchar* vertexShaderSource;
    const GLchar* fragmentShaderSource;
}

@end

@implementation Shader

-(id) init{
    self = [super init];
    
    if(self){
        
    }
    
    return self;
}

-(void) start{
    glUseProgram(_programID);
}
-(void) stop{
    glUseProgram(0);
}

-(void) compile: (GLchar*) vertexSource : (GLchar*) fragmentSource{
    //NSString* vertexPath = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"];
    //NSString* fragmentPath = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"];
    
    vertexShaderSource = vertexSource;
    if(!vertexShaderSource) NSLog(@"failed to load vertex shader");
    
    fragmentShaderSource = fragmentSource;
    if(!fragmentShaderSource) NSLog(@"failed to load fragment shader");
    
    GLuint vertexShader = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource(vertexShader, 1, &vertexShaderSource, NULL);
    glCompileShader(vertexShader);
    
    GLint success;
    GLchar infoLog[512];
    glGetShaderiv(vertexShader, GL_COMPILE_STATUS, &success);
    if (!success){
        glGetShaderInfoLog(vertexShader, 512, NULL, infoLog);
        NSLog(@"failed to compile vertex shader");
        NSLog(@"%s", infoLog);
    }
    
    GLuint fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(fragmentShader, 1, &fragmentShaderSource, NULL);
    glCompileShader(fragmentShader);
    
    glGetShaderiv(fragmentShader, GL_COMPILE_STATUS, &success);
    if (!success){
        glGetShaderInfoLog(fragmentShader, 512, NULL, infoLog);
        NSLog(@"failed to compile fragment shader");
        NSLog(@"%s", infoLog);
    }
    
    _programID = glCreateProgram();
    glAttachShader(_programID, vertexShader);
    glAttachShader(_programID, fragmentShader);
    
    glLinkProgram(_programID);
    
    glDeleteShader(vertexShader);
    glDeleteShader(fragmentShader);
    
    NSLog(@"Shader initialized");
}

-(void) setFloat: (const GLchar*) name : (GLfloat) value{
    glUniform1f(glGetUniformLocation(_programID, name), value);
}
-(void) setInteger: (const GLchar*) name : (GLint) value{
    glUniform1i(glGetUniformLocation(_programID, name), value);
}
-(void) setVector2f: (const GLchar*) name : (GLfloat) x : (GLfloat) y{
    glUniform2f(glGetUniformLocation(_programID, name), x, y);
}
-(void) setVector2f: (const GLchar*) name : (GLKVector2) value{
    glUniform2f(glGetUniformLocation(_programID, name), value.x, value.y);
}
-(void) setVector3f: (const GLchar*) name : (GLfloat) x : (GLfloat) y : (GLfloat) z{
    glUniform3f(glGetUniformLocation(_programID, name), x, y, z);
}
-(void) setVector3f: (const GLchar*) name : (GLKVector3) value{
    glUniform3f(glGetUniformLocation(_programID, name), value.x, value.y, value.z);
}
-(void) setVector4f: (const GLchar*) name : (GLfloat) x : (GLfloat) y : (GLfloat) z : (GLfloat) w{
    glUniform4f(glGetUniformLocation(_programID, name), x, y, z, w);
}
-(void) setVector4f: (const GLchar*) name : (GLKVector4) value{
    glUniform4f(glGetUniformLocation(_programID, name), value.x, value.y, value.z, value.w);
}
-(void) setMatrix4: (const GLchar*) name : (GLKMatrix4) value{
    glUniformMatrix4fv(glGetUniformLocation(_programID, name), 1, GL_FALSE, value.m);
}

@end
