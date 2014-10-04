PROJECT_ROOT = "/Users/josephwilk/Workspace/josephwilk/ruby/shader-pi"
$LOAD_PATH.unshift "#{PROJECT_ROOT}/lib/"
require "shader_pi"

@shader = ShaderWindow.fullscreen("#{PROJECT_ROOT}/shaders/electric_sinusoid.glsl", {})

at_exit do
  @shader.close
end