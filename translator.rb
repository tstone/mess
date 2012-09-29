module MESS
  class Translator
    def translate(document)
      @doc = document
      @doc.styles.each do |style|
        puts style
      end
    end
  end
end