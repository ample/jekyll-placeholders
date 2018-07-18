module Jekyll
  module Placeholders
    class Collections
      attr_accessor :site

      def initialize(site)
        @site = site
        perform
      end

      def perform
        site.collections.each do |type, collection|
          collection.docs.each do |doc|

            tpl = get_template(type)
            tokens = get_symbols(tpl)

            unless (tokens - doc.url_placeholders.keys).empty?
              doc.instance_variable_set('@url', ::Jekyll::URL.new({
                :template     => tpl,
                :placeholders => get_placeholders(tokens, doc)
                }).to_s)
            end

          end
        end
      end

      private

        def get_template(type)
          @site.config.dig('collections', type, 'permalink')
        end

        def get_symbols(tpl)
          tpl.scan(/:[^\/]*/).collect{|s| s[1..-1] }
        end

        def get_placeholders(tokens, doc)
          Hash[ *tokens.collect { |v| [ v, doc.data.dig(v) ] }.flatten ].
            merge(doc.url_placeholders).
            each_with_object({}){|(k,v), h| h[k.to_sym] = v}
        end

    end
  end
end
