//
//  ResourceManager.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-05-23.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "ResourceManager.h"

@implementation ResourceManager

-(id) init{
    self = [super init];
    if(self){
        _Shaders = [[NSMutableDictionary alloc] init];
        _Textures = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(Shader*) loadShader: (NSString*) name vertexPath: (NSString*) vertexPath fragmentPath: (NSString*) fragmentPath{
    Shader* shader = [[Shader alloc] init];
    
    [shader compile:(GLchar *)[[NSString stringWithContentsOfFile:vertexPath encoding:NSUTF8StringEncoding error:nil] UTF8String] :(GLchar *)[[NSString stringWithContentsOfFile:fragmentPath encoding:NSUTF8StringEncoding error:nil] UTF8String]];
    
    [_Shaders setObject:shader forKey:name];

    return shader;
}

-(Shader*) getShader: (NSString*) name{ return _Shaders[name]; }

-(Texture*) loadTexture: (NSString*) name path: (NSString*) path{
    CGImageRef imageReference = [[UIImage imageNamed:path] CGImage];
    NSError* error;
    
    NSLog(@"GL Error = %u", glGetError());
    GLKTextureInfo* textureInfo = [GLKTextureLoader textureWithCGImage:imageReference
                                                               options:nil
                                                                 error:&error];
    
    
    if(error) NSLog(@"Error loading texture: %@", [error localizedDescription]);
    
    //NSLog(@"imageRef: %p", imageReference);
    
    
    Texture* texture = [[Texture alloc] init:textureInfo];
    
    //NSLog(@"width: %i height: %i data: %p", [texture Width], [texture Height], [texture getTextureInfo]);
    
    [_Textures setObject:texture forKey:name];
    //NSLog(@"adding key %@ to dictionary with pointer %p", name, _Textures);
    //NSLog( @"%@", _Textures );
    
    return texture;
}

-(void) deleteTexture: (NSString*) name{
    Texture* t = [_Textures objectForKey:name];
    GLuint key = t.textureInfo.name;
    glDeleteTextures(1, &key);
    [_Textures removeObjectForKey:name];
}

-(Texture*) getTexture: (NSString*) name{ return _Textures[name]; }

-(void) clear{
    for(NSString* key in _Shaders){
        Shader* s = [_Shaders objectForKey:key];
        glDeleteShader(s.programID);
    }
    for(NSString* key in _Textures){
        [self deleteTexture:key];
    }
}

@end
