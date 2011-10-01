# -*- coding: utf-8 -*-
require 'redcarpet'

class HTMLwithSyntaxHighlighting < Redcarpet::Render::HTML
  def block_code(code, language)
    "<pre>\n<code class='#{language} syntaxhl'>" \
      + Redmine::SyntaxHighlighting.highlight_by_language(code, language) \
      + "</code>\n</pre>"
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
  end
end
