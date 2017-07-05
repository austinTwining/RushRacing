#version 300 es
precision mediump float;

in vec2 position;
out vec4 vertexColor;

uniform vec4 color;
uniform mat4 projection;
uniform mat4 view;

void main()
{
    gl_Position = projection * view * vec4(position.x, position.y, 0.0, 1.0);
    vertexColor = color;
}
