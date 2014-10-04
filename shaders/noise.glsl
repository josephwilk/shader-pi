// Use 3D Simplex noise, even though the shader operates on a 2D
// texture, since then we can make the Z-coordinate act as time.
#include <noise3d>

uniform sampler2D in_Texture;

uniform vec4 in_BlobColor;
uniform float in_Beat;

varying vec2 var_TexCoord;

void main()
{
  gl_FragColor = texture2D(in_Texture, var_TexCoord);

  // First layer. faster, low intensity, small scale blobbing.
  // Use [x, y, t] to create a 2D noise that varies over time.
  vec3 position1 = vec3(var_TexCoord * 25.0, in_T * 1.6);

  // Gives range 0.75..1.25
  float brightness1 = snoise(position1) / 4.0 + 1.0;

  // Second layer - slow, high intensity, large-scale blobbing
  // This decides where the first layer will be "seen"
  // Use [x, y, t] to create a 2D noise that varies over time.
  vec3 position2 = vec3(var_TexCoord * 3.0, in_T);

  // Gives range 0.3..1.3
  float brightness2 = snoise(position2) / 1.0 + 0.1;

  if(brightness2 > 0.8)
  {
    gl_FragColor.rgb += in_BlobColor.rgb * in_Beat;
    gl_FragColor.rgb *= brightness1 * brightness2;
  }
}
