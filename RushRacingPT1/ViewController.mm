//
//  ViewController.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-04-08.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//
//
#include <Box2D/Box2D.h>


#import "ViewController.h"

#import "Artist.h"
#import "Director.h"
#import "ResourceManager.h"

#import "TestScene.h"

// screen dim in meters h: 23.4375 w: 41.6875

@interface ViewController (){
    Artist* artist;
    
    int halfScreenWidth;
    int halfScreenHeight;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setMultipleTouchEnabled:true];
    
    _context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    
    GLKView *view = (GLKView *) self.view;
    view.context = _context;
    
    [EAGLContext setCurrentContext: _context];
    
    self.preferredFramesPerSecond = 60;
    
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    [ResourceManager loadShader:@"main" vertexPath:[[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"] fragmentPath:[[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"]];
    
    [[ResourceManager getShader:@"main"] start];
    
    [[ResourceManager getShader:@"main"] setMatrix4:"projection" :GLKMatrix4MakeOrtho(0, self.view.bounds.size.width*self.view.contentScaleFactor, self.view.bounds.size.height*self.view.contentScaleFactor, 0, -1, 1)];
    
    [[ResourceManager getShader:@"main"] stop];
    
    halfScreenWidth = (self.view.bounds.size.width*self.view.contentScaleFactor)/2;
    halfScreenHeight = (self.view.bounds.size.height*self.view.contentScaleFactor)/2;
    
    NSLog(@"X: %f | Y: %f", self.view.bounds.size.width*self.view.contentScaleFactor, self.view.bounds.size.height*self.view.contentScaleFactor);
    
    artist = [[Artist alloc] initWithShader: [ResourceManager getShader:@"main"] halfScreenWidth:halfScreenWidth halfScreenHeight:halfScreenHeight];
    
    Scene* s = [[TestScene alloc] init];
    
    [Director addScene:s withName:@"testScene" shouldBeCurrent:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) update{
    [Director update];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    
    [Director draw:artist];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /*// Enumerate over all the touches and draw a red dot on the screen where the touches were
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        // Get a single touch and it's location
        UITouch *touch = obj;
        CGPoint touchPoint = [touch locationInView:self.view];
        
        if(touchPoint.x < 333) car.direction = LEFT;
        else if(touchPoint.x > 333) car.direction = RIGHT;
        else car.direction = STRAIGHT;
        
        NSLog(@"X: %f | Y: %f", touchPoint.x, touchPoint.y);
    }];*/
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //car.direction = STRAIGHT;
}

@end
