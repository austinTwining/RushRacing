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
    
    [Shaders setObject:shader forKey:name];

    return shader;
}

+(Shader*) getShader: (NSString*) name{ return Shaders[name]; }

+(Texture*) loadTexture: (NSString*) name path: (NSString*) path{
    CGImageRef imageReference = [[UIImage imageNamed:path] CGImage];
    NSError* error;
    
    NSLog(@"GL Error = %u", glGetError());
    GLKTextureInfo* textureInfo = [GLKTextureLoader textureWithCGImage:imageReference
                                                               options:nil
                                                                 error:&error];
    if(error) NSLog(@"Error loading texture: %@", [error localizedDescription]);
    
    NSLog(@"imageRef: %p", imageReference);
    
    
    Texture* texture = [[Texture alloc] init:textureInfo];
    
    NSLog(@"width: %i height: %i data: %p", [texture Width], [texture Height], [texture getTextureInfo]);
    
    if(!Textures) Textures = [[NSMutableDictionary alloc] init];
    
    [Textures setObject:texture forKey:name];
    NSLog(@"adding key %@ to dictionary with pointer %p", name, Textures);
    NSLog( @"%@", Textures );
    
    return texture;
}

+(Texture*) getTexture: (NSString*) name{ return Textures[name]; }

+(void) clear{
    
}

@end
