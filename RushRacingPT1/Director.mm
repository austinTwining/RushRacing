//
//  Director.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-05-01.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "Director.h"

@implementation Director

static NSMutableDictionary* Scenes;
static NSString* currentScene;

+(void) setCurrentScene : (NSString*) name{
    currentScene = name;
    [Scenes[currentScene] initialize];
}

+(void) addScene:(Scene*) scene withName: (NSString*) name shouldBeCurrent: (GLboolean) setCurrent{
    if(!Scenes) Scenes = [[NSMutableDictionary alloc] init];
    Scenes[name] = scene;
    if(setCurrent) [self setCurrentScene:name];
}
+(void) deleteScene : (NSString*) name{
    [Scenes[name] cleanup];
    [Scenes removeObjectForKey:name];
}

+(void) update{
    [Scenes[currentScene] update];
}
+(void) draw : (Artist*) artist{
    [Scenes[currentScene] draw:artist];
}

@end
