# Redmine Redcarpet formatter

require 'redmine'
require 'redmine/wiki_formatting/markdown/formatter'
require 'redmine/wiki_formatting/markdown/helper'


Redmine::Plugin.register :redmine_redcarpet_formatter do
  name 'Redcarpet Markdown Wiki formatter'
  author 'Mikoto Misaka'
  description 'Markdown wiki formatting by Redcarpet for Redmine'
  version '2.0.0'

  wiki_format_provider 'markdown', Redmine::WikiFormatting::Markdown::Formatter, Redmine::WikiFormatting::Markdown::Helper

end
