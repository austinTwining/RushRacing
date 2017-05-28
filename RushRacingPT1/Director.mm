//
//  Director.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-05-01.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "Director.h"

enum
{
    MENU_SCENE,
    PLAY_SCENE,
    NUM_SCENES
};


@interface Director (){
    Scene* scenes[NUM_SCENES];
    int currentScene;
}

@end

@implementation Director

-(id) init{
    self = [super init];
    
    if(self){
    }
    
    return self;
}

-(void) update{
    [scenes[currentScene] update];
}
-(void) draw : (Artist*) artist{
    [scenes[currentScene] draw:artist];
}

@end
