//
//  PhysicsBodyCache.m
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-07-07.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#import "PhysicsBodyCache.h"

@interface PhysicsBodyCache(){
    float mRatio;
}
@property NSString* element;
@property NSXMLParser* parser;

@property BodyTemplate* currentBody;
@property FixtureTemplate* currentFixture;
@property NSMutableArray* currentPolygonVertices;
@property NSMutableArray* currentFixtures;
@property NSMutableArray* currentPolygons;
@property NSMutableArray* currentCircles;
@end

@implementation PhysicsBodyCache

-(id) init{
    self = [super init];
    if(self){
        mRatio = PTM;
        
        _bodies = [[NSMutableDictionary alloc] init];
        
        _currentPolygonVertices = [[NSMutableArray alloc] init];
        _currentFixtures = [[NSMutableArray alloc] init];
        _currentPolygons = [[NSMutableArray alloc] init];
        _currentCircles = [[NSMutableArray alloc] init];
    }
    return self;
}
-(id) initWithRatio : (float) aRatio{
    self = [super init];
    if(self){
        mRatio = aRatio;
        
        _bodies = [[NSMutableDictionary alloc] init];
        
        _currentPolygonVertices = [[NSMutableArray alloc] init];
        _currentFixtures = [[NSMutableArray alloc] init];
        _currentPolygons = [[NSMutableArray alloc] init];
        _currentCircles = [[NSMutableArray alloc] init];
    }
    return self;
}

-(b2Body*) createBody : (NSString*) name withWorld : (b2World*) world{
    BodyTemplate* bodyTemplate = [_bodies valueForKey:name];
    
    b2BodyDef bodyDef;
    bodyDef.type = bodyTemplate.isDynamic ? b2_dynamicBody : b2_staticBody;
    bodyDef.position = b2Vec2(0, 0);
    
    b2Body* body = world->CreateBody(&bodyDef);
    
    for(FixtureTemplate* ft in bodyTemplate.fixtureTemplates){
        for(CircleTemplate* ct in ft.circles){
            b2CircleShape cShape;
            b2FixtureDef fixDef;
            
            cShape.m_p = b2Vec2(ct.x / mRatio, ct.y / mRatio);
            cShape.m_radius = ct.radius / mRatio;
            
            fixDef.shape = &cShape;
            fixDef.density = ft.density;
            fixDef.friction = ft.friction;
            fixDef.restitution = ft.restitution;
            
            body->CreateFixture(&fixDef);
        }
        for(PolygonTemplate* pt in ft.polygons){
            b2PolygonShape pShape;
            b2FixtureDef fixDef;
            
            b2Vec2 vertices[pt.vertices.count];
            
            for(int i = 0; i < pt.vertices.count; i++){
                Vector2f* v = [pt.vertices objectAtIndex:i];
                vertices[i] = b2Vec2(v.x / mRatio, v.y / mRatio);
            }
            
            pShape.Set(vertices, pt.vertices.count);
            
            fixDef.shape = &pShape;
            fixDef.density = ft.density;
            fixDef.friction = ft.friction;
            fixDef.restitution = ft.restitution;
            
            body->CreateFixture(&fixDef);
        }
    }
    
    return body;
}

-(b2Body*) createBody : (NSString*) name withWorld : (b2World*) world withPosition : (b2Vec2) position{
    BodyTemplate* bodyTemplate = [_bodies valueForKey:name];
    
    b2BodyDef bodyDef;
    bodyDef.type = bodyTemplate.isDynamic ? b2_dynamicBody : b2_staticBody;
    bodyDef.position = position;
    
    b2Body* body = world->CreateBody(&bodyDef);
    
    for(FixtureTemplate* ft in bodyTemplate.fixtureTemplates){
        for(CircleTemplate* ct in ft.circles){
            b2CircleShape cShape;
            b2FixtureDef fixDef;
            
            cShape.m_p = b2Vec2(ct.x / mRatio, ct.y / mRatio);
            cShape.m_radius = ct.radius / mRatio;
            
            fixDef.shape = &cShape;
            fixDef.density = ft.density;
            fixDef.friction = ft.friction;
            fixDef.restitution = ft.restitution;
            
            body->CreateFixture(&fixDef);
        }
        for(PolygonTemplate* pt in ft.polygons){
            b2PolygonShape pShape;
            b2FixtureDef fixDef;
            
            b2Vec2 vertices[pt.vertices.count];
            
            for(int i = 0; i < pt.vertices.count; i++){
                Vector2f* v = [pt.vertices objectAtIndex:i];
                vertices[i] = b2Vec2(v.x / mRatio, v.y / mRatio);
            }
            
            pShape.Set(vertices, pt.vertices.count);
            
            fixDef.shape = &pShape;
            fixDef.density = ft.density;
            fixDef.friction = ft.friction;
            fixDef.restitution = ft.restitution;
            
            body->CreateFixture(&fixDef);
        }
    }
    
    return body;
}

-(b2Body*) createBody : (NSString*) name withWorld : (b2World*) world withPosition : (b2Vec2) position withRotation : (float) rotation{
    BodyTemplate* bodyTemplate = [_bodies valueForKey:name];
    
    b2BodyDef bodyDef;
    bodyDef.type = bodyTemplate.isDynamic ? b2_dynamicBody : b2_staticBody;
    bodyDef.position = position;
    bodyDef.angle = rotation;
    
    b2Body* body = world->CreateBody(&bodyDef);
    
    for(FixtureTemplate* ft in bodyTemplate.fixtureTemplates){
        for(CircleTemplate* ct in ft.circles){
            b2CircleShape cShape;
            b2FixtureDef fixDef;
            
            cShape.m_p = b2Vec2(ct.x / mRatio, ct.y / mRatio);
            cShape.m_radius = ct.radius / mRatio;
            
            fixDef.shape = &cShape;
            fixDef.density = ft.density;
            fixDef.friction = ft.friction;
            fixDef.restitution = ft.restitution;
            
            body->CreateFixture(&fixDef);
        }
        for(PolygonTemplate* pt in ft.polygons){
            b2PolygonShape pShape;
            b2FixtureDef fixDef;
            
            b2Vec2 vertices[pt.vertices.count];
            
            for(int i = 0; i < pt.vertices.count; i++){
                Vector2f* v = [pt.vertices objectAtIndex:i];
                vertices[i] = b2Vec2(v.x / mRatio, v.y / mRatio);
            }
            
            pShape.Set(vertices, pt.vertices.count);
            
            fixDef.shape = &pShape;
            fixDef.density = ft.density;
            fixDef.friction = ft.friction;
            fixDef.restitution = ft.restitution;
            
            body->CreateFixture(&fixDef);
        }
    }
    
    return body;
}

-(void) createPerimiterBody: (TrackCollisionTemplate*)cTemp withWorld : (b2World*) world{
    b2BodyDef oBodyDef;
    oBodyDef.type = b2_staticBody;
    oBodyDef.position = b2Vec2(cTemp.xOutside / mRatio, cTemp.yOutside / mRatio);
    
    b2Body* body = world->CreateBody(&oBodyDef);
    
    //outside
    b2ChainShape oShape;
    b2FixtureDef oFixDef;
    
    b2Vec2 oVertices[cTemp.outside.count];
    for(int o = 0; o < cTemp.outside.count; o++){
        Vector2f* v = [cTemp.outside objectAtIndex:o];
        oVertices[o] = b2Vec2(v.x / mRatio, v.y / mRatio);
    }
    
    oShape.CreateLoop(oVertices, cTemp.outside.count);
    
    oFixDef.shape = &oShape;
    oFixDef.density = 1;
    oFixDef.friction = 1;
    oFixDef.restitution = 0;
    
    body->CreateFixture(&oFixDef);
    
    b2BodyDef iBodyDef;
    iBodyDef.type = b2_staticBody;
    iBodyDef.position = b2Vec2(cTemp.xInside / mRatio, cTemp.yInside / mRatio);
    
    body = world->CreateBody(&iBodyDef);
    
    //inside
    b2ChainShape iShape;
    b2FixtureDef iFixDef;
    
    b2Vec2 iVertices[cTemp.inside.count];
    for(int i = 0; i < cTemp.inside.count; i++){
        Vector2f* v = [cTemp.inside objectAtIndex:i];
        iVertices[i] = b2Vec2(v.x / mRatio, v.y / mRatio);
    }
    
    iShape.CreateLoop(iVertices, cTemp.inside.count);
    
    iFixDef.shape = &iShape;
    iFixDef.density = 1;
    iFixDef.friction = 1;
    iFixDef.restitution = 0;
    
    body->CreateFixture(&iFixDef);
}

-(void) parseXMLFile : (NSURL*) xmlPath{
    self.parser = [[NSXMLParser alloc] initWithContentsOfURL:xmlPath];
    self.parser.delegate = self;
    [self.parser parse];
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    _element = elementName;
    
    if([elementName isEqualToString:@"body"]){
        _currentFixtures = [[NSMutableArray alloc] init];
        _currentBody = [[BodyTemplate alloc] init];
        _currentBody.name = [attributeDict valueForKey:@"name"];
        _currentBody.isDynamic = [attributeDict valueForKey:@"dynamic"].boolValue;
    }else if([elementName isEqualToString:@"fixture"]){
        _currentFixture = [[FixtureTemplate alloc] init];
        _currentPolygons = [[NSMutableArray alloc] init];
        _currentCircles = [[NSMutableArray alloc] init];
        _currentFixture.density = [attributeDict valueForKey:@"density"].floatValue;
        _currentFixture.friction = [attributeDict valueForKey:@"friction"].floatValue;
        _currentFixture.restitution = [attributeDict valueForKey:@"restitution"].floatValue;
        _currentFixture.fixtureType = [attributeDict valueForKey:@"type"];
    }else if([elementName isEqualToString:@"polygon"]){
        _currentPolygonVertices = [[NSMutableArray alloc] init];
        _currentCircles = [[NSMutableArray alloc] init];

    }else if ([elementName isEqualToString:@"vertex"]){
        Vector2f* v = [[Vector2f alloc] init];
        v.x = [attributeDict valueForKey:@"x"].floatValue;
        v.y = [attributeDict valueForKey:@"y"].floatValue;
        [_currentPolygonVertices addObject:v];
    }else if([elementName isEqualToString:@"circle"]){
        CircleTemplate* circleTemplate = [[CircleTemplate alloc] init];
        circleTemplate.radius = [attributeDict valueForKey:@"r"].floatValue;
        circleTemplate.x = [attributeDict valueForKey:@"x"].floatValue;
        circleTemplate.y = [attributeDict valueForKey:@"y"].floatValue;
        [_currentCircles addObject:circleTemplate];
    }
    
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    
    if([elementName isEqualToString:@"polygon"]){
        PolygonTemplate* polygonTemplate = [[PolygonTemplate alloc] init];
        polygonTemplate.vertices = _currentPolygonVertices;
        [_currentPolygons addObject:polygonTemplate];
    }else if([elementName isEqualToString:@"fixture"]){
        _currentFixture.polygons = _currentPolygons;
        _currentFixture.circles = _currentCircles;
        [_currentFixtures addObject:_currentFixture];
    }else if([elementName isEqualToString:@"body"]){
        _currentBody.fixtureTemplates = _currentFixtures;
        [_bodies setObject:_currentBody forKey:_currentBody.name];
    }
    
}

-(void) deleteBody:(NSString *)name{
    [_bodies removeObjectForKey:name];
}
-(void) deleteAllBodies{
    [_bodies removeAllObjects];
}

@end

@implementation BodyTemplate

-(id) init{
    self = [super init];
    if(self){
        _fixtureTemplates = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
@implementation FixtureTemplate

-(id) init{
    self = [super init];
    if(self){
        _polygons = [[NSMutableArray alloc] init];
        _circles = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
@implementation PolygonTemplate

-(id) init{
    self = [super init];
    if(self){
        _vertices = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
@implementation CircleTemplate

-(id) init{
    self = [super init];
    if(self){
    }
    return self;
}

@end
@implementation Vector2f

-(id) init{
    self = [super init];
    if(self){
    }
    return self;
}

@end
