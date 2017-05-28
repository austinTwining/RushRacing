//
//  ResourceManager.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-05-23.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "ResourceManager.h"

@implementation ResourceManager

+(Shader*) loadShader:(std::string) name : (NSString *)vertexPath : (NSString *)fragmentPath{
    Shader* shader = [[Shader alloc] init];
    
    [shader compile:(GLchar *)[[NSString stringWithContentsOfFile:vertexPath encoding:NSUTF8StringEncoding error:nil] UTF8String] :(GLchar *)[[NSString stringWithContentsOfFile:fragmentPath encoding:NSUTF8StringEncoding error:nil] UTF8String]];
    
    Shaders[name] = shader;
    
    return shader;
}

+(Shader*) getShader: (std::string) name{ return Shaders[name]; }

+(Texture*) loadTexture: (std::string) name : (NSString*) path{
    CGImageRef imageReference = [[UIImage imageNamed:path] CGImage];
    
    GLKTextureInfo* textureInfo = [GLKTextureLoader textureWithCGImage:imageReference options:nil error:NULL];
    
    Texture* texture = [[Texture alloc] init:textureInfo];
    
    Textures[name] = texture;
    
    return texture;
}

+(Texture*) getTexture: (std::string) name{ return Textures[name]; }

+(void) clear{
    /*for(Shader* s in Textures){
        glDeleteProgram(s.programID);
    }
    for(Texture* t in Shaders){
        GLuint name = [t getTextureInfo].name;
        glDeleteTextures(1, &name);
    }*/
}

@end
