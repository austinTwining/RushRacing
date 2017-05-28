#version 300 es
precision mediump float;

in lowp vec2 pass_texCoords;

out lowp vec4 fragmentColor;

uniform sampler2D textureSampler;

void main()
{
    fragmentColor = texture(textureSampler, pass_texCoords);
}
