require "ashton"

class ShaderWindow < Gosu::Window
  def initialize(shader_file, uniforms)
    super 800, 600, false
    shader_fragement =<<-END
#version 110
uniform float in_T;
#{File.read(shader_file)}
END
    @uniforms   = uniforms
    @shader = Ashton::Shader.new fragment: shader_fragement, uniforms: @uniforms
    @background = Gosu::Image.new(self, "/Users/josephwilk/Workspace/repl-electric/shadertone/textures/buddha_3.jpg", true)
    @start_time = Time.now
    update
  end

  def update
    $gosu_blocks.clear if defined? $gosu_blocks # Workaround for Gosu bug (0.7.45)
    @shader.t = Time.now - @start_time
    @uniforms.each {|k,v| @shader.send(:"#{k}=", v)}
  end

  def draw
    post_process @shader do
      @background.draw 0, 0, 0, width.fdiv(@background.width), height.fdiv(@background.height)
    end
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end

  def method_missing(fun, *args, &block)
    key = "#{fun}".gsub(/=$/, "").to_sym
    if @uniforms.keys.include?(key)
      @uniforms[key] = args.first
    else
      super
    end
  end

  def self.fullscreen(shader_file, uniforms)
    Thread.new do
      $window.close if $window
      $window ||= self.new(shader_file, uniforms)
      $window.show
    end
    $window
  end
end