//
//  Artist.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-04-08.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "Artist.h"

@interface Artist(){
    GLuint VAO;
}

@end

@implementation Artist

-(id) initWithShader:(Shader *)shader{
    self = [super init];
    
    if(self){
        _shader = shader;
        [self initDrawData];
    }
    
    return self;
}

-(id) initWithShader:(Shader *)shader halfScreenWidth:(int)hWidth halfScreenHeight:(int)hHeight{
    self = [super init];
    
    if(self){
        _shader = shader;
        _halfScreenWidth = hWidth;
        _halfScreenHeight = hHeight;
        [self initDrawData];
    }
    
    return self;
}

-(void) initDrawData{
    GLuint VBO;
    GLuint EBO;
    GLfloat vertices[] = {
        // Positions       // Texture Coords
        1.0f, 0.0f, 0.0f,  1.0f, 0.0f, // Top Right
        1.0f, 1.0f, 0.0f,  1.0f, 1.0f, // Bottom Right
        0.0f, 1.0f, 0.0f,  0.0f, 1.0f, // Bottom Left
        0.0f, 0.0f, 0.0f,  0.0f, 0.0f  // Top Left
    };
    
    GLuint indices[] = {  // Note that we start from 0!
        0, 1, 3,  // First Triangle
        1, 2, 3   // Second Triangle
    };
    
    glGenVertexArrays(1, &VAO);
    glGenBuffers(1, &VBO);
    glGenBuffers(1, &EBO);
    
    glBindVertexArray(VAO);
    
    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
    
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 5 * sizeof(GLfloat), (GLvoid*) 0);
    
    glEnableVertexAttribArray(1);
    glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 5 * sizeof(GLfloat), (GLvoid*)(3 * sizeof(GLfloat)));
    
    glBindVertexArray(0);
    
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
}

-(void) updateCameraPosition: (GLfloat) x : (GLfloat) y{
    _cameraPosition = GLKVector2Make(x - _halfScreenWidth, y - _halfScreenHeight);
}

-(void) drawTexture:(Texture *)tex position: (GLKVector2) position size: (GLKVector2) size rotation: (GLfloat) rotation{
    [_shader start];
    GLKMatrix4 model;
    model = GLKMatrix4Translate(GLKMatrix4Identity, position.x, position.y, 0);
    model = GLKMatrix4Rotate(model, rotation, 0, 0, 1);
    model = GLKMatrix4Translate(model, -0.5f * size.x, -0.5f * size.y, 0);
    model = GLKMatrix4Scale(model, size.x, size.y, 1);
    
    GLKMatrix4 view = GLKMatrix4Translate(GLKMatrix4Identity, -_cameraPosition.x, -_cameraPosition.y, 0);
    
    [_shader setMatrix4: "model" :model];
    [_shader setMatrix4: "view" :view];
    
    [tex bind];
    glActiveTexture(GL_TEXTURE0);
    glBindVertexArray(VAO);
    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0);
    glBindVertexArray(0);
    [_shader stop];
}

@end
