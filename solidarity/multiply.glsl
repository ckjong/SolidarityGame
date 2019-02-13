vec4 effect( vec4 col, Image texture, vec2 texturePos, vec2 screenPos )
{
    // simply return the color at the current coordinates:
    vec4 pixel = Texel(texture, texturePos );
    float a = 0.5;
    pixel.r = ((pixel.r) * (255)) / 255;
    pixel.g = ((pixel.g) * (100)) / 255;
    pixel.b = ((pixel.b) * (100)) / 255;
    return pixel;
}
