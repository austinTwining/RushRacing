#version 300 es
precision highp float;

in lowp vec2 pass_texCoords;

out lowp vec4 fragmentColor;

uniform vec3 colour;
uniform sampler2D fontAtlas;

const float width = 0.5;
const float edge = 0.1;

void main()
{
    float d = 1.0 - texture(fontAtlas, pass_texCoords).a;
    float alpha = 1.0 - smoothstep(width, width + edge, d);
    
    fragmentColor = vec4(colour, alpha);
}
