#version 300 es
precision mediump float;

in vec4 vertexColor;

out lowp vec4 fragmentColor;

void main()
{
    fragmentColor = vertexColor;
}
