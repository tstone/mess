module MESS
  class Renderer
    def render(document)
      @doc = document
      @css = ""
      @doc.styles.each do |style, instance|
        @css << instance.render
      end
      @css
    end
  end
end