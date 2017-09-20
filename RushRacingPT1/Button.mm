//
//  Button.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-08-04.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "Button.h"

@implementation Button

-(id) initWithMainTexture: (Texture*) texture{
    self = [super init];
    if(self){
        _mainTexture = texture;
        _width = texture.Width;
        _height = texture.Height;
    }
    return self;
}
-(id) initWithMainTexture:(Texture *)main withSecondary: (Texture*) secondary{
    self = [super init];
    if(self){
        _mainTexture = main;
        _width = main.Width;
        _height = main.Height;
        _secondaryTexture = secondary;
    }
    return self;
}

-(void) setText:(NSString *)text withFont: (Font*) font withColour: (GLKVector3) colour withSize: (float) size{
    _text = text;
    _font = font;
    _colour = colour;
    _scale = size;
    _textDimensions = [self getTextDimensions:text:font:size];
}
-(GLKVector2) getTextDimensions:(NSString*) text : (Font*) font : (float) size{
    NSMutableArray* letters = [[NSMutableArray alloc] init];
    for(int t = 0; t < text.length; t++){
        NSString *tmp_str = [text substringWithRange:NSMakeRange(t, 1)];
        [letters addObject:[tmp_str stringByRemovingPercentEncoding]];
    }
    
    GLfloat scale = font.atlasSize * size;
    
    float width = 0;
    float height = 0;
    
    for(NSString* letter in letters){
        Character* ch = [font.characters valueForKey:letter];
        
        if([letter isEqualToString:@" "]){
            width += ch.xAdvance * scale * 0.5;
            continue;
        }
        
        if((ch.height * scale) > height) height = ch.height * scale;

        width += ch.width * scale;
        
        width += ch.xAdvance * scale * 0.75;
    }
    return GLKVector2Make(width, height);
}

-(BOOL) checkInput: (CGPoint) point{
    float left = _x - (_width/2);
    float right = _x + (_width/2);
    float top = _y - (_height/2);
    float bottom = _y + (_height/2);
    if((point.x > left && point.x < right) && (point.y > top && point.y < bottom)){
        _isPressed = true;
        return true;
    }else return false;
}
-(void) draw: (Artist*) artist{
    if(_secondaryTexture != nil){
        if(_isPressed)[artist drawGUITexture:_secondaryTexture position:GLKVector2Make(_x, _y) size:GLKVector2Make(_width, _height) rotation:0];
        else [artist drawGUITexture:_mainTexture position:GLKVector2Make(_x, _y) size:GLKVector2Make(_width, _height) rotation:0];
    }else [artist drawGUITexture:_mainTexture position:GLKVector2Make(_x, _y) size:GLKVector2Make(_width, _height) rotation:0];
    
    if(_text){
        GLKVector2 position;
        if(_isPressed){
            position.x = _x - (_textDimensions.x/5);
            position.y = _y - (_textDimensions.y * 0.7);
        }else{
            position.x = _x - (_textDimensions.x/5);
            position.y = _y - (_textDimensions.y * 0.8);
        }
        [artist drawText:_text withFont:_font withColour:_colour atPosition:position size:_scale];
    }
}

-(void) destroy{
    
}

@end
