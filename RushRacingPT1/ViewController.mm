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

#define PTM 32

// screen dim in meters h: 23.4375 w: 41.6875

@interface ViewController (){
    
    Artist* artist;
    
    Director* director;
    
    b2World* m_world;
    
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
    
    [ResourceManager loadShader:"main" :[[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"] :[[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"]];
    
    [[ResourceManager getShader:"main"] start];
    
    [[ResourceManager getShader:"main"] setMatrix4:"projection" :GLKMatrix4MakeOrtho(0, self.view.bounds.size.width*self.view.contentScaleFactor, self.view.bounds.size.height*self.view.contentScaleFactor, 0, -1, 1)];
    
    [[ResourceManager getShader:"main"] stop];
    
    halfScreenWidth = (self.view.bounds.size.width*self.view.contentScaleFactor)/2;
    halfScreenHeight = (self.view.bounds.size.height*self.view.contentScaleFactor)/2;
    
    NSLog(@"X: %f | Y: %f", self.view.bounds.size.width*self.view.contentScaleFactor, self.view.bounds.size.height*self.view.contentScaleFactor);
    
    artist = [[Artist alloc] initWithShader: [ResourceManager getShader:"main"]];
    
    [ResourceManager loadTexture:"test" :@"Z9-Proton-Orange.png"];
    
    m_world = new b2World(b2Vec2(0,0));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    delete m_world;
}

-(void) update{
    float32 timeStep = 1.0 / (float) self.preferredFramesPerSecond;      //the length of time passed to simulate (seconds)
    int32 velocityIterations = 8;   //how strongly to correct velocity
    int32 positionIterations = 3;   //how strongly to correct position
    
    [artist updateCameraPosition:GLKVector2Make(0 - halfScreenWidth, 0 - halfScreenHeight)];
    
    m_world->Step( timeStep, velocityIterations, positionIterations);
    //NSLog(@"FPS: %ld", (long)self.framesPerSecond);
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    
    [artist drawTexture:[ResourceManager getTexture:"test"] :GLKVector2Make(0, 0) :GLKVector2Make([ResourceManager getTexture:"test"].Width, [ResourceManager getTexture:"test"].Height) :0];
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
