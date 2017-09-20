//
//  Director.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-05-01.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Artist.h"
#import "Scene.h"

@class Scene;

@interface Director : NSObject

@property (strong, nonatomic) NSMutableDictionary* Scenes;
@property NSString* currentScene;

@property (assign) BOOL paused;

-(id) init;

-(void) setScene : (NSString*) name;

-(void) addScene : (Scene*) scene withName: (NSString*) name shouldBeCurrent: (GLboolean) setCurrent;
-(void) deleteScene : (NSString*) name;

-(void) update;
-(void) draw : (Artist*) artist;

-(void) cleanup;

//handle input
-(void) onTouchBegan: (NSSet*) touch;
-(void) onTouchMoved: (NSSet*) touch;
-(void) onTouchEnded: (NSSet*) touch;

@end
