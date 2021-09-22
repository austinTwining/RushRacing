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

#import "TestScene.h"
#import "MainMenuScene.h"
#import "LeakSceneOne.h"

#import "Font.h"

// screen dim in meters h: 23.4375 w: 41.6875

@interface ViewController (){
    Artist* artist;
    
    int halfScreenWidth;
    int halfScreenHeight;
}

@end

@implementation ViewController

static ResourceManager* resourceManager;
static TrackCache* tCache;
static PhysicsBodyCache* pbCache;
static int scale;
static Director* director;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setMultipleTouchEnabled:true];
    
    _context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    
    GLKView *view = (GLKView *) self.view;
    view.context = _context;
    
    [EAGLContext setCurrentContext: _context];
    
    self.preferredFramesPerSecond = 60;
    
    scale = self.view.contentScaleFactor;
    
    // allow the alpha channel on textures
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    //create resource manager
    resourceManager = [[ResourceManager alloc] init];
    
    //load in the main shader program, both vertex and fragment
    [resourceManager loadShader:@"main" vertexPath:[[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"] fragmentPath:[[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"]];
    
    //start the shader and set the projection matrix for main
    [[resourceManager getShader:@"main"] start];
    [[resourceManager getShader:@"main"] setMatrix4:"projection" :GLKMatrix4MakeOrtho(0, self.view.bounds.size.width*self.view.contentScaleFactor, self.view.bounds.size.height*self.view.contentScaleFactor, 0, -1, 1)];
    [[resourceManager getShader:@"main"] stop];
    
    //load in the debug shader program, both vertex and fragment
    [resourceManager loadShader:@"debug" vertexPath:[[NSBundle mainBundle] pathForResource:@"debug" ofType:@"vsh"] fragmentPath:[[NSBundle mainBundle] pathForResource:@"debug" ofType:@"fsh"]];
    
    //start the shader and set the projection matrix for debug
    [[resourceManager getShader:@"debug"] start];
    [[resourceManager getShader:@"debug"] setMatrix4:"projection" :GLKMatrix4MakeOrtho(0, self.view.bounds.size.width*self.view.contentScaleFactor, self.view.bounds.size.height*self.view.contentScaleFactor, 0, -1, 1)];
    [[resourceManager getShader:@"debug"] stop];
    
    //load in the font shader program, both vertex and fragment
    [resourceManager loadShader:@"font" vertexPath:[[NSBundle mainBundle] pathForResource:@"font" ofType:@"vsh"] fragmentPath:[[NSBundle mainBundle] pathForResource:@"font" ofType:@"fsh"]];
    
    //start the shader and set the projection matrix for debug
    [[resourceManager getShader:@"font"] start];
    [[resourceManager getShader:@"font"] setMatrix4:"projection" :GLKMatrix4MakeOrtho(0, self.view.bounds.size.width*self.view.contentScaleFactor, self.view.bounds.size.height*self.view.contentScaleFactor, 0, -1, 1)];
    [[resourceManager getShader:@"font"] stop];
    
    //load in the GUI shader program, both vertex and fragment
    [resourceManager loadShader:@"GUI" vertexPath:[[NSBundle mainBundle] pathForResource:@"GUI" ofType:@"vsh"] fragmentPath:[[NSBundle mainBundle] pathForResource:@"GUI" ofType:@"fsh"]];
    
    //start the shader and set the projection matrix for debug
    [[resourceManager getShader:@"GUI"] start];
    [[resourceManager getShader:@"GUI"] setMatrix4:"projection" :GLKMatrix4MakeOrtho(0, self.view.bounds.size.width*self.view.contentScaleFactor, self.view.bounds.size.height*self.view.contentScaleFactor, 0, -1, 1)];
    [[resourceManager getShader:@"GUI"] stop];
    
    
    halfScreenWidth = (self.view.bounds.size.width*self.view.contentScaleFactor)/2;
    halfScreenHeight = (self.view.bounds.size.height*self.view.contentScaleFactor)/2;
    
    NSLog(@"X: %f | Y: %f", self.view.bounds.size.width*self.view.contentScaleFactor, self.view.bounds.size.height*self.view.contentScaleFactor);
    
    //initialize the artist class to handle all the drawing giving the main shader and the half
    //screen dimensions
    artist = [[Artist alloc] initWithShader: [resourceManager getShader:@"main"] halfScreenWidth:halfScreenWidth halfScreenHeight:halfScreenHeight];
    director = [[Director alloc] init];
    
    pbCache = [[PhysicsBodyCache alloc] init];
    
    //track cache
    tCache = [[TrackCache alloc] init];
    [tCache parseTrack:@"Track"
                  path:[[NSBundle mainBundle] URLForResource:@"Track" withExtension:@"tmx"]];
    
    //create the initial scene *TEMPORARY*
    //Scene* s = [[LeakSceneOne alloc] initWithResourceManager:resourceManager];
    //add the scene to the director
    //[director addScene:s withName:@"One" shouldBeCurrent:true];
    //create the initial scene *TEMPORARY*
    Scene* s = [[MainMenuScene alloc] init];
    //add the scene to the director
    [director addScene:s withName:@"MainMenu" shouldBeCurrent:true];
    
    s = [[TestScene alloc] init];
    [director addScene:s withName:@"testScene" shouldBeCurrent:false];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [resourceManager clear];
    [artist cleanup];
    [director cleanup];
}

-(void) update{
    [director update];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClearColor(0.8f, 0.8f, 0.8f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    
    [director draw:artist];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [director onTouchBegan:touches];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [director onTouchMoved:touches];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [director onTouchEnded:touches];
}

+(ResourceManager*) getResourceManager{
    return resourceManager;
}
+(PhysicsBodyCache*) getPhysicsBodyCache{
    return pbCache;
}
+(TrackCache*) getTrackCache{
    return tCache;
}
+(Director*) getDirector{
    return director;
}
+(int) getScale{
    return scale;
}

@end

@implementation Vec2

-(id)init{
    self = [super init];
    if(self){}
    return self;
}

@end
