//
//  PhysicsParser.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-07-04.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CarDef.h"

@interface PhysicsParser : NSObject <NSXMLParserDelegate>

@property CarDef* carDef;

-(CarDef*) parseXMLFile: (NSURL*) xmlPath;

-(id) init;

@end
