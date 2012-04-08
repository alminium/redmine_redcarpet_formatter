# -*- coding: utf-8 -*-
require 'redcarpet'

class HTMLwithSyntaxHighlighting < Redcarpet::Render::HTML
  def block_code(code, language)
    if language != nil 
      "<pre>\n<code class='#{language} syntaxhl'>" \
        + Redmine::SyntaxHighlighting.highlight_by_language(code, language) \
        + "</code>\n</pre>"
    else 
      "<pre>\n" + code + "</pre>"
    end
  end
  def block_quote(quote)
    "<blockquote>\n" << quote.gsub(/\n([^<])/,'<br>\1') << "</blockquote>\n"
  end
end  

module RedmineRedcarpetFormatter
  class WikiFormatter
    #    include ActionView::Helpers::TagHelper

    def initialize(text)
      @text = text
    end

    def to_html(&block)
      markdown = Redcarpet::Markdown.new(HTMLwithSyntaxHighlighting, :autolink => true, :space_after_headers => true,:fenced_code_blocks => true, :tables => true, :strikethrough => true, :superscript => true)
      markdown.render(@text)
    rescue => e
      return("<pre>problem parsing wiki text: #{e.message}\n"+
             "original text: \n"+
               @text+
               "</pre>")
    end

    def get_section(index)
      section = extract_sections(index)[1]
      hash = Digest::MD5.hexdigest(section)
      return section, hash
    end

    def update_section(index, update, hash=nil)
      t = extract_sections(index)
      if hash.present? && hash != Digest::MD5.hexdigest(t[1])
        raise Redmine::WikiFormatting::StaleSectionError
      end
      t[1] = update unless t[1].blank?
      t.reject(&:blank?).join "\n\n"
    end

    private

    def extract_sections(index)
      selected, before, after = [[],[],[]]
      pre = :none
      state = 'before'

      selected_level = 0
      header_count = 0

      @text.each do |line|

        if line =~ /^(~~~|```)/
          pre = pre == :pre ? :none : :pre
        elsif pre == :none
          
          level = if line =~ /^(#+)/
                    $1.length
                  elsif line.strip =~ /^=+$/ 
                    line = eval(state).pop + line
                    1
                  elsif line.strip =~ /^-+$/ 
                    line = eval(state).pop + line
                    2
                  else
                    nil
                  end
          unless level.nil?
            if level <= 4
              header_count += 1
              if state == 'selected' and selected_level >= level
                state = 'after'
              elsif header_count == index
                state = 'selected'
                selected_level = level
              end
            end
          end
        end

        eval("#{state} << line")
      end

      [before, selected, after].map{|x| x.join.strip}
    end
  end
end
