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
              url = ::Jekyll::URL.new({
                :template     => slugify_tpl(tpl, tokens),
                :placeholders => get_placeholders(tokens, doc)
              }).to_s
              doc.instance_variable_set('@url', url)
            end

          end if site.config.dig('collections', type).keys.include? 'permalink'
        end
      end

      private

        def get_template(type)
          @site.config.dig('collections', type, 'permalink')
        end

        def get_symbols(tpl)
          tpl.scan(/(\(:.*\)|:[^\/]*)/).flatten rescue nil
        end

        def get_placeholders(tokens, doc)
          Hash[ *tokens.collect{|v|
            if v[0] == ':'
              [ v[1..-1], doc.data.dig(v[1..-1]) ]
            else
              [ slugify_token(v), deep_dig(doc, v) ]
            end
          }.flatten ].
          merge(doc.url_placeholders).
          each_with_object({}){|(k,v), h| h[k.to_sym] = v }
        end

        def deep_dig(doc, str)
          tokens = str[1..-2].split('/').collect{|s| s[1..-1] }
          tokens.map! do |s|
            if s.to_i.to_s == s
              s.to_i
            else
              s
            end
          end
          doc.data.dig(*tokens)
        end

        def slugify_tpl(tpl, tokens)
          tokens.each do |token|
            if token[0] == '('
              tpl = tpl.sub(token, ":#{slugify_token(token)}")
            end
          end
          tpl
        end

        def slugify_token(token)
          token.gsub(/[^a-zA-Z0-9]/, '')
        end

    end
  end
end
