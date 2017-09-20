//
//  Character.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-08-02.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "Character.h"

@implementation Character

-(id) init{
    self = [super init];
    if(self){
    }
    return self;
}
-(id) initWithID: (int) ID
   xTextureCoord: (double) xTex
   yTextureCoord: (double) yTex
           width: (double) width
          height: (double) height
         xOffset: (double) xOffset
         yOffset: (double) yOffset
        xAdvance: (double) xAdvance{
    self = [super init];
    if(self){
        _ID = ID;
        _xTexCoord = xTex;
        _yTexCoord = yTex;
        _width = width;
        _height = height;
        _xOffset = xOffset;
        _yOffset = yOffset;
        _xAdvance = xAdvance;
    }
    return self;
}

@end
