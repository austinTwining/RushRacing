//
//  Button.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-08-04.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import "Artist.h"

@interface Button : NSObject

@property (strong, nonatomic) Texture* mainTexture;
@property (strong, nonatomic) Texture* secondaryTexture;

@property (assign) NSString* text;
@property (assign) GLKVector2 textDimensions;
@property (assign) Font* font;
@property (assign) GLKVector3 colour;
@property (assign) float scale;

@property (assign) float x;
@property (assign) float y;
@property (assign) float width;
@property (assign) float height;

@property (assign) BOOL isPressed;

-(id) initWithMainTexture: (Texture*) texture;
-(id) initWithMainTexture:(Texture *)main withSecondary: (Texture*) secondary;

-(void) setText:(NSString *)text withFont: (Font*) font withColour: (GLKVector3) colour withSize: (float) size;

-(BOOL) checkInput: (CGPoint) point;
-(void) draw: (Artist*) artist;

-(void) destroy;

@end
