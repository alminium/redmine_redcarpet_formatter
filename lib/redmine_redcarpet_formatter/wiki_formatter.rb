# -*- coding: utf-8 -*-
require 'redcarpet'

module RedmineRedcarpetFormatter
  class WikiFormatter
    def initialize(text)
      @text = text

    end

    def to_html(&block)
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true,:fenced_code_blocks => true, :tables => true, :strikethrough => true, :superscript => true)
      markdown.render(@text)
    rescue => e
      return("<pre>problem parsing wiki text: #{e.message}\n"+
             "original text: \n"+
             @text+
             "</pre>")
    end
  end
end
