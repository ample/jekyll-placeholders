module Jekyll
  module Placeholders
    class Generator < Jekyll::Generator
      attr_accessor :site

      def generate(site)
        Jekyll::Placeholders::Collections.new(site)
      end

    end
  end
end