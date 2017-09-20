//
//  Artist.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-04-08.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "Artist.h"
#import "ViewController.h"

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

-(void) updateCameraPosition: (GLfloat) x : (GLfloat) y rotation: (GLfloat) r{
    _cameraPosition.x = x - _halfScreenWidth;
    _cameraPosition.y = y - _halfScreenHeight;
    _cameraPosition.z = r;
}

-(void) updateSmoothCameraPosition: (GLfloat) x : (GLfloat) y rotation: (GLfloat) r{
    _targetCameraPosition.x = x - _halfScreenWidth;
    _targetCameraPosition.y = y - _halfScreenHeight;
    _targetCameraPosition.z = r;
}

-(void) updateSmoothCamera{
    _cameraPosition.x = _targetCameraPosition.x;
    _cameraPosition.y = _targetCameraPosition.y;
    _cameraPosition.z = GLKVector2Lerp(GLKVector2Make(_cameraPosition.z, 0), GLKVector2Make(_targetCameraPosition.z, 0), 0.05).x;
}

-(void) drawText: (NSString*) text withFont: (Font*) font withColour: (GLKVector3) colour atPosition: (GLKVector2) position size: (float) size{
    [[[ViewController getResourceManager] getShader:@"font"] start];
    NSMutableArray* letters = [[NSMutableArray alloc] init];
    for(int t = 0; t < text.length; t++){
        NSString *tmp_str = [text substringWithRange:NSMakeRange(t, 1)];
        [letters addObject:[tmp_str stringByRemovingPercentEncoding]];
    }
    
    GLfloat scale = font.atlasSize * size;
    
    float xpos = position.x;
    float ypos = position.y;
    
    for(NSString* letter in letters){
        Character* ch = [font.characters valueForKey:letter];
        
        float x = xpos + ch.xOffset * scale;
        float y = ypos + ch.yOffset * scale;
        
        if([letter isEqualToString:@" "]){
            xpos += ch.xAdvance * scale * 0.5;
            continue;
        }
        
        GLfloat texX = ch.xTexCoord;
        GLfloat texY = ch.yTexCoord;
        GLfloat texWidth = ch.width;
        GLfloat texHeight = ch.height;
        
        GLKMatrix4 model;
        model = GLKMatrix4Translate(GLKMatrix4Identity, x, y, 0);
        model = GLKMatrix4Scale(model, ch.width * scale, ch.height * scale, 1);
        
        GLKMatrix4 texModel;
        texModel = GLKMatrix4Translate(GLKMatrix4Identity, texX, texY, 0);
        texModel = GLKMatrix4Scale(texModel, texWidth, texHeight, 1);
        
        [[[ViewController getResourceManager] getShader:@"font"] setMatrix4:"tex_model" :texModel];
        
        [[[ViewController getResourceManager] getShader:@"font"] setMatrix4:"model" :model];
        [[[ViewController getResourceManager] getShader:@"font"] setVector3f:"colour" :colour];
        
        Texture* tex = [[ViewController getResourceManager] getTexture:font.name];
        
        [tex bind];
        glActiveTexture(GL_TEXTURE0);
        glBindVertexArray(VAO);
        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0);
        glBindVertexArray(0);
        
        xpos += ch.xAdvance * scale * 0.75;
    }
    
    [[[ViewController getResourceManager] getShader:@"font"] stop];
}

-(void) drawGUITexture: (Texture*) tex position: (GLKVector2) position size: (GLKVector2) size rotation: (GLfloat) rotation{
    [[[ViewController getResourceManager] getShader:@"GUI"] start];
    
    GLKMatrix4 model;
    model = GLKMatrix4Translate(GLKMatrix4Identity, position.x, position.y, 0);
    model = GLKMatrix4Rotate(model, rotation, 0, 0, 1);
    model = GLKMatrix4Translate(model, -0.5f * size.x, -0.5f * size.y, 0);
    model = GLKMatrix4Scale(model, size.x, size.y, 1);
    
    [[[ViewController getResourceManager] getShader:@"GUI"] setMatrix4: "model" :model];
    
    [tex bind];
    glActiveTexture(GL_TEXTURE0);
    glBindVertexArray(VAO);
    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0);
    glBindVertexArray(0);
    
    [[[ViewController getResourceManager] getShader:@"GUI"] start];
}

-(void) drawTexture:(Texture *)tex position: (GLKVector2) position size: (GLKVector2) size rotation: (GLfloat) rotation{
    [_shader start];
    GLKMatrix4 model;
    model = GLKMatrix4Translate(GLKMatrix4Identity, position.x, position.y, 0);
    model = GLKMatrix4Rotate(model, rotation, 0, 0, 1);
    model = GLKMatrix4Translate(model, -0.5f * size.x, -0.5f * size.y, 0);
    model = GLKMatrix4Scale(model, size.x, size.y, 1);
    
    GLKMatrix4 view = GLKMatrix4Translate(GLKMatrix4Identity, _halfScreenWidth, _halfScreenHeight, 0);
    view = GLKMatrix4Rotate(view, -_cameraPosition.z, 0, 0, 1);
    view = GLKMatrix4Translate(view, -_halfScreenWidth, -_halfScreenHeight, 0);
    view = GLKMatrix4Translate(view, -_cameraPosition.x, -_cameraPosition.y, 0);
    
    [_shader setMatrix4: "model" :model];
    [_shader setMatrix4: "view" :view];
    
    [tex bind];
    glActiveTexture(GL_TEXTURE0);
    glBindVertexArray(VAO);
    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0);
    glBindVertexArray(0);
    [_shader stop];
}

-(void) cleanup{
    glDeleteVertexArrays(1, &VAO);
}
@end
