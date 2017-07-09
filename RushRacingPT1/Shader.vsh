#version 300 es
precision highp float;

in vec3 position;
in vec2 texCoords;

out vec2 pass_texCoords;

uniform mat4 model;
uniform mat4 projection;
uniform mat4 view;

void main()
{
    pass_texCoords = texCoords;
    gl_Position = projection * view * model * vec4(position.x, position.y, position.z, 1.0);
}
