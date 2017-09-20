#version 300 es
precision highp float;

layout (location = 0) in vec3 position;
layout (location = 1) in vec2 texCoords;

out vec2 pass_texCoords;

uniform mat4 projection;
uniform mat4 model;

uniform mat4 tex_model;

void main()
{
    pass_texCoords = vec4(tex_model * vec4(texCoords.x, texCoords.y, 0.0, 1.0)).xy;
    gl_Position = projection * model * vec4(position.x, position.y, position.z, 1.0);
}
