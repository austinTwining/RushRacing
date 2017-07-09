//
//  Director.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-05-01.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "Director.h"

@implementation Director

-(id) init{
    self = [super init];
    if(self){
        _Scenes = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void) setScene : (NSString*) name{
    _currentScene = name;
    [_Scenes[_currentScene] initialize];
}

-(void) addScene:(Scene*) scene withName: (NSString*) name shouldBeCurrent: (GLboolean) setCurrent{
    _Scenes[name] = scene;
    if(setCurrent) [self setScene:name];
}
-(void) deleteScene : (NSString*) name{
    [_Scenes[name] cleanup];
    [_Scenes removeObjectForKey:name];
}

-(void) update{
    [_Scenes[_currentScene] update];
}
-(void) draw : (Artist*) artist{
    [_Scenes[_currentScene] draw:artist];
}

-(void) cleanup{
    for(NSString* key in _Scenes){
        [[_Scenes objectForKey:key] cleanup];
    }
}

//handle input
-(void) onTouchBegan: (NSSet*) touch{
    [_Scenes
     [_currentScene] onTouchBegan:touch];
}
-(void) onTouchMoved: (NSSet*) touch{
    [_Scenes[_currentScene] onTouchMoved:touch];
}
-(void) onTouchEnded: (NSSet*) touch{
    [_Scenes[_currentScene] onTouchEnded:touch];
}

@end
