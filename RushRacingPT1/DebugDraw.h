//
//  DebugDraw.h
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-07-05.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#ifndef DebugDraw_h
#define DebugDraw_h

#include <Box2D/Box2D.h>
#import <OpenGLES/ES3/glext.h>
#import <GLKit/GLKit.h>

class DebugDraw : public b2Draw{
    
    GLfloat mRatio;
    GLKMatrix4 mView;
    
public:
    
    DebugDraw();
    DebugDraw(GLfloat ratio);
    
    void setViewMatrix(GLKMatrix4 view);
    
    /// Draw a closed polygon provided in CCW order.
    virtual void DrawPolygon(const b2Vec2* vertices, int32 vertexCount, const b2Color& color);
    
    /// Draw a solid closed polygon provided in CCW order.
    virtual void DrawSolidPolygon(const b2Vec2* vertices, int32 vertexCount, const b2Color& color);
    
    /// Draw a circle.
    virtual void DrawCircle(const b2Vec2& center, float32 radius, const b2Color& color);
    
    /// Draw a solid circle.
    virtual void DrawSolidCircle(const b2Vec2& center, float32 radius, const b2Vec2& axis, const b2Color& color);
    
    /// Draw a line segment.
    virtual void DrawSegment(const b2Vec2& p1, const b2Vec2& p2, const b2Color& color);
    
    /// Draw a transform. Choose your own length scale.
    /// @param xf a transform.
    virtual void DrawTransform(const b2Transform& xf){}
    
    /// Draw a point.
    virtual void DrawPoint(const b2Vec2& p, float32 size, const b2Color& color){}
    
};


#endif /* DebugDraw_h */
