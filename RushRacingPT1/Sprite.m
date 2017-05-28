//
//  Sprite.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-04-08.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "Sprite.h"

@implementation Sprite

-(id) initWithTextureInfo: (GLKTextureInfo*) texInfo{
    self = [super init];
    
    if(self){
        _textureInfo = texInfo;
        _size.x = _textureInfo.width;
        _size.y = _textureInfo.height;
        
        GLfloat vertices[] = {
            // Positions                           // Texture Coords
            self.size.x/2,  -self.size.y/2, 0.0f,  1.0f, 0.0f, // Top Right
            self.size.x/2,  self.size.y/2,  0.0f,  1.0f, 1.0f, // Bottom Right
            -self.size.x/2, self.size.y/2,  0.0f,  0.0f, 1.0f, // Bottom Left
            -self.size.x/2, -self.size.y/2, 0.0f,  0.0f, 0.0f  // Top Left
        };
        
        GLuint indices[] = {  // Note that we start from 0!
            0, 1, 3,  // First Triangle
            1, 2, 3   // Second Triangle
        };
        
//        GLfloat vertices[] = {
//            // Positions                           // Texture Coords
//            self.size.x/2,  -self.size.y/2, 0.0f,  1.0f, 0.0f, // Top Right
//            self.size.x/2,  self.size.y/2,  0.0f,  1.0f, 1.0f, // Bottom Right
//            -self.size.x/2, self.size.y/2,  0.0f,  0.0f, 1.0f, // Bottom Left
//            -self.size.x/2, self.size.y/2,  0.0f,  0.0f, 1.0f, // Bottom Left
//            -self.size.x/2, -self.size.y/2, 0.0f,  0.0f, 0.0f, // Top Left
//            self.size.x/2,  -self.size.y/2, 0.0f,  1.0f, 0.0f  // Top Right
//        };
        
        glGenVertexArrays(1, &_VAO);
        glGenBuffers(1, &_VBO);
        glGenBuffers(1, &_EBO);
        
        glBindVertexArray(_VAO);
        
        glBindBuffer(GL_ARRAY_BUFFER, _VBO);
        glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
        
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _EBO);
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);
        
        glEnableVertexAttribArray(0);
        glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 5 * sizeof(GLfloat), (GLvoid*) 0);
        
        glEnableVertexAttribArray(1);
        glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 5 * sizeof(GLfloat), (GLvoid*)(3 * sizeof(GLfloat)));
        
        glBindVertexArray(0);
        
        glBindBuffer(GL_ARRAY_BUFFER, 0);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
    }
    
    return self;
}

@end
