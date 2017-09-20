//
//  LeakSceneTwo.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-08-08.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "LeakSceneTwo.h"

@implementation LeakSceneTwo

//load
-(void) initialize{
    NSLog(@"Two Initialize!");
    [[ViewController getResourceManager] loadTexture:@"Logo" path:@"Logo.png"];
}

//update
-(void) update{
    
}
//draw
-(void) draw : (Artist*) artist{
    
}

//handle input
-(void) onTouchBegan: (NSSet*) touch{
}
-(void) onTouchMoved: (NSSet*) touch{
    
}
-(void) onTouchEnded: (NSSet*) touch{
    
}

//unload
-(void) cleanup{
    [[ViewController getResourceManager] deleteTexture:@"Logo"];
    NSLog(@"Two Clean Up!");
}

@end
