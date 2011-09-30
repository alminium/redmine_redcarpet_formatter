# -*- coding: utf-8 -*-
require 'redcarpet'
require 'albino'

class HTMLwithAlbino < Redcarpet::Render::HTML
  def block_code(code, language)
    Albino.colorize(code, (language!=nil)?language:'text')
  end
end  

module RedmineRedcarpetFormatter
  class WikiFormatter
#    include ActionView::Helpers::TagHelper
    
    def initialize(text)
      @text = text

    end

    def to_html(&block)
      markdown = Redcarpet::Markdown.new(HTMLwithAlbino, :autolink => true, :space_after_headers => true,:fenced_code_blocks => true, :tables => true, :strikethrough => true, :superscript => true)
      markdown.render(@text)
    rescue => e
      return("<pre>problem parsing wiki text: #{e.message}\n"+
             "original text: \n"+
             @text+
             "</pre>")
    end
  end
end
