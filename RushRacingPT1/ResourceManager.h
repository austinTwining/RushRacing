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

#include <map>
#include <string>

static std::map<std::string, Shader*> Shaders;
static std::map<std::string, Texture*> Textures;

@interface ResourceManager : NSObject

+(Shader*) loadShader: (std::string) name : (NSString*) vertexPath : (NSString*) fragmentPath;
+(Shader*) getShader: (std::string) name;

+(Texture*) loadTexture: (std::string) name : (NSString*) path;
+(Texture*) getTexture: (std::string) name;

+(void) clear;

@end
