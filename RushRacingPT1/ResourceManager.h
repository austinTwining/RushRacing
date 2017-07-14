//
//  ResourceManager.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-05-23.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Shader.h"
#import "Texture.h"

@interface ResourceManager : NSObject

@property (strong, nonatomic) NSMutableDictionary* Shaders;
@property (strong, nonatomic) NSMutableDictionary* Textures;

-(id) init;

-(Shader*) loadShader: (NSString*) name vertexPath: (NSString*) vertexPath fragmentPath: (NSString*) fragmentPath;
-(Shader*) getShader: (NSString*) name;

-(Texture*) loadTexture: (NSString*) name path: (NSString*) path;
-(void) deleteTexture: (NSString*) name;
-(Texture*) getTexture: (NSString*) name;

-(void) clear;

@end
