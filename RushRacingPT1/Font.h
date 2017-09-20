//
//  Font.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-08-01.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Character.h"
#import "ViewController.h"

@interface Font : NSObject

@property (strong, nonatomic) NSMutableDictionary* characters;

@property (assign) double atlasSize;
@property (assign) NSString* name;

-(id) initWithPath: (NSString*) path;

@end
