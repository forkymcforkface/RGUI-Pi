precision mediump float;
varying vec2 tex_coord;
#if defined(VERTEX)
attribute vec2 TexCoord;
attribute vec2 VertexCoord;
uniform mat4 MVPMatrix;
void main()
{
    gl_Position = MVPMatrix * vec4(VertexCoord, 0.0, 1.0);
    tex_coord = TexCoord;
}
#elif defined(FRAGMENT)
uniform sampler2D Texture;
void main()
{
    gl_FragColor = texture2D(Texture, tex_coord);
    
    /* Replace color */
    /* if (gl_FragColor.r <= 0.1 && gl_FragColor.g <= 0.1 && gl_FragColor.b <= 0.1) */
    if (gl_FragColor.r == 0.0 && gl_FragColor.g == 0.0 && gl_FragColor.b == 0.0)
        gl_FragColor = vec4(0.2, 0.2, 0.2, 1.0);
}
#endif
