//
//  Scene.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-05-31.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "Scene.h"

@implementation Scene

-(id) init{
    self = [super init];
    
    if(self){
        
    }
    return self;
}

//load
-(void) initialize{NSLog(@"Implement in sub class");}
//update
-(void) update{NSLog(@"Implement in sub class");}
//draw
-(void) draw : (Artist*) artist{NSLog(@"Implement in sub class");}
//unload
-(void) cleanup{NSLog(@"Implement in sub class");}

@end
