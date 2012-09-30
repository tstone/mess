module MESS
  class Renderer
    def render(document)
      @doc = document
      @css = ""
      @doc.styles.each do |style|
        @css << style.render + "\n"
      end
      @css.strip
    end
  end
end