module MESS
  class Translator
    def translate(document)
      @doc = document
      @doc.styles.each do |style|
        # style.render
      end
      @doc
    end
  end
end