//
//  Character.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-08-02.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Character : NSObject

@property (assign) int ID;
@property (assign) double xTexCoord;
@property (assign) double yTexCoord;
@property (assign) double width;
@property (assign) double height;
@property (assign) double xOffset;
@property (assign) double yOffset;
@property (assign) double xAdvance;

-(id) init;
-(id) initWithID: (int) ID
   xTextureCoord: (double) xTex
   yTextureCoord: (double) yTex
           width: (double) width
          height: (double) height
         xOffset: (double) xOffset
         yOffset: (double) yOffset
        xAdvance: (double) xAdvance;

@end
