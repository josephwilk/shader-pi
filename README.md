# Shader Pi

Shaders for use with SonicPi


![](http://s21.postimg.org/jv3xg52sn/Screen_Shot_2014_10_04_at_12_55_18.png)


### Example Code

```ruby
PROJECT_ROOT = "/Users/josephwilk/Workspace/josephwilk/ruby/shader-pi"
$LOAD_PATH.unshift "#{PROJECT_ROOT}/lib/"
require "shader_pi"

@shader = ShaderWindow.fullscreen("#{PROJECT_ROOT}/shaders/electric_sinusoid.glsl", {})

at_exit do
  @shader.close
end
```

### Example Shader

```glsl
//https://www.shadertoy.com/view/XdXXzr
//Electric Sinusoid

varying vec2 var_TexCoord;
uniform int in_WindowWidth;
uniform int in_WindowHeight;

void main(void)
{
	vec2 uv = var_TexCoord;
  float x = uv.x / float(in_WindowWidth);
  float y = uv.x / float(in_WindowHeight);
	float bg = (cos(uv.x*3.14159*2.0) + sin((uv.y)*3.14159)) * 0.15;
	
	vec2 p = uv*2.0 - 1.0;
	p *= 15.0;
	vec2 sfunc = vec2(p.x, p.y + 5.0*sin(uv.x*10.0-in_GlobalTime*2.0 + cos(in_GlobalTime*7.0) )+2.0*cos(uv.x*25.0+in_GlobalTime*4.0));
	sfunc.y *= uv.x*2.0+0.05;
	sfunc.y *= 2.0 - uv.x*2.0+0.05;
	sfunc.y /= 0.1; // Thickness fix
	
	vec3 c = vec3(abs(sfunc.y));
	c = pow(c, vec3(-0.5));
	c *= vec3(0.3,0.85,1.0);
	//c += vec3(bg, bg*0.8, bg*0.4);

	gl_FragColor = vec4(c,1.0);
}
```
