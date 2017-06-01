//
//  ResourceManager.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-05-23.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "ResourceManager.h"

@implementation ResourceManager

static NSMutableDictionary* Shaders;
static NSMutableDictionary* Textures;

+(Shader*) loadShader: (NSString*) name vertexPath: (NSString*) vertexPath fragmentPath: (NSString*) fragmentPath{
    Shader* shader = [[Shader alloc] init];
    
    [shader compile:(GLchar *)[[NSString stringWithContentsOfFile:vertexPath encoding:NSUTF8StringEncoding error:nil] UTF8String] :(GLchar *)[[NSString stringWithContentsOfFile:fragmentPath encoding:NSUTF8StringEncoding error:nil] UTF8String]];
    
    if(!Shaders) Shaders = [[NSMutableDictionary alloc] init];
    
    //[Shaders setValue:shader forKey:name];
    Shaders[name] = shader;

    return shader;
}

+(Shader*) getShader: (NSString*) name{ return Shaders[name]; }

+(Texture*) loadTexture: (NSString*) name path: (NSString*) path{
    CGImageRef imageReference = [[UIImage imageNamed:path] CGImage];
    
    GLKTextureInfo* textureInfo = [GLKTextureLoader textureWithCGImage:imageReference options:nil error:NULL];
    
    Texture* texture = [[Texture alloc] init:textureInfo];
    
    if(!Textures) Textures = [[NSMutableDictionary alloc] init];
    
    //[Textures setValue:texture forKey:name];
    Textures[name] = texture;
    
    return texture;
}

+(Texture*) getTexture: (NSString*) name{ return Textures[name]; }

+(void) clear{
    
}

@end
