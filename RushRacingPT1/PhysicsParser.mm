//
//  PhysicsParser.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-07-04.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//
#import "PhysicsParser.h"

#import "Artist.h"

@interface PhysicsParser(){
    b2Shape* shape;
    b2Vec2* vertices;
}

@property NSXMLParser* parser;
@property NSString* element;

//carDef properties
@property b2BodyDef bodyDef;
@property b2FixtureDef fixDef;

@property b2CircleShape cShape;
@property b2PolygonShape pShape;

@end

@implementation PhysicsParser

-(id) init{
    self = [super init];
    if(self){
        _carDef = [[CarDef alloc] init];
    }
    
    return self;
}

-(CarDef*) parseXMLFile: (NSURL*) xmlPath{
    self.parser = [[NSXMLParser alloc] initWithContentsOfURL:xmlPath];
    self.parser.delegate = self;
    [self.parser parse];
    return _carDef;
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    
    self.element = elementName;
    
    if ([self.element isEqualToString:@"circle"]) {
        float radius = attributeDict[@"r"].floatValue / PTM;
        float x = attributeDict[@"x"].floatValue / PTM;
        float y = attributeDict[@"y"].floatValue / PTM;
        _cShape.m_p = b2Vec2(x, y);
        _cShape.m_radius = radius;
    }
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string {
    
    if ([self.element isEqualToString:@"density"]) {
        _fixDef.density = string.floatValue;
    }
    else if ([self.element isEqualToString:@"friction"]) {
        _fixDef.friction = string.floatValue;
    }
    else if ([self.element isEqualToString:@"restitution"]) {
        _fixDef.restitution = string.floatValue;
    }
    else if ([self.element isEqualToString:@"fixture_type"]) {
        if([string isEqualToString:@"CIRCLE"]){
            shape = &(_cShape);
        }else if([string isEqualToString:@"POLYGON"]){
            shape = &(_pShape);
        }
    }else if([self.element isEqualToString:@"polygon"]){
        NSArray *strs = [string componentsSeparatedByString:@","];
        b2Vec2 varr[[strs count]/2];
        for(int i = 0; i < [strs count]; i+=2){
            NSString* x = strs[i];
            NSString* y = strs[i+1];
            b2Vec2 cv(x.floatValue/PTM, y.floatValue/PTM);
            varr[i/2] = cv;
        }
        vertices = varr;
        _pShape.Set(vertices, [strs count]/2);
    }
    
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"fixture"]) {
        _fixDef.shape = shape;
        _carDef.fixDefs.push_back(_fixDef);
    }
}

@end
