//
//  ViewController.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-04-08.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

#import "Artist.h"
#import "Director.h"
#import "ResourceManager.h"

@interface ViewController : GLKViewController

@property (strong, nonatomic) EAGLContext *context;
@property (strong, nonatomic) GLKBaseEffect *effect;

+(ResourceManager*) getResourceManager;

@end

