//
//  DebugDraw.cpp
//  RushRacingPT1
//
//  Created by Austin-James Twining on 2017-07-05.
//  Copyright © 2017 Austin-James Twining. All rights reserved.
//

#include <stdio.h>
#include "DebugDraw.h"

#import "ResourceManager.h"

DebugDraw::DebugDraw() : mRatio(32.0f){
    
}

DebugDraw::DebugDraw(GLfloat ratio){
    mRatio = ratio;
}

void DebugDraw::setViewMatrix(GLKMatrix4 view){
    mView = view;
}

/// Draw a closed polygon provided in CCW order.
void DebugDraw::DrawPolygon(const b2Vec2* vertices, int32 vertexCount, const b2Color& color){
    //set up vertex array
    GLfloat glverts[16]; //allow for polygons up to 8 vertices
    
    //fill in vertex positions as directed by Box2D
    for (int i = 0; i < vertexCount; i++) {
        glverts[i*2]   = vertices[i].x * mRatio;
        glverts[i*2+1] = vertices[i].y * mRatio;
    }
    
    [[ResourceManager getShader:@"debug"] start];
    
    GLuint VertexArrayID;
    glGenVertexArrays(1, &VertexArrayID);
    glBindVertexArray(VertexArrayID);
    
    GLuint vertexbuffer;
    glGenBuffers(1, &vertexbuffer);
    glBindBuffer(GL_ARRAY_BUFFER, vertexbuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(glverts), glverts, GL_STATIC_DRAW);
    
    // 1rst attribute buffer : vertices
    glEnableVertexAttribArray(0);
    glBindBuffer(GL_ARRAY_BUFFER, vertexbuffer);
    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 0, (void*)0);
    
    glEnable(GL_BLEND);
    glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    [[ResourceManager getShader:@"debug"] setMatrix4:"view" :mView];
    
    //draw lines
    [[ResourceManager getShader:@"debug"] setVector4f:"color" :GLKVector4Make(color.r, color.g, color.b, 1.0f)];
    glDrawArrays(GL_LINE_LOOP, 0, vertexCount);
    
    glDisableVertexAttribArray(0);
    
    [[ResourceManager getShader:@"debug"] stop];
    
    glDeleteVertexArrays(1, &VertexArrayID);
    glDeleteBuffers(1, &vertexbuffer);
}

/// Draw a solid closed polygon provided in CCW order.
void DebugDraw::DrawSolidPolygon(const b2Vec2* vertices, int32 vertexCount, const b2Color& color){
    //set up vertex array
    GLfloat glverts[16]; //allow for polygons up to 8 vertices
    
    //fill in vertex positions as directed by Box2D
    for (int i = 0; i < vertexCount; i++) {
        glverts[i*2]   = vertices[i].x * mRatio;
        glverts[i*2+1] = vertices[i].y * mRatio;
    }
    
    [[ResourceManager getShader:@"debug"] start];
    
    GLuint VertexArrayID;
    glGenVertexArrays(1, &VertexArrayID);
    glBindVertexArray(VertexArrayID);
    
    GLuint vertexbuffer;
    glGenBuffers(1, &vertexbuffer);
    glBindBuffer(GL_ARRAY_BUFFER, vertexbuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(glverts), glverts, GL_STATIC_DRAW);
    
    // 1rst attribute buffer : vertices
    glEnableVertexAttribArray(0);
    glBindBuffer(GL_ARRAY_BUFFER, vertexbuffer);
    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 0, (void*)0);
    
    glEnable(GL_BLEND);
    glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    [[ResourceManager getShader:@"debug"] setMatrix4:"view" :mView];
    
    //draw solid area
    [[ResourceManager getShader:@"debug"] setVector4f:"color" :GLKVector4Make(color.r, color.g, color.b, 0.5f)];
    glDrawArrays(GL_TRIANGLE_FAN, 0, vertexCount);
    
    //draw lines
    [[ResourceManager getShader:@"debug"] setVector4f:"color" :GLKVector4Make(color.r, color.g, color.b, 1.0f)];
    glDrawArrays(GL_LINE_LOOP, 0, vertexCount);
    
    glDisableVertexAttribArray(0);
    
    [[ResourceManager getShader:@"debug"] stop];
    
    glDeleteVertexArrays(1, &VertexArrayID);
    glDeleteBuffers(1, &vertexbuffer);
}

/// Draw a circle.
void DebugDraw::DrawCircle(const b2Vec2& center, float32 radius, const b2Color& color){
    GLint numSegments = 32.0f;
    GLint numVertices = numSegments + 2;
    
    GLfloat doublePi = 2.0f * b2_pi;
    
    GLfloat glverts[numVertices*2];
    
    glverts[0] = center.x * mRatio;
    glverts[1] = center.y * mRatio;
    for(int i = 1; i < numVertices; i++){
        glverts[i*2] = (center.x + (radius * cosf(i * doublePi / numSegments))) * mRatio;
        glverts[i*2+1] = (center.y + (radius * sinf(i * doublePi / numSegments))) * mRatio;
    }
    
    [[ResourceManager getShader:@"debug"] start];
    
    GLuint VertexArrayID;
    glGenVertexArrays(1, &VertexArrayID);
    glBindVertexArray(VertexArrayID);
    
    GLuint vertexbuffer;
    glGenBuffers(1, &vertexbuffer);
    glBindBuffer(GL_ARRAY_BUFFER, vertexbuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(glverts), glverts, GL_STATIC_DRAW);
    
    // 1rst attribute buffer : vertices
    glEnableVertexAttribArray(0);
    glBindBuffer(GL_ARRAY_BUFFER, vertexbuffer);
    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 0, (void*)0);
    
    glEnable(GL_BLEND);
    glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    [[ResourceManager getShader:@"debug"] setMatrix4:"view" :mView];
    
    //draw lines
    [[ResourceManager getShader:@"debug"] setVector4f:"color" :GLKVector4Make(color.r, color.g, color.b, 1.0f)];
    glDrawArrays(GL_LINE_LOOP, 0, numVertices);
    
    glDisableVertexAttribArray(0);
    
    [[ResourceManager getShader:@"debug"] stop];
    
    glDeleteVertexArrays(1, &VertexArrayID);
    glDeleteBuffers(1, &vertexbuffer);
}

void DebugDraw::DrawSolidCircle(const b2Vec2& center, float32 radius, const b2Vec2& axis, const b2Color& color){
    GLint numSegments = 32.0f;
    GLint numVertices = numSegments + 2;
    
    GLfloat doublePi = 2.0f * b2_pi;
    
    GLfloat glverts[numVertices*2];
    
    glverts[0] = center.x * mRatio;
    glverts[1] = center.y * mRatio;
    for(int i = 1; i < numVertices; i++){
        glverts[i*2] = (center.x + (radius * cosf(i * doublePi / numSegments))) * mRatio;
        glverts[i*2+1] = (center.y + (radius * sinf(i * doublePi / numSegments))) * mRatio;
    }
    
    [[ResourceManager getShader:@"debug"] start];
    
    GLuint VertexArrayID;
    glGenVertexArrays(1, &VertexArrayID);
    glBindVertexArray(VertexArrayID);
    
    GLuint vertexbuffer;
    glGenBuffers(1, &vertexbuffer);
    glBindBuffer(GL_ARRAY_BUFFER, vertexbuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(glverts), glverts, GL_STATIC_DRAW);
    
    // 1rst attribute buffer : vertices
    glEnableVertexAttribArray(0);
    glBindBuffer(GL_ARRAY_BUFFER, vertexbuffer);
    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 0, (void*)0);
    
    glEnable(GL_BLEND);
    glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    [[ResourceManager getShader:@"debug"] setMatrix4:"view" :mView];
    
    //draw solid area
    [[ResourceManager getShader:@"debug"] setVector4f:"color" :GLKVector4Make(color.r, color.g, color.b, 0.5f)];
    glDrawArrays(GL_TRIANGLE_FAN, 0, numVertices);
    
    //draw lines
    [[ResourceManager getShader:@"debug"] setVector4f:"color" :GLKVector4Make(color.r, color.g, color.b, 1.0f)];
    glDrawArrays(GL_LINE_LOOP, 0, numVertices);
    
    glDisableVertexAttribArray(0);
    
    DrawSegment(center,center+radius*axis,color);
    
    [[ResourceManager getShader:@"debug"] stop];
    
    glDeleteVertexArrays(1, &VertexArrayID);
    glDeleteBuffers(1, &vertexbuffer);
}

void DebugDraw::DrawSegment(const b2Vec2& p1, const b2Vec2& p2, const b2Color& color){
    
    GLfloat glverts[] = {
        p1.x * mRatio, p1.y * mRatio,
        p2.x * mRatio, p2.y * mRatio
    };
    
    [[ResourceManager getShader:@"debug"] start];
    
    GLuint VertexArrayID;
    glGenVertexArrays(1, &VertexArrayID);
    glBindVertexArray(VertexArrayID);
    
    GLuint vertexbuffer;
    glGenBuffers(1, &vertexbuffer);
    glBindBuffer(GL_ARRAY_BUFFER, vertexbuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(glverts), glverts, GL_STATIC_DRAW);
    
    // 1rst attribute buffer : vertices
    glEnableVertexAttribArray(0);
    glBindBuffer(GL_ARRAY_BUFFER, vertexbuffer);
    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 0, (void*)0);
    
    glEnable(GL_BLEND);
    glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    [[ResourceManager getShader:@"debug"] setMatrix4:"view" :mView];
    
    //draw lines
    [[ResourceManager getShader:@"debug"] setVector4f:"color" :GLKVector4Make(color.r, color.g, color.b, 1.0f)];
    glDrawArrays(GL_LINES, 0, 2);
    
    glDisableVertexAttribArray(0);
    
    [[ResourceManager getShader:@"debug"] stop];

    glDeleteVertexArrays(1, &VertexArrayID);
    glDeleteBuffers(1, &vertexbuffer);
}
