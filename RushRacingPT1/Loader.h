//
//  Loader.h
//  RushRacing
//
//  Created by Austin-James Twining on 2017-04-05.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

typedef struct {
    GLuint VAO;
    GLuint VBO;
    GLuint EBO;
} Model;

@interface Loader : NSObject

+(Model) loadToVAO: (GLfloat*) vertices : (GLuint*) indices;
+(Model) loadToVAO: (GLfloat*) vertices;

+(GLuint) loadToVAOID: (GLfloat*) vertices : (GLuint*) indices;
+(GLuint) loadToVAOID: (GLfloat*) vertices;

+(GLKTextureInfo*) loadImage: (NSString*) path;

@end
