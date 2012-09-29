module MESS
  class Renderer
    def render(document)
      @doc = document
      @css = ""
      @doc.styles.each do |style, instance|
        @css << instance.render + "\n"
      end
      @css.strip
    end
  end
end